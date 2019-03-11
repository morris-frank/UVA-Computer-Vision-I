function [M_best, t_best, performance, tform] = ransac(fa, fb, matches, N, P)

Na = size(fa);
Nb = size(fb);
T_size = size(matches);

%fa_ix = matches(1, :);
%fb_ix = matches(2, :);
performance = 0;
for i=1:N
    perm = randperm(T_size(2)); 
    indexes = perm(1:P);
    fa_ix = matches(1, indexes);
    fb_ix = matches(2, indexes);
    
    fa_p = fa(:, fa_ix);
    fb_p = fb(:, fb_ix);
    for j=1:P
        
       A(2*j-1, :) = [fa_p(1, j), fa_p(2, j), 0, 0, 1, 0];
       A(2*j, :) = [0, 0, fa_p(1, j), fa_p(2, j), 0, 1];
       
       b(2*j-1) = [fb_p(1, j)];
       b(2*j) = [fb_p(2, j)];
       
    end
    %size(A)
    %size(b)
    x = pinv(A)*b';
    
    M = [x(1), x(2); x(3), x(4)];
    t = [x(5), x(6)];
    inliers = 0;
    
    for j=1:T_size(2)
        transform_fa = M*fa(1:2,matches(1, j))+t';
        err = norm(transform_fa - fb(1:2,matches(2, j)));
        %err
        if err<11
            inliers = inliers + 1;
        end
          
    end
    if performance < double(inliers)/T_size(2)
        performance = double(inliers)/T_size(2);
        M_best = M;
        t_best = t;
    end
    
end
tform = affine2d([M_best(1) M_best(3) t_best(1); M_best(2) M_best(4) t_best(2); 0 0 1]');
end
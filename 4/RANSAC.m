function [best_transformation] = RANSAC(F1, F2, matches, N, P)
    if nargin < 5
        P = 8;
    end
    if nargin < 4
        N = 40;
    end
    
    M = size(matches, 2);
    sF1 = transpose(F1(1:2, matches(1, :)));
    sF2 = transpose(F2(1:2, matches(2, :)));
    
    A = zeros(2 * M, 6);
    A(1:M, 1:2) = sF1;
    A(M+1:end, 3:4) = sF1;
    A(1:M, 5) = 1;
    A(M+1:end, 6) = 1;
    
    b = zeros(2 * M, 1);
    b(1:M) = sF2(:, 1);
    b(M+1:end) = sF2(:, 2);
    
    best_inliers = 0;
    best_transformation = [];
    ninty_steps = N;
    for n = 1:N
        perm = randperm(M);
        sel = perm(1:P);
        sel = [sel, sel + M];
        
        x = pinv(A(sel, :)) * b(sel);
        
        tF2 = reshape(A * x, [M, 2]);
        D = sqrt(sum((sF2 - tF2).^2, 2));
        inliers = sum(D < 10);
        
        if inliers > best_inliers
            if best_inliers < 0.9 * M && inliers > 0.9 * M
                ninty_steps = n;
            end
            
            best_inliers = inliers;
            best_transformation = x;
        end
    end
    disp(sprintf('Max inliers: %d, steps to 90pc: %d%n', best_inliers, ninty_steps))
end
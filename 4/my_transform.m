function im_transform = my_transform(image1, M, t)

I = im2double(imread(image1));
N = size(I);


corners(1, :) = round(M*[1 1]'+t');
corners(2, :) = round(M*[N(1) 1]'+t');
corners(3, :) = round(M*[N(1) N(2)]'+t');
corners(4, :) = round(M*[1 N(2)]'+t');

t1 = 0;
t2 = 0;
p1 = 0;
p2 = 0;

if min(corners(:, 1)) < 1
    t1 = 1 - min(corners(:, 1));
end

if min(corners(:, 2))<1
    t2 = 1 - min(corners(:, 2));
end

if min(corners(:, 1)) > 1
    p1 = min(corners(:, 1)) - 1;
end

if min(corners(:, 2)) > 1
    p2 = min(corners(:, 2)) - 1;
end

N_new = [max(corners(:, 1))+t1-p1 max(corners(:, 2))+t2-p2];

%{
corners_new(3, :) = [max(corners(:, 1)) max(corners(:, 2))];
corners_new(4, :) = [min(corners(:, 1)) max(corners(:, 2))];
corners_new(2, :) = [max(corners(:, 1)) min(corners(:, 2))];
corners_new(1, :) = [min(corners(:, 1)) min(corners(:, 2))];
%}

I_new = zeros(N_new);

for i=1:N(1)
    for j=1:N(2)
        coord = round(M*[i j]'+t');
       
        I_new(coord(1)+t1-p1, coord(2)+t2-p2) = I(i, j);
    end
end
im_transform = I_new;
       
end




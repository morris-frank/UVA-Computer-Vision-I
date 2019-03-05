function LK = lucas_kanade(image)
I = im2double(rgb2gray(imread(image)));
N = size(I);

sobel_kernel1 = [1, 0, -1; 2, 0, -2; 1, 0, -1];
sobel_kernel2 = [1, 2, 1; 0, 0, 0; -1, -2, -1];


fix(N(1)/ 15);
for i=1:fix(N(1)/ 15)
    for j=1:fix(N(2)/ 15)
        %imshow(I(15*(i-1)+1:15*i,15*(j-1)+1:15*j))
        regions( (i-1)*(fix(N(2)/ 15))+j, :, :) = I(15*(i-1)+1:15*i,15*(j-1)+1:15*j);
        region = I(15*(i-1)+1:15*i,15*(j-1)+1:15*j);
        
        Ix = double(imfilter(region, sobel_kernel1));
        Ix = reshape(Ix, [15*15, 1]);
        A(:, 1) = Ix;
        
        Iy = double(imfilter(region, sobel_kernel2));
        Iy = reshape(Iy, [15*15, 1]);
        A(:, 2) = Iy;
        
        b = -imfilter(region, 0.25*ones(2), 'conv', 'symmetric');
        b = reshape(b, [15*15, 1]);
        %u( (i-1)*(fix(N(2)/ 15))+j, :, :) = pinv(A) * b;
        %u( (i-1)*(fix(N(2)/ 15))+j, :, :) = 
        
        u = mldivide(A,b);
        
        Vx(i, j) = u(1);
        Vy(i, j) = u(2);
            
        
    end
end

quiver(Vx, Vy)
LK = [Vx, Vy];

end
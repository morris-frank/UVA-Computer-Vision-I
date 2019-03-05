function LK = lucas_kanade(image1, image2)
%I = im2double(rgb2gray(imread(image1)));
%I2 = im2double(rgb2gray(imread(image2)));

I = im2double(imread(image1));
I2 = im2double(imread(image2));

N = size(I);

sobel_kernel1 = [1, 0, -1; 2, 0, -2; 1, 0, -1];
sobel_kernel2 = [1, 2, 1; 0, 0, 0; -1, -2, -1];
Ky = fspecial('prewitt');
Kx = Ky';


fix(N(1)/ 15);
for i=1:fix(N(1)/ 15)
    for j=1:fix(N(2)/ 15)
        %imshow(I(15*(i-1)+1:15*i,15*(j-1)+1:15*j))
        %regions( (i-1)*(fix(N(2)/ 15))+j, :, :) = I(15*(i-1)+1:15*i,15*(j-1)+1:15*j);
        region = I(15*(i-1)+1:15*i, 15*(j-1)+1:15*j);
        region2 = I2(15*(i-1)+1:15*i, 15*(j-1)+1:15*j);
        
        Ix = imfilter(region, Kx, 'conv', 'symmetric') ;%+ imfilter(region2, Kx, 'conv', 'symmetric');
        Iy = imfilter(region, Ky, 'conv', 'symmetric') ;%+ imfilter(region2, Ky, 'conv', 'symmetric');
        
        %Ix = double(imfilter(region, sobel_kernel1));
        Ix = reshape(Ix, [15*15, 1]);
        A(:, 1) = Ix;
        
        %Iy = double(imfilter(region, sobel_kernel2));
        Iy = reshape(Iy, [15*15, 1]);
        A(:, 2) = Iy;
        
        b = -(imfilter(region2, 0.25*ones(2), 'conv', 'symmetric') + imfilter(region, -0.25*ones(2), 'conv', 'symmetric'));
  
        b = reshape(b, [15*15, 1]);
        
        
        u = mldivide(A,b);
        
        Vx(15*i, 15*j) = u(1);
        Vy(15*i, 15*j) = u(2);
            
        
    end
end

figure(1)
imshow(image1)
hold on
quiver(Vx, Vy, 8)
hold off
LK = [Vx, Vy];

end
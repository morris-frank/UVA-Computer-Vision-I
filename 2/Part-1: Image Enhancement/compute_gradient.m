function [Gx, Gy, im_magnitude,im_direction] = compute_gradient(image)
%fprintf('Not implemented\n')
I = im2double(imread(image));
%I = double(I) ./ 255; % why do we need this?

sobel_kernel1 = [1, 0, -1; 2, 0, -2; 1, 0, -1];
sobel_kernel2 = [1, 2, 1; 0, 0, 0; -1, -2, -1];

Gx = double(imfilter(I, sobel_kernel1));
Gy = double(imfilter(I, sobel_kernel2));


im_magnitude = sqrt(Gx.^2+Gy.^2);
%im_direction = atan(Gy./Gx);
im_direction = atan2(Gy, Gx);

figure
subplot(2, 2, 1)
imshow(mat2gray(Gx))
title('Gradient x-direction')
subplot(2, 2, 2)
imshow(mat2gray(Gy))
title('Gradient y-direction')
subplot(2, 2, 3)
imshow(mat2gray(im_magnitude))
title('The gradient magnitude')
subplot(2, 2, 4)
imshow(mat2gray(im_direction))
title('The gradient direction')
end


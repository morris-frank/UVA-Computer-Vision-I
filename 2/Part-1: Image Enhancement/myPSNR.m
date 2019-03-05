function [ PSNR ] = myPSNR( orig_image, approx_image )
%fprintf('Not implemented\n')
I = im2double(imread(orig_image));
I1 = im2double(imread(approx_image));
%I1 = im2double(approx_image);
%I = I/.255;
%I1 = I1/.255;

[m,n] = size(I);
%err_sq = (I-I1).^2;
%MSE = sum(sum(err_sq))/(m*n)
%immse(I,I1)

max_ = double(max(I, [],'all'));
PSNR = 20*log10(max_/sqrt(immse(I,I1)));

end


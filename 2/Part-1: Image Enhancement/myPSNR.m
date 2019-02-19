function [ PSNR ] = myPSNR( orig_image, approx_image )
    [h, w] = size(orig_image);
    Imax = max(orig_image, [], 'all');
    MSE = sum((orig_image - approx_image).^2, 'all') / h / w;
    PSNR = 20 * log10(Imax / sqrt(MSE));
end


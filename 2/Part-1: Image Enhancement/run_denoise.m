image1 = im2double(imread('./images/image1.jpg'));
image1_saltpepper = {'saltpep', im2double(imread('./images/image1_saltpepper.jpg'))};
image1_gaussian = {'gaussian', im2double(imread('./images/image1_gaussian.jpg'))};
kernel_sizes = [3, 5, 7];
filters = {'box', 'median'};

for noise = {image1_saltpepper, image1_gaussian}
for filter = filters
for kernel_size = kernel_sizes
    denoised_image = denoise(noise{1}{2}, filter{1}, kernel_size);
    psnr = myPSNR(image1, denoised_image);
    fprintf('%s,%s,%u,%0.5e\n',noise{1}{1},filter{1},kernel_size,psnr);
    imwrite(denoised_image, sprintf('./images/%s_%s_%u.png',noise{1}{1},filter{1},kernel_size))
    %log
end
end
end
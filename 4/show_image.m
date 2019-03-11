function im_transform = show_image(image1, image2, N, P)
[matches, scores, fa, fb] = keypoint_matching(image1, image2);
[M_best, t_best, performance, tform] = ransac(fa, fb, matches, N, P)

im_transform = imwarp(im2double(imread(image1)),tform);


figure
subplot(1, 3, 1)
imshow(image1)
title('Figure 1')

subplot(1, 3, 2)
imshow(mat2gray(im_transform))
title('Transformed figure 1')

subplot(1, 3, 3)
imshow(image2)
title('Figure 2')

end
function [im_transform, M_best, t_best] = show_image(image1, image2, N, P)

%beacuse we rotate image1
N1 = size(imread(image1));

[matches, scores, fa, fb] = keypoint_matching(image1, image2);
[M_best, t_best, performance, tform] = ransac(fa, fb, matches, N, P);
performance

im_transform = imwarp(im2double(imread(image1)),tform);


im_transform_my = my_transform(image1, M_best', t_best);


figure
subplot(2, 2, 1)
imshow(image1)
title('Figure 1')

subplot(2, 2, 2)
imshow(image2)
title('Figure 2')

subplot(2, 2, 3)
imshow(mat2gray(im_transform))
title('Transformed figure 1 imwrap')

subplot(2, 2, 4)
imshow(mat2gray(im_transform_my))
title('Transformed figure 1 custom function')

end
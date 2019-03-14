left = im2double(imread('left.jpg'));
right = im2double(imread('right.jpg'));

stitched = stitch(left, right);

figure(1)
subplot(1,2,1)
imshow(left)
subplot(1,2,2)
imshow(right)

figure(2)
imshow(stitched)
imwrite(stitched, 'stitched.png')
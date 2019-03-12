boat1 = im2double(imread('boat1.pgm'));
boat2 = im2double(imread('boat2.pgm'));

[F1, F2, matches, ~] = keypoint_matching(boat1, boat2);
tform = RANSAC(F1, F2, matches);

% Plot random subset of 10 matches
plot_rand_matches(F1, F2, matches, boat1, boat2)

% Our own interpolation method
transformed_image = apply_tform(boat1, tform, 1);
figure(2)
imshow(transformed_image)

% Transformation and interpolation using imwarp
warped_image = apply_tform(boat1, tform, 2);
figure(3)
imshow(warped_image)
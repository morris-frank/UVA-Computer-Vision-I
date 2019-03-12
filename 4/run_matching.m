boat1 = im2double(imread('boat1.pgm'));
boat2 = im2double(imread('boat2.pgm'));

[F1, F2, matches, scores] = keypoint_matching(boat1, boat2);

% Plot random subset of 10 matches
perm = randperm(size(matches, 2));
sel = perm(1:10);

cF2 = F2;
for i = 1:size(cF2, 2)
    cF2(1, i) = cF2(1, i) + size(boat1, 2);
end

compimg = zeros(size(boat1,1), size(boat1,2)+size(boat2,2));
compimg(:, 1:size(boat1,2)) = boat1;
compimg(:, size(boat2,2)+1:end) = boat2;

figure(1)
imshow(compimg)
vl_plotframe(F1(:, sel));
vl_plotframe(cF2(:, sel));
hold on;
for i = 1:size(sel,2)
    s = sel(i);
    plot([F1(1, s), cF2(1, s)], [F1(2, s), cF2(2, s)]);
end
hold off;

tform = RANSAC(F1, F2, matches);

% Our own interpolation method
[h,w] = size(boat1);
rot = pinv(reshape(tform(1:4), [2,2]));
trans = [tform(6);tform(5)];
transformed_image = zeros(h,w);
for i = 1:h
    for j = 1:w
        nx = round((rot * [i; j]) - trans);
        if all(nx > 0) && nx(1)<h && nx(2)<w
            transformed_image(i,j) = boat1(nx(1), nx(2));
        end
    end
end
figure(2)
imshow(transformed_image)

% Transformation and interpolation using imwarp
rot =  eye(3);
rot(1:2, 1:2) = reshape(tform(1:4), [2,2]);
warp = affine2d(rot);
warped_image = imwarp(boat1, warp);
figure(3)
imshow(warped_image)
function stitch(left, right)
    [F1, F2, matches, ~] = keypoint_matching(rgb2gray(left), rgb2gray(right));
    tform = RANSAC(F1, F2, matches);
    warped_image = apply_tform(left, tform, 2);
    
    [hr, wr, ~] = size(right);
    [hl, wl, ~] = size(left);
    [hw, ww, ~] = size(warped_image);
    
    % Find size of stitched image
    corners = [0,0; hl,0; 0,wl; hl,wl]';
    rot = reshape(tform(1:4), [2,2]);
    trans = [tform(6);tform(5)];
    trans_corners = rot * corners + trans;
    ss = ceil(abs(min(trans_corners')) + [hr,wr]);
    
    % Make the stitched image
    stitched = zeros(ss(1), ss(2), 3);
    stitched(1:hw, 1:ww, :) = warped_image;
    stitched(1-trans(1):hr-trans(1), ss(2)-wr+1:end, :) = right;
    
    figure(1)
    imshow(stitched)
end
function [F1, F2, matches, scores] = keypoint_matching(im1, im2)
    im1 = single(im1);
    im2 = single(im2);
    
    [F1, D1] = vl_sift(im1);
    [F2, D2] = vl_sift(im2);

    [matches, scores] = vl_ubcmatch(D1, D2);
end
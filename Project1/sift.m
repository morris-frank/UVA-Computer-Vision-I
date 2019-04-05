function [features] = sift(img, type)
    assert(size(img, 3) == 3)
    
    opts = split(type, '_');
    if opts{2} == "sift"
        [frames, ~] = vl_sift(rgb2gray(img / 255));
        n_features = size(frames, 2);
    elseif opts{2} == "dsift"
        n_features = (size(img,1)-9) * (size(img,2)-9);
    end
    
    if opts{1} == "opponent"
        opp_img = zeros(size(img), 'single');
        opp_img(:,:,1) = (img(:,:,1) - img(:,:,2)) / sqrt(2);
        opp_img(:,:,2) = (img(:,:,1) + img(:,:,2) - 2*img(:,:,3)) / sqrt(6);
        opp_img(:,:,3) = sum(img, 3) / sqrt(3);
        img = opp_img;
    elseif opts{1} == "gray"
        img = rgb2gray(img / 255);
    end
    
    sc = 3 - 2 * (opts{1} == "gray");
    N = 128;
    features = zeros(N * sc, n_features, 'single');
    for i = 1:sc
        if opts{2} == "sift"
            [~,d] = vl_sift(img(:,:,i), 'frames', frames);
        else
            [~,d] = vl_dsift(img(:,:,i));
        end
        features(N*(i-1)+1:N*i, :) = d;
    end
end
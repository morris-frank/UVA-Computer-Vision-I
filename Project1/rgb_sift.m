function [features] = rgb_sift(img)
    assert(size(img, 3) == 3)
    
    N = 128;
    [h,w,~] = size(img);
    n_features = (h-9) * (w-9);
    features = zeros(N * 3, n_features);
    
    for i = 1:3
        [~,d] = vl_dsift(single(img(:,:,i)));
        features(N*(i-1)+1:N*i, :) = d;
    end 
end
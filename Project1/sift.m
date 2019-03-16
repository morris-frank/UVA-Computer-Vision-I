function [features] = sift(img, type)
    assert(size(img, 3) == 3)
    
    N = 128;
    [h,w,~] = size(img);
    n_features = (h-9) * (w-9);
    
    switch type
        case 'opponent_sift'
            features = zeros(N * 3, n_features, 'single');

            % Calculating the opponent image
            opp_img = zeros(size(img), 'single');
            opp_img(:,:,1) = (img(:,:,1) - img(:,:,2)) / sqrt(2);
            opp_img(:,:,2) = (img(:,:,1) + img(:,:,2) - 2*img(:,:,3)) / sqrt(6);
            opp_img(:,:,3) = sum(img, 3) / sqrt(3);

            for i = 1:3
                [~,d] = vl_dsift(opp_img(:,:,i));
                features(N*(i-1)+1:N*i, :) = d;
            end 
        case 'rgb_sift'
            features = zeros(N * 3, n_features, 'single');
            for i = 1:3
                [~,d] = vl_dsift(single(img(:,:,i)));
                features(N*(i-1)+1:N*i, :) = d;
            end 
        otherwise % Gray sift
            gimg = single(rgb2gray(img));
            [~, features] = vl_dsift(gimg);
    end
end
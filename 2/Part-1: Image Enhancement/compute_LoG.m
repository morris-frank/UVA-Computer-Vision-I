function imOut = compute_LoG(image, LOG_type)

switch LOG_type
    case 1
        %method 1
        K1 = fspecial('gaussian', 5, 0.5);
        K2 = fspecial('laplcian');
        imOut = imfilter(imfilter(image, K1), K2);
    case 2
        %method 2
        K = fspecial('log', 5, 0.5);
        imOut = imfilter(image, K);
    case 3
        % method 3
        
        
end
end


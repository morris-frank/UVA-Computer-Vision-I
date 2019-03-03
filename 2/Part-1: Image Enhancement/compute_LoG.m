function imOut = compute_LoG(image, LOG_type)

switch LOG_type
    case 1
        %method 1
        K1 = fspecial('gaussian', 5, 0.5);
        K2 = fspecial('laplacian');
        imOut = imfilter(imfilter(image, K1), K2);
    case 2
        %method 2 
        K = fspecial('log', 5, 0.5);
        imOut = imfilter(image, K);
    case 3
        % method 3
        %K1 = fspecial('gaussian', 5, 0.8);
        %K2 = fspecial('gaussian', 5, 0.5);
        %imOut = imfilter(image, K1) - imfilter(image, K2);
        imOut = imgaussfilt(image, 0.8) - imgaussfilt(image, 0.5);
end
end


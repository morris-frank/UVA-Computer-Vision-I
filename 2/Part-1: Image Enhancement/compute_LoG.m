function imOut = compute_LoG(image, LOG_type)
I = im2double(imread(image));
        I1 = imfilter(I, fspecial('gaussian', 3, 0.5));
        imOut1 = imfilter(I1, fspecial('laplacian'));
 
        %imshow(mat2gray(imOut))
        
        imOut2 = imfilter(I, fspecial('log', 3, 0.5));
        %imshow(mat2gray(imOut))
        norm(mat2gray(imOut1) - mat2gray(imOut2))
        sigma1 = 10;
        sigma2 = 0.5;
        I1 = imfilter(I, fspecial('gaussian', 5, sigma1));
        I2 = imfilter(I, fspecial('gaussian', 5, sigma2));
        imOut3 = I1-I2;
        %imshow(mat2gray(imOut))
        

switch LOG_type
    case 1
        %method 1
        %fprintf('Not implemented\n')
        I1 = imfilter(I, fspecial('gaussian', 5, 0.5));
        imOut = imfilter(I1, fspecial('laplacian'));
 
        imshow(mat2gray(imOut))
        
        %imfilter(fspecial('gaussian', 5, 0.5), fspecial('laplacian'));

    case 2
        %method 2
        %fprintf('Not implemented\n')
        
        imOut = imfilter(I, fspecial('log', 5, 0.5));
        imshow(mat2gray(imOut))

    case 3
        %method 3
        %fprintf('Not implemented\n')
        sigma1 = 10;
        sigma2 = 0.5;
        I1 = imfilter(I, fspecial('gaussian', 5, sigma1));
        I2 = imfilter(I, fspecial('gaussian', 5, sigma2));
        imOut = I1-I2;
        imshow(mat2gray(imOut))

end
end


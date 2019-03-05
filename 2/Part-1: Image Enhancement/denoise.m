function [ imOut ] = denoise( image, kernel_type, varargin)
I = imread(image);
switch kernel_type
    case 'box'
        n = double(varargin{1});
        imOut = imboxfilt(I, [n n]);
        imshow(imOut)
        %imwrite(imOut, 'q7_gaus_box_77.jpg');
        %fprintf('Not implemented\n')
    case 'median'
        n = double(varargin{1});
        
        imOut = medfilt2(I, [n n]);
        imshow(imOut)
        %imwrite(imOut, 'q7_sp_median_77.jpg');
        %fprintf('Not implemented\n')
    case 'gaussian'
        %gauss2D( sigma , kernel_size )
        kernel_size = double(varargin{2});
        sigma = double(varargin{1});
        
        imOut = imfilter(I, gauss2D( sigma , kernel_size));
        %myPSNR('images/image1.jpg', imOut)
        
        figure
        subplot(2, 2, 1)
        imshow(image)
        title('Image with gaussian noise')
        
        subplot(2, 2, 2)
        imOutM = imboxfilt(I, [3 3]);
        imshow(imOutM)
        title('Box filter')
        
        subplot(2, 2, 3)
        imOutMed = medfilt2(I, [3 3]);
        imshow(imOutMed)
        title('Median filter')
        
        subplot(2, 2, 4)
        imOut5 = imfilter(I, gauss2D( 0.6 , 3));
        imshow(imOut5)
        title('Gaussian filter')
       
        
        %fprintf('Not implemented\n')
end
end

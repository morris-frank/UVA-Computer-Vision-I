function [ imOut ] = denoise( image, kernel_type, varargin)

switch kernel_type
    case 'box'
        imOut = imboxfilt(image, varargin{1});
    case 'median'
        imOut = medfilt2(image, [varargin{1}, varargin{1}]);
    case 'gaussian'
        G = gauss2D(varargin);
        imOut = imfilter(image, G, 'conv');
end
end

function [output_image] = rgb2grays(input_image)
% converts an RGB into grayscale by using 4 different methods
[R, G, B] = getColorChannels(input_image);

% lightness method
lightness = (max(max(R, G), B) + min(min(R, G), B)) ./ 2;

% average method
avg_method = mean(reshape([R, G, B], size(input_image)), 3);

% luminosity method
luminosity = 0.21 .* R + 0.72 .* G + 0.07 .* B;

% built-in MATLAB function 
mat_func = rgb2gray(input_image);
%output_image = avg_method;%
output_image = reshape([lightness, avg_method, luminosity, mat_func], [size(input_image, 1), size(input_image, 2), 4]);

end


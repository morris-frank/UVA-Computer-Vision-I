function [output_image] = rgb2opponent(input_image)
% converts an RGB image into opponent color space
[R, G, B] = getColorChannels(input_image);
opponent = reshape([(R - G) ./ sqrt(2), (R + G - 2 * B) ./ sqrt(6), (R + G + B) ./ sqrt(3)], size(input_image));
output_image = opponent;
end


function [output_image] = rgb2normedrgb(input_image)
% converts an RGB image into normalized rgb
[R, G, B] = getColorChannels(input_image);
intensity = R + G + B;
r = R ./ intensity;
g = G ./ intensity;
b = B ./ intensity;
output_image = reshape([r, g, b], size(input_image));
end


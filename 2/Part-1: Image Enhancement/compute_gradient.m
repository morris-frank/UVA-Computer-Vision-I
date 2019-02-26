function [Gx, Gy, im_magnitude,im_direction] = compute_gradient(image)
    % sobel Kernel definitions:
    Kxx = [1 0 -1];
    Kxy = [1;2;1];
    Kyx = [1 2 1];
    Kyy = [1;0;-1];
    
    Gx = imfilter(imfilter(image, Kxx), Kxy);
    Gy = imfilter(imfilter(image, Kyx), Kyy);
    
    im_magnitude = sqrt(Gx.^2 + Gy.^2);
    im_direction = atan(Gy./Gx);
end


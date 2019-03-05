function [H, r, c] = harris_corner_detector(im, thresh)
    n = 3;
    
    im_gray = im;
    if size(im, 3) == 3
        im_gray = rgb2gray(im);
    end
    im_gray = im2double(im_gray);
    
    G = fspecial('gauss');
    [Gx, Gy] = gradient(G);
    %Gx = [-1 0 1; -1 0 1; -1 0 1];
    %Gy = Gx';

    
    Ix = imfilter(im_gray, Gx, 'conv', 'symmetric');
    Iy = imfilter(im_gray, Gy, 'conv', 'symmetric');
    
    A = imfilter(Ix.^2, G, 'conv', 'symmetric');
    B = imfilter(Ix.*Iy, G, 'conv', 'symmetric');
    C = imfilter(Iy.^2, G, 'conv', 'symmetric');
    
    H = (A.*C - B.^2) - 0.04 * (A + C).^2;
    H = imdilate(H, true(n));
    H(H<thresh) = 0;
    
    [r, c] = find(H);
    
    figure(1);
    imshow(im)
    hold on;
    for i = 1:size(r)
        plot(c(i), r(i), 'r+', 'MarkerSize', 20);
    end
    hold off;
    
    figure(2);
    imshow(mat2gray(Ix));
    imwrite(mat2gray(Ix), 'harris_ix.png');
    
    figure(3);
    imshow(mat2gray(Iy));
    imwrite(mat2gray(Iy), 'harris_iy.png');
end
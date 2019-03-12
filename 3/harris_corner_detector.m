function [H, r, c] = harris_corner_detector(im, thresh, plotting)
    n = 2;
    
    if nargin < 3
        plotting = true;
    end
    
    im_gray = im;
    if size(im, 3) == 3
        im_gray = rgb2gray(im);
    end
    im_gray = im2double(im_gray);
    
    G = fspecial('gauss', 5, 2);
    [Gx, Gy] = gradient(G);
    %Gx = [-1 0 1; -1 0 1; -1 0 1];
    %Gy = Gx';

    Ix = (imfilter(im_gray, Gx, 'conv', 'symmetric'));
    Iy = (imfilter(im_gray, Gy, 'conv', 'symmetric'));
    
    
    A = imfilter(Ix.^2, G, 'conv', 'symmetric');
    B = imfilter(Ix.*Iy, G, 'conv', 'symmetric');
    C = imfilter(Iy.^2, G, 'conv', 'symmetric');
    
    H = (A.*C - B.^2) - 0.04 * (A + C).^2;
    H = imdilate(H, true(n));
    H(H<thresh) = 0;
    
    [r, c] = find(H);
    
    if plotting
        figure(1);
        set(gca,'Units','pixels'); %changes the Units property of axes to pixels
        set(gca,'Position', [1 1 size(im,1) size(im,2)])
        imshow(im)
        hold on;
        for i = 1:size(r)
            plot(c(i), r(i), 'r+', 'MarkerSize', 5);
        end
        hold off;
    
        figure(2);
        Ix = mat2gray(Ix);
        imshow(Ix);
        imwrite(Ix, 'harris_ix.png');
    
        figure(3);
        Iy = mat2gray(Iy);
        imshow(Iy);
        imwrite(Iy, 'harris_iy.png');
    end
end
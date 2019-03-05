function [Vx,Vy] = lucas_kanade(im1, im2)
    oim1 = im1;
    oim2 = im2;
    if (size(im1,3) == 3)
        im1 = rgb2gray(im1);
    end
    if (size(im2,3) == 3)
        im2 = rgb2gray(im2);
    end

    im1 = im2double(im1);
    im2 = im2double(im2);
    
    assert(all(size(im1) == size(im2)))
    
    stride = 10;
    ws = 15;
    hws = floor(ws/2);
    [w,h] = size(im1);
    
    % Calculate the derivatives
    %Ky = fspecial('prewitt');
    Ky = [-1 -1;1 1];
    Kx = Ky';
    Ix = imfilter(im1, Kx, 'conv', 'symmetric') + imfilter(im2, Kx, 'conv', 'symmetric');
    Iy = imfilter(im1, Ky, 'conv', 'symmetric') + imfilter(im2, Ky, 'conv', 'symmetric');
    It = imfilter(im1, ones(2), 'conv', 'symmetric') - imfilter(im2, ones(2), 'conv', 'symmetric');
    
    Vx = zeros(size(im1));
    Vy = zeros(size(im1));
    for x = hws+1:stride:w-hws
        for y = hws+1:stride:h-hws
            cIx = Ix(x-hws:x+hws, y-hws:y+hws)';
            cIy = Iy(x-hws:x+hws, y-hws:y+hws)';
            cIt = It(x-hws:x+hws, y-hws:y+hws)';
            
            cIx = cIx(:);
            cIy = cIy(:);
            
            A = [cIx, cIy];
            b = -cIt(:);
            %u = pinv(A) * b;
            u = pinv(A'*A)*A'*b;
            Vx(x,y) = u(1);
            Vy(x,y) = u(2);
        end
    end
    
    figure(1)
    imshow(oim1)
    hold on;
    quiver(Vx, Vy, 10);
    hold off;
    figure(2)
    imshow(oim2)
end
function [transformed_image] = apply_tform(image, tform, method)
    assert(method==1 || method==2)
    
    if method == 1
        [h,w] = size(image);
        
        corners = [1,1; h,1; 1,w; h,w]';
        rot = reshape(tform(1:4), [2,2]);
        irot = pinv(rot);
        rot_corners = rot * corners;
    
        sizetr = ceil(max(rot_corners') - min(rot_corners'));
        transformed_image = zeros(sizetr(1), sizetr(2));
        offset = min(rot_corners')';
        for i = 1:sizetr(1)
            for j = 1:sizetr(2)
                nx = round(irot * ([i;j] + offset));
                if all(nx > 0) && nx(1)<h && nx(2)<w
                    transformed_image(i,j) = image(nx(1), nx(2));
                end
            end
        end
	else
        rot =  eye(3);
        rot(1:2, 1:2) = reshape(tform(1:4), [2,2]);
        warp = affine2d(rot);
        transformed_image = imwarp(image, warp);
    end
end

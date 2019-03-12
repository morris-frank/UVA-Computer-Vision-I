function [transformed_image] = apply_tform(image, tform, method)
    assert(method==1 || method==2)
    
    if method == 1
        [h,w] = size(image);
        rot = pinv(reshape(tform(1:4), [2,2]));
        trans = [tform(6);tform(5)];
        transformed_image = zeros(h,w);
        for i = 1:h
            for j = 1:w
                nx = round((rot * [i; j]) - trans);
                if all(nx > 0) && nx(1)<h && nx(2)<w
                    transformed_image(i,j) = boat1(nx(1), nx(2));
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

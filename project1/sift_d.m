function d = sift_d(X, sift_type)

N = size(X);
N = N(1);

if sift_type == 1
    d_array = zeros(7569*N, 128);
    for i=1:N
        %if y(i) == class_type
            x_gray = reshape(X(i, :, :), [96, 96]);
            [~, d] = vl_dsift(x_gray);
            d_array(7569*(i-1)+1:7569*i, :) = d';
        %end
    end
end

if sift_type == 2
    d_array = zeros(3*7569*N, 128);
    j = 1;
    for i=1:3:3*N
        %if y(j) == class_type

            x_r = reshape(X(j, :, :, 1), [96, 96]);
            x_g = reshape(X(j, :, :, 2), [96, 96]);
            x_b = reshape(X(j, :, :, 3), [96, 96]);
            
            [~, d] = vl_dsift(x_r);
            d_array(7569*(i-1)+1:7569*i, :) = d';
            
            [~, d] = vl_dsift(x_g);
            d_array(7569*i+1:7569*(i+1), :) = d';
            
            [~, d] = vl_dsift(x_b);
            d_array(7569*(i+1)+1:7569*(i+2), :) = d';
            j = j+1;
            
        %end
    end
end

if sift_type == 3
    d_array = zeros(3*7569*N, 128);
    j = 1;
    for i=1:3:3*N
        %if y(j) == 1

            x_r = reshape(X(j, :, :, 1), [96, 96]);
            x_g = reshape(X(j, :, :, 2), [96, 96]);
            x_b = reshape(X(j, :, :, 3), [96, 96]);
            
            o1 = (x_r-x_g)/sqrt(2);
            o2 = (x_r+x_g-2*x_b)/sqrt(6);
            o3 = (x_r+x_g+x_b)/sqrt(3);
            
            [~, d] = vl_dsift(o1);
            d_array(7569*(i-1)+1:7569*i, :) = d';
            
            [~, d] = vl_dsift(o2);
            d_array(7569*i+1:7569*(i+1), :) = d';
            
            [~, d] = vl_dsift(o3);
            d_array(7569*(i+1)+1:7569*(i+2), :) = d';
            j = j+1;
            
        %end
    end
end


end

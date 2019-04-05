function d_array = get_dsift(X, sift_type, size_step)

%size_step = 5;
X = single(X);
[~, d] = vl_dsift(reshape(single(X(1, :, :, 1)), [96, 96]), 'step', size_step, 'size', 10);
size_arr = size(d);
size_arr = size_arr(2);
N = size(X);
N = N(1);

if sift_type == 1
    d_array = zeros(size_arr*N, 128);
    for i=1:N
        
            x_gray = reshape(X(i, :, :), [96, 96]);
            [~, d] = vl_dsift(x_gray, 'step', size_step, 'size', 10);
            d_array(size_arr*(i-1)+1:size_arr*i, :) = d';
       
    end
end


if sift_type == 2
    d_array = zeros(3*size_arr*N, 128);
    j = 1;
    for i=1:3:3*N
            x_r = reshape(X(j, :, :, 1), [96, 96]);
            x_g = reshape(X(j, :, :, 2), [96, 96]);
            x_b = reshape(X(j, :, :, 3), [96, 96]);
            
            [~, d] = vl_dsift(x_r, 'step', size_step, 'size', 10);
            d_array(size_arr*(i-1)+1:size_arr*i, :) = d';
            
            [~, d] = vl_dsift(x_g, 'step', size_step, 'size', 10);
            d_array(size_arr*i+1:size_arr*(i+1), :) = d';
            
            [~, d] = vl_dsift(x_b, 'step', size_step, 'size', 10);
            d_array(size_arr*(i+1)+1:size_arr*(i+2), :) = d';
            j = j+1;
    end
end

if sift_type == 3
    d_array = zeros(3*size_arr*N, 128);
    j = 1;
    for i=1:3:3*N
        %if y(j) == 1

            x_r = reshape(X(j, :, :, 1), [96, 96]);
            x_g = reshape(X(j, :, :, 2), [96, 96]);
            x_b = reshape(X(j, :, :, 3), [96, 96]);
            
            o1 = (x_r-x_g)/sqrt(2);
            o2 = (x_r+x_g-2*x_b)/sqrt(6);
            o3 = (x_r+x_g+x_b)/sqrt(3);
            
            [~, d] = vl_dsift(o1, 'step', size_step, 'size', 10);
            d_array(size_arr*(i-1)+1:size_arr*i, :) = d';
            
            [~, d] = vl_dsift(o2, 'step', size_step, 'size', 10);
            d_array(size_arr*i+1:size_arr*(i+1), :) = d';
            
            [~, d] = vl_dsift(o3, 'step', size_step, 'size', 10);
            d_array(size_arr*(i+1)+1:size_arr*(i+2), :) = d';
            j = j+1;
            
        %end
    end
end

end

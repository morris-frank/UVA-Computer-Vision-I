function [X_rgb1, X_gray1, X_rgb2, X_gray2, y_train1, y_train2] = load_N(file_name, N)

%file_name = 'train.mat'
file = load(file_name);
classes = {'airplane', 'bird', 'ship', 'horse', 'car'};
[n, ~] = size(file.X);
j = 1;
k = 1;

X_train1 = zeros(1, 96, 96, 3);
X_gray1 = zeros(1, 96, 96);
y_train1 = zeros(1);

X_train2 = zeros(1, 96, 96, 3);
X_gray2 = zeros(1, 96, 96);
y_train2 = zeros(1);

check = zeros(10, 1);

for i=1:n
    if ismember(file.class_names(file.y(i)), classes)
        if check(file.y(i)) < N
            X_train1(j, :, :, :) = reshape(file.X(i, :), [1, 96, 96, 3]);
            X_gray1(j, :, :) =  rgb2gray(reshape(X_train1(j, :, :, :), [96, 96, 3]));
            y_train1(j) = file.y(i);
            check(file.y(i)) = check(file.y(i))+1;
            j = j+1;

        else
            X_train2(k, :, :, :) = reshape(file.X(i, :), [1, 96, 96, 3]);
            X_gray2(k, :, :) =  rgb2gray(reshape(X_train2(k, :, :, :), [96, 96, 3]));
            y_train2(k) = file.y(i);
            check(file.y(i)) = check(file.y(i))+1;
            k = k+1;
        end
        %disp(check(file.y(i)))
    end
    
end

X_rgb1 = single(X_train1/255);
X_gray1 = single(X_gray1/255);

X_rgb2 = single(X_train2/255);
X_gray2 = single(X_gray2/255);

end
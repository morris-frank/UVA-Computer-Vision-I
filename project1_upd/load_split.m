function [X_rgb1, X_rgb2, y_1, y_2] = load_split(file_name, N1, N2)

file = load(file_name);
classes = {'airplane', 'bird', 'ship', 'horse', 'car'};
[n, ~] = size(file.X);
j = 1;
k = 1;

check = zeros(10, 1);
for i=1:n
    
    if ismember(file.class_names(file.y(i)), classes)
        if check(file.y(i)) < N1
            X_rgb1(j, :, :, :) = reshape(file.X(i, :), [1, 96, 96, 3]);
            
            y_1(j) = file.y(i);
            check(file.y(i)) = check(file.y(i))+1;
            j = j+1;
            

        elseif check(file.y(i))>= N1 && check(file.y(i)) < N2
            X_rgb2(k, :, :, :) = reshape(file.X(i, :), [1, 96, 96, 3]);
            y_2(k) = file.y(i);
            check(file.y(i)) = check(file.y(i))+1;
            k = k+1;
        end
        %disp(check(file.y(i)))
    end
    
if  k==1
    X_rgb2 = 0;
    y_2 = 0;
end

end
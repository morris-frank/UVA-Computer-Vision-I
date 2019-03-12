function visualize(input_image)
input_image = imresize(im2double(input_image), 2);
try
    subplot(4,1,1);
    j = 1;
    imshow(input_image);
catch
    disp('alright')
    j = 0;
end
if size(input_image, 3) > 1
    i = 0;
    while i < size(input_image, 3)
        i = i + 1;
        subplot(4,1,i+j);
        disp(i);
        disp('i value');
        imshow(input_image(:, :, i));
    end
end
end


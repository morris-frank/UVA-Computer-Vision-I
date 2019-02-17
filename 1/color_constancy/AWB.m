function AWB()
    function color_correction(path)
        im = im2double(imread(path));
        mean_colors = squeeze(mean(im, [1,2]));
        gray = [0.5, 0.5, 0.5]';
        corrected = im .* reshape(gray ./ mean_colors, 1,1,3);

        figure
        subplot(1,2,1)
        imshow(im)
        title('Original')

        subplot(1,2,2)
        imshow(corrected)
        title('Color corrected')
    end
    color_correction('./awb.jpg')
    %color_correction('./ceiling.jpg')
end
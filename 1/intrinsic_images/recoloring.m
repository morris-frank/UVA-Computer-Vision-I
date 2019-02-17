function recoloring()
    ball = im2double(imread('ball.png'));
    ball_shading = im2double(imread('ball_shading.png'));
    ball_albedo = im2double(imread('ball_albedo.png'));

    pixels = reshape(ball_albedo, [], 3);

    % Remove black
    nonblackpixels = pixels;
    cond = pixels(:,1) == 0 & pixels(:,2) == 0 & pixels(:,3) == 0;
    nonblackpixels(cond, :) = [];

    % Find the predominant color
    [unique_colors, m, n] = unique(nonblackpixels, 'rows');
    color_counts = accumarray(n, 1);
    [max_count, idx] = max(color_counts);
    main_color = unique_colors(idx, :);


    % Replace the predominant color
    new_color = [0,1,0];
    new_pixels= pixels;
    cond = pixels(:,1) == main_color(1) & pixels(:,2) == main_color(2) & pixels(:,3) == main_color(3);
    new_pixels(cond, :) = repmat(new_color, max_count, 1);
    ball_albedo_recolored = reshape(new_pixels, size(ball_albedo));
    
    figure
    subplot(1,2,1)
    imshow(ball)
    title('Original')
    
    subplot(1,2,2)
    imshow(ball_albedo_recolored .* ball_shading)
    title('Recolored')
end
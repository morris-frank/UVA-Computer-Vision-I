function ii_image_formation()
    ball = im2double(imread('ball.png'));
    ball_albedo = im2double(imread('ball_albedo.png'));
    ball_shading = im2double(imread('ball_shading.png'));

    ball_reconstructed = ball_albedo .* ball_shading;
    ball_error = abs(ball .- ball_reconstructed);

    figure
    subplot(2,2,1)
    imshow(ball)
    title('Original')

    subplot(2,2,2)
    imshow(ball_reconstructed)
    title('Reconstructed')

    subplot(2,2,3)
    imshow(ball_albedo)
    title('Albedo')

    subplot(2,2,4)
    imshow(ball_shading)
    title('Shading')
end
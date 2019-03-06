function tracking(directory)
    files = dir('./person_toy/*jpg');
    
    
    left_image = imread(strcat(files(1).folder, '/', files(1).name));
    [~, r, c] = harris_corner_detector(left_image, 0.0000001, false);
  
    for idx = 2:size(files, 1)
        
        fn = strcat(files(idx).folder, '/', files(idx).name);
        right_image = imread(fn);
        [w, h, ~] = size(right_image);
        
        [Vx, Vy] = lucas_kanade(left_image, right_image, true);
        figure(1)
        %imshow(Vx)
        pause
        imshow(left_image)
        hold on
        
        for j = 1:size(r)
            rj = Vx(r(j), c(j));
            cj = Vy(r(j), c(j));
            r(j) = int16(max(min(r(j) + rj, w), 0));
            c(j) = int16(max(min(c(j) + cj, h), 0));
            plot(c(j), r(j), 'yo', 'MarkerSize', 3);
        end
        hold off
        %export_fig(1, strcat('movie_', int2str(idx), '.jpg'))
        
        left_image = right_image;
    end
end
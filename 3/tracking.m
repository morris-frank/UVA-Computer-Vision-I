function tracking(directory)
    files = dir('./person_toy/*jpg');
    
    
    left_image = imread(strcat(files(1).folder, '/', files(1).name));
    [~, r, c] = harris_corner_detector(left_image, 0.0000001, false);
  
    for idx = 2:size(files, 1)
        
        fn = strcat(files(idx).folder, '/', files(idx).name);
        right_image = imread(fn);
        [w, h, ~] = size(right_image);
        
        [Vx, Vy] = lucas_kanade(left_image, right_image, false);
        int_pnts = sub2ind(size(Vx), r, c);
        Vx(abs(Vx) < 0.5) = 0;
        Vy(abs(Vy) < 0.5) = 0;
        Vx(setdiff(find(Vx), int_pnts)) = 0;
        Vy(setdiff(find(Vy), int_pnts)) = 0;
        
        
        figure(1)
        set(1, 'Visible', 'off');
        set(gca,'Units','pixels'); %changes the Units property of axes to pixels
        set(gca,'Position', [1 1 size(left_image,1) size(left_image,2)])
        imshow(left_image)
        hold on
        for j = 1:size(r)
            rj = ceil(1 * Vy(r(j), c(j)));
            cj = ceil(2 * Vx(r(j), c(j)));
            r(j) = int16(max(min(r(j) + rj, w), 0));
            c(j) = int16(max(min(c(j) + cj, h), 0));
            plot(c(j), r(j), 'yo', 'MarkerSize', 4);
        end
        quiver(Vx, Vy, 30);
        hold off
        %export_fig(1, strcat('movie_', int2str(idx), '.jpg'), '-native')
        print(strcat('movie_', int2str(idx)),'-djpeg')
        %saveas(gcf, strcat('movie_', int2str(idx), '.jpg'))
        
        left_image = right_image;
    end
end
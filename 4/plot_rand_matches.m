function plot_rand_matches(F1, F2, matches, im1, im2)
    perm = randperm(size(matches, 2));
    sel = perm(1:10);

    cF2 = F2;
    for i = 1:size(cF2, 2)
        cF2(1, i) = cF2(1, i) + size(im1, 2);
    end

    compimg = zeros(size(im1,1), size(im1,2)+size(im2,2));
    compimg(:, 1:size(im1,2)) = im1;
    compimg(:, size(im2,2)+1:end) = im2;

    figure(1)
    imshow(compimg)
    vl_plotframe(F1(:, sel));
    vl_plotframe(cF2(:, sel));
    hold on;
    for i = 1:size(sel,2)
        s = sel(i);
        plot([F1(1, s), cF2(1, s)], [F1(2, s), cF2(2, s)]);
    end
    hold off;
end
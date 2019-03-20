function [histogram] = feature_histogram(img, centroids, type)
    features = sift(img, type);
    assert(size(centroids, 1) == size(features, 1))
    
    [~, cids] = min(vl_alldist(features, centroids), [], 2);
    histogram = histcounts(cids, 1:size(centroids, 2) + 1);
    histogram = histogram ./ sum(histogram, 'all');
end


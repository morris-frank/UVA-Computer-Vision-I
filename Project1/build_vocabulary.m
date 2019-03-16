function [centroids] = build_vocabulary(X, type, n_clusters)
    % Size of one feature
    c_feat = 128;
    % Size of one image
    [h,w,c] = deal(96, 96, 3);
    % Number of features per image
    s_feat = (h-9) * (w-9);
    
    features = zeros(3 * c_feat, s_feat * size(X, 1), 'single');
    fprintf('[build_vocab]   Extracting features…, N samples: %d (DIM: %d)\n', size(features,2), size(features,1))
    for i = 1:size(X, 1)
        img = reshape(X(i, :), [h,w,c]);
        features(:, (i-1)*s_feat+1:i*s_feat) = sift(img, type);
    end
    
    disp('[build_vocab]   Kmeans clustering...')
    [centroids, ~] = vl_kmeans(features, n_clusters, 'Initialization', 'plusplus', 'Algorithm', 'ANN', 'MaxNumComparisons', ceil(n_clusters/50));
end
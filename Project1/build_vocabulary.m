function [centroids] = build_vocabulary(X, type, n_clusters)
	opts = split(type, '_');
    sc = (3 - 2 * (opts{1} == "gray")) * 128;
    if opts{2} == "sift"
        n_features = size(X, 1) * 30;
    else
        n_features = size(X, 1) * (96-9) * (96-9);
    end
    
    features = zeros(sc, n_features, 'single');
    fprintf('[build_vocab]   Extracting features…, N samples: %d (DIM: %d)\n', size(features,2), size(features,1))
    i = 1;
    for xi = 1:size(X, 1)
        xfeatures = sift(reshape(X(xi, :), [96, 96, 3]), type);
        features(:, i:i+size(xfeatures, 2)-1) = xfeatures;
        i = i+size(xfeatures, 2);
        if opts{2} == "sift" && i > 0.9 * size(features, 2)
            features = [features, zeros(sc, n_features)];
        end
    end
    features = features(:, 1:i-1);
    fprintf('[build_vocab]   Actual number of features: %d\n', size(features,2))
    
    disp('[build_vocab]   Kmeans clustering...')
    [centroids, ~] = vl_kmeans(features, n_clusters, 'Initialization', 'plusplus', 'Algorithm', 'ANN', 'MaxNumComparisons', ceil(n_clusters/50));
end
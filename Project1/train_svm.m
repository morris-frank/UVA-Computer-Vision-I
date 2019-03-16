function [model] = train_svm(X_train, y_train, cid, not_vocab_set, centroids, N)   
    pos_set = not_vocab_set(y_train(not_vocab_set, :) == cid);
    perm = randperm(size(pos_set, 2));
    pos_set = pos_set(perm(1:N));
    
    neg_set = not_vocab_set(y_train(not_vocab_set, :) ~= cid);
    perm = randperm(size(neg_set, 2));
    neg_set = neg_set(perm(1:N));
    
    X = zeros(2 * N, size(centroids, 2), 'double');
    y = [ones(N, 1); zeros(N, 1)];
    
    for i = 1:N
        img = squeeze(X_train(pos_set(i), :, :, :));
        X(i, :) = feature_histogram(img, centroids, type);
        
        img = squeeze(X_train(neg_set(i), :, :, :));
        X(N + i, :) = feature_histogram(img, centroids, type);
    end
    
    fprintf('[train_svm] Train classifier for class %d', cid)
    model = train(y, sparse(X), ['-q']);
end
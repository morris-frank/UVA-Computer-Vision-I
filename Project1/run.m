function run()
    load train.mat;
    X_train = single(reshape(X, [size(X, 1), 96, 96, 3])) / 255;
    y_train = uint16(y);
    clear X y;
    
    % Percentage of training points per class to use for building the
    % vocabulary
    vocab_size = 0.005;
    
    % Type of features to use
    type = 'opponent_sift';
    
    % Size of the vocabulary
    n_clusters = 100;
    
    % Number of Threads
    nCPU = 2;
    
    % Number of positive examples for SVM
    nSVM = 50;
    
    
    %--------
    vl_threads(nCPU);
    
    % split the trainings data
    vocab_set = [];
    not_vocab_set = [];
    for cid = unique(y_train)'
        n_samples = sum(y_train ==cid);
        perm = randperm(n_samples);
        cutoff = floor(vocab_size * n_samples);
        vocab_set = [vocab_set, perm(1:cutoff)];
        not_vocab_set = [not_vocab_set, perm(cutoff+1:end)];
    end
    
    centroids = build_vocabulary(X_train(vocab_set, :), type, n_clusters);
    
    
    for cid = unique(y_train)'
        model = train_svm(X_train, y_train, cid, not_vocab_set, centroids, nSVM);
    end
end
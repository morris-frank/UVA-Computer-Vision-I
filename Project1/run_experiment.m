function [results] = run_experiment(type, n_clusters, vocab_size, nSVM)
    load train.mat;
    X_train = single(reshape(X, [size(X, 1), 96, 96, 3]));
    y_train = uint16(y);
    clear X y;
    
    if nargin < 1
        % Percentage of training points per class to use for building the
        % vocabulary
        vocab_size = 0.005;
    end
    
    if nargin < 2
        % Type of features to use
        type = 'opponent_dsift';
    end
    
    if nargin < 3
        % Size of the vocabulary
        n_clusters = 100;
    end
        
    % Number of Threads
    nCPU = 2;
    
    if nargin < 4
        % Number of positive examples for SVM
        nSVM = 5;
    end
    
    % the class ids to train for
    C = [1, 2, 3, 7, 9];
    nc = size(C, 2);
    
    %--------
    vl_threads(nCPU);
    
    % split the trainings data
    vocab_set = [];
    svm_set = [];
    for c = C
        n_samples = sum(y_train == c);
        perm = randperm(n_samples);
        cutoff = floor(vocab_size * n_samples);
        vocab_set = [vocab_set, perm(1:cutoff)];
        svm_set = [svm_set, perm(cutoff+1:end)];
    end
    
    centroids = build_vocabulary(X_train(vocab_set, :), type, n_clusters);
    
    D_train = zeros(nc * nSVM, size(centroids, 2), 'double');
    fprintf('[run_exp]   Making train features…, N samples: %d (DIM: %d)\n', size(D_train,1), size(D_train,2))
    for ic = 1:nc
        cimgs = X_train(y_train==C(ic), :, : ,:);
        for i = 1:nSVM
            img = squeeze(cimgs(i, :, :, :));
            D_train((ic-1)*nSVM + i, :) = feature_histogram(img, centroids, type);
        end
    end
    D_train = sparse(D_train);
  
    load train.mat;
    X_test = single(reshape(X, [size(X, 1), 96, 96, 3]));
    y_test = double(y);
    clear X y;
    
    D_test = zeros(size(X_test, 1), size(centroids, 2), 'double');
    fprintf('[run_exp]   Making test features…, N samples: %d (DIM: %d)\n', size(D_test,1), size(D_test,2))
    for i = 1:size(X_test, 1)
        D_test(i, :) = feature_histogram(squeeze(X_test(i, :, :, :)), centroids, type);
    end
    
    results = cell(nc, 1);
    for ci = 1:nc
        yc_train = zeros(nc * nSVM, 1, 'double');
        yc_train((ci-1)*nSVM+1:ic*nSVM) = 1;
        fprintf('[run_exp] Train classifier for class %d', C(ci))
        model = train(yc_train, sparse(D_train), ['-q']);
        [labels, accuracy, probs] = predict(double(y_test == C(ci)), D_test, model);
        results{ci} = [labels, accuracy, probs];
    end
    
    fn = sprintf('%s_%d_%d_%d.mat', type, n_clusters, vocab_size * 100, nSVM);
    save(fn, results);
end
function [results] = run_experiment(type, n_clusters, vocab_size, nSVM)
    load train.mat;
    X_train = single(reshape(X, [size(X, 1), 96, 96, 3]));
    y_train = uint16(y);
    clear X y;
    
    if nargin < 1
        % Percentage of training points per class to use for building the
        % vocabulary
        vocab_size = 0.3;
    end
    
    if nargin < 2
        % Type of features to use
        type = "rgb_sift";
    end
    
    if nargin < 3
        % Size of the vocabulary
        n_clusters = 400;
    end
        
    % Number of Threads
    nCPU = 2;
    
    if nargin < 4
        % Number of positive examples for SVM
        nSVM = 100;
    end
    
    % the class ids to train for
    C = [1, 2, 3, 7, 9];
    nc = size(C, 2);
    
    %--------
    vl_threads(nCPU);
    
    % split the trainings data
    vocab_set = zeros([size(y_train, 1), 1], 'logical');
    for c = C
        N = sum(y_train == c);
        select = randperm(N) <= floor(vocab_size * N);
        vocab_set(y_train == c) = select;
    end
    centroids = build_vocabulary(X_train(vocab_set, :), type, n_clusters);
    
    
    D_train = zeros(nc * nSVM, size(centroids, 2), 'double');
    fprintf('[run_exp]   Making train features…, N samples: %d (DIM: %d)\n', size(D_train,1), size(D_train,2))
    for ic = 1:nc
        cimgs = X_train(y_train==C(ic) & ~vocab_set , :, : ,:);
        perm = randperm(size(cimgs, 1));
        for i = 1:nSVM
            img = squeeze(cimgs(perm(i), :, :, :));
            D_train((ic-1)*nSVM + i, :) = feature_histogram(img, centroids, type);
        end
    end
  
    load train.mat;
    X_test = single(reshape(X, [size(X, 1), 96, 96, 3]));
    y_test = double(y);
    clear X y;
    
    D_test = zeros(size(X_test, 1), size(centroids, 2), 'double');
    fprintf('[run_exp]   Making test features…, N samples: %d (DIM: %d)\n', size(D_test,1), size(D_test,2))
    for i = 1:size(X_test, 1)
        D_test(i, :) = feature_histogram(squeeze(X_test(i, :, :, :)), centroids, type);
    end
    
    results = zeros(nc, 2);
    for ci = 1:nc
        yc_train = zeros(nc * nSVM, 1, 'double');
        yc_train((ci-1)*nSVM+1:ci*nSVM) = 1;
        fprintf('[run_exp] Train classifier for class %d\n', C(ci))
        model = fitcsvm(D_train, yc_train', 'Standardize',true,'KernelScale','auto');
        [labels] = predict(model, D_test);
        [prec, rec] = prec_rec(y_test == C(ci), labels);
        results(ci, :) = [prec, rec];
    end
end
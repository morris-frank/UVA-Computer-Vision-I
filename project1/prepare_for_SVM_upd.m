function [X_train, y_train, X_test, y_test] = prepare_for_SVM_upd(file_name_train, N1, N_train, file_name_test, N2, sift_type, K_clusters)

[X_rgb1, X_gray1, X_rgb2, X_gray2, y_train1, y_train2] = load_N(file_name_train, N1, N_train);
[X_test_rgb1, X_test_gray1, X_test_rgb2, X_test_gray2, y_test1, y_test2] = load_N(file_name_test, N2, -1);

n = size(X_rgb1);
for k=1:n(1)
    X_gray1(k, :, :) =  rgb2gray(reshape(X_rgb1(k, :, :, :), [96, 96, 3]));
end

n = size(X_rgb2);
for k=1:n(1)
    X_gray2(k, :, :) =  rgb2gray(reshape(X_rgb2(k, :, :, :), [96, 96, 3]));
end

n = size(X_test_rgb1);
for k=1:n(1)
    X_test_gray1(k, :, :) =  rgb2gray(reshape(X_test_rgb1(k, :, :, :), [96, 96, 3]));
end

n = size(X_test_rgb2);
for k=1:n(1)
    X_test_gray2(k, :, :) =  rgb2gray(reshape(X_test_rgb2(k, :, :, :), [96, 96, 3]));
end


if sift_type == 1
    X1 = single(X_gray1)/255;
    X2 = single(X_gray2)/255;
    
    X1_ = single(X_test_gray1)/255;
    X2_ = single(X_test_gray2)/255;
else
    X1 = X_rgb1;
    X2 = X_rgb2;
    
    X1_ = X_test_rgb1;
    X2_ = X_test_rgb2;
end

d_array = sift_d(X1, sift_type);
[centers_vocab, ~] = vl_kmeans(double(d_array), K_clusters);

N2 = size(X2);
X_train = zeros(N2(1), K_clusters);
y_train = y_train2;

N1_ = size(X1_);
X_test = zeros(N1_(1), K_clusters);
y_test = y_test1;



for j=1:N2(1)

    d = sift_d(X2(j, :, :, :), sift_type);
    [~, cids] = max(vl_alldist(double(d), centers_vocab), [], 2);
    [a,~]=hist(cids,1:K_clusters);
    
    X_train(j, :) = a;
    j
    
end


for j=1:N1_(1)

    d = sift_d(X1_(j, :, :, :), sift_type);
    
    [~, cids] = max(vl_alldist(double(d), centers_vocab), [], 2);
    [a,~]=hist(cids,1:K_clusters);
    
    X_test(j, :) = a;
    j
end

end





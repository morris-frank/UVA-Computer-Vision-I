function [X_train, y_train] = prepare_for_SVM(file_name, N1, sift_type, K_clusters)

% N1 - number of images in each class to make vocabulary
% X1 - to make vocabulary
% X2 - to train svm
%N1 = 200;
%sift_type = 1;
%K_clusters = 50;
%file_name = 'train.mat'

%vocabulary
[X_rgb1, X_gray1, X_rgb2, X_gray2, y_train1, y_train2] = load_N(file_name, N1);

if sift_type == 1
    X1 = X_gray1;
    X2 = X_gray2;
else
    X1 = X_rgb1;
    X2 = X_rgb2;
end


d_array = sift_d(X1, sift_type);
[centers_vocab, ~] = vl_kmeans(double(d_array), K_clusters);
%dictionary

N2 = size(X2);
X_train = zeros(N2(1), K_clusters);
y_train = y_train2;

for i=1:N2(1)
    d = sift_d(X2(i, :, :, :), sift_type);
    Idx = knnsearch(double(centers_vocab'), double(d'));
    [a,~]=hist(Idx,1:K_clusters);
    X_train(i, :) = a;
end

end


function [X_svm, y_svm] = prepare_for_svm(X, y, cluster_means, sift_type, size_step)

N = size(X);
K = size(cluster_means);

X_svm = zeros(N(1), K(2));
y_svm = y;

for j=1:N(1)
    

    d = get_dsift(X(j, :, :, :), sift_type, size_step);
    %size(d)
    [~, cids] = max(vl_alldist(double(d'), cluster_means), [], 2);
    [a,~]=hist(cids,1:K(2));

    X_svm(j, :) = a;
    
end

end
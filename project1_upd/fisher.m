function [X1_fisher, X2_fisher] = fisher(X_train, X_test, means, covariances, priors, sift_type, size_step)

%[means, covariances, priors] = vl_gmm(X_gmm', K_clusters);

Ntr = size(X_train);
d = get_dsift(X_train(1, :, :, :), sift_type, size_step);
t = vl_fisher(d', means, covariances, priors);
K = size(t);

X1_fisher = zeros(Ntr(1), K(1));


Nte = size(X_test);
d = get_dsift(X_test(1, :, :, :), sift_type, size_step);
t = vl_fisher(d', means, covariances, priors);
K = size(t);

X2_fisher = zeros(Nte(1), K(1));


for j=1:Ntr(1)
    d = get_dsift(X_train(j, :, :, :), sift_type, size_step);
    X1_fisher(j, :) = vl_fisher(d', means, covariances, priors);
    
end 

for j=1:Nte(1)
    d = get_dsift(X_test(j, :, :, :), sift_type, size_step);
    X2_fisher(j, :) = vl_fisher(d', means, covariances, priors);    
end    


end
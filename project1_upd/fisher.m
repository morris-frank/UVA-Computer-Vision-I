function [X1_fisher, X2_fisher] = fisher(X1, X2, K_clusters)

[means, covariances, priors] = vl_gmm(X, K_clusters);
X1_fisher = vl_fisher(X1, means, covariances, priors);
X2_fisher = vl_fisher(X2, means, covariances, priors);

end
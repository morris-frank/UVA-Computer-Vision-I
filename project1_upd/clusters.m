function cluster_means = clusters(d_array, K)

[cluster_means, ~] = vl_kmeans(double(d_array'), K, 'Initialization', 'plusplus');
%[cluster_means, ~] = vl_ikmeans(uint8(d_array'), K, 'MaxIters', 800 , 'method', 'elkan', 'Verbose') ;
% 'MaxNumIterations', 100

end


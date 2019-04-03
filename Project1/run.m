vocab_size = 0.3;
nSVM = 100;
n_clusters = [400, 1000, 2500];
types = ["rgb_sift", "opponent_sift", "grey_sift"];

results = [];
for n = n_clusters
    for type = types
        fprintf('%s - %s\n', int2str(n), type)
        pr = run_experiment(type, n, vocab_size, nSVM);
        results = [results; {n,type,pr}];
    end
end
vocab_size = 0.5;
nSVM = 250;
n_clusters = [400, 1000, 2500];
types = ["rgb_sift", "opponent_sift", "grey_sift"];

results = [];
for n = n_clusters
    for type = types
        fprintf('%s - %s\n', int2str(n), type)
        pra = run_experiment(type, n, vocab_size, nSVM);
        results = [results; {n,type,pra}];
    end
end

for i = 1:size(results, 1)
     mpmr = mean(results{i,3});
    fprintf('%d\t%s\t%f\n',results{i,1},results{i,2},mpmr(1))
end
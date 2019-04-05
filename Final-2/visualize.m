function visualize(net)
    load data/cnn_assignment-lenet/imdb-stl.mat;
    
    if net.layers{end}.type == "softmaxloss"
        net.layers(end) = [];
    end
    
    features = zeros(size(images.data, 4), 64);

    for i = 1:size(images.data, 4)
        img = images.data(:,:,:,i);
        out = vl_simplenn(net, img);
        features(i, :) = squeeze(out(end-1).x);
    end
    
    tsne(features, images.labels)
end
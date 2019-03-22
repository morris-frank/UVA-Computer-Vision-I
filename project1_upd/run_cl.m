[X_rgb1, X_rgb2, ~, y_2] = load_split('train.mat', 100, 500);

d_array = get_dsift(X_rgb1, 2, 5);
cluster_means = clusters(d_array, 400);
[X_train, y_train] = prepare_for_svm(X_rgb2, y_2, cluster_means, 2, 5);

[model1, model2, model3, model4, model5] = train_models_linear(X_train, y_train);
%[model1, model2, model3, model4, model5] = train_models_gaussian(X_train, y_train);

[X_rgb1, ~, y_1, ~] = load_split('test.mat', 800, -1);
%d_array = get_dsift(X_rgb1, 2, 3);
[X_test, y_test] = prepare_for_svm(X_rgb1, y_1, cluster_means, 2, 5);

[map1, map2, map3, map4, map5] = test(X_test, y_test, model1, model2, model3, model4, model5);
[map1, map2, map3, map4, map5]

%d_array = get_dsift(X_rgb1, 2, 5);
%[X_test, y_test] = prepare_for_svm(X_rgb1, y_1, cluster_means, 2, 5);
%[map1, map2, map3, map4, map5] = test(X_test, y_test, model1, model2, model3, model4, model5);
%[map1, map2, map3, map4, map5]
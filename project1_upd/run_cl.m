[X_rgb1, X_rgb2, ~, y_2] = load_split('train.mat', 250, 500);

X_rgb1 = double(X_rgb1)./255;
X_rgb2 = double(X_rgb2)./255;
X_gray1 = to_gray(X_rgb1);
X_gray2 = to_gray(X_rgb2);


%imshow(reshape(X_rgb1(1, :, :, :), [96, 96, 3]))
%imshow(reshape(X_gray1(1, :, :), [96, 96]))


d_array = get_dsift(X_rgb1, 2, 5);
cluster_means = clusters(d_array, 1000);
[X_train, y_train] = prepare_for_svm(X_rgb2, y_2, cluster_means, 2, 5);

%[model1, model2, model3, model4, model5] = train_models_linear(X_train, y_train);
[model1, model2, model3, model4, model5] = train_models_gaussian(X_train, y_train);

[X_rgb1_test, ~, y_1_test, ~] = load_split('test.mat', 800, -1);

X_rgb1_test = double(X_rgb1_test)./255;
X_gray1_test = to_gray(X_rgb1_test);


[X_test, y_test] = prepare_for_svm(X_rgb1_test, y_1_test, cluster_means, 2, 5);

[map1, map2, map3, map4, map5] = test(X_test, y_test, model1, model2, model3, model4, model5);
[map1, map2, map3, map4, map5]


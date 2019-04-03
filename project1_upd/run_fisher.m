% fisher rvectors

sift_type = 2;
d_arr = d_array_rgb_2;
size_step = 5;

%{
[X_rgb1, X_rgb2, ~, y_2] = load_split('train.mat', 250, 500);
X_rgb1 = double(X_rgb1)./255;
X_rgb2 = double(X_rgb2)./255;
X_gray1 = to_gray(X_rgb1);
X_gray2 = to_gray(X_rgb2);
[X_rgb1_test, ~, y_1_test, ~] = load_split('test.mat', 800, -1);
X_rgb1_test = double(X_rgb1_test)./255;
X_gray1_test = to_gray(X_rgb1_test);

d_array_gray = get_dsift(X_gray1, 1, 5);
d_array_rgb_2 = get_dsift(X_rgb1, 2, 5);
d_array_rgb_3 = get_dsift(X_rgb1, 3, 5);
%}

K_clusters = 30;
[means, covariances, priors] = vl_gmm(d_arr', K_clusters);
[X_train_fisher, X_test_fisher] = fisher(X_rgb2, X_rgb1_test, means, covariances, priors, sift_type, size_step);

[model1_fisher, model2_fisher, model3_fisher, model4_fisher, model5_fisher] = train_models_gaussian(X_train_fisher, y_2);

[map1, map2, map3, map4, map5] = test(X_test_fisher, y_1_test, model1_fisher, model2_fisher, model3_fisher, model4_fisher, model5_fisher);
mean([map1, map2, map3, map4, map5])



K_clusters = 10
[means_10, covariances_10, priors_10] = vl_gmm(d_arr', K_clusters);
[X_train_fisher_10, X_test_fisher_10] = fisher(X_rgb2, X_rgb1_test, means_10, covariances_10, priors_10, sift_type, size_step);

[model1_fisher_10, model2_fisher_10, model3_fisher_10, model4_fisher_10, model5_fisher_10] = train_models_gaussian(X_train_fisher_10, y_2);

[map1, map2, map3, map4, map5] = test(X_test_fisher_10, y_1_test, model1_fisher_10, model2_fisher_10, model3_fisher_10, model4_fisher_10, model5_fisher_10);
mean([map1, map2, map3, map4, map5])


K_clusters = 50
[means_50, covariances_50, priors_50] = vl_gmm(d_arr', K_clusters);
[X_train_fisher_50, X_test_fisher_50] = fisher(X_rgb2, X_rgb1_test, means_50, covariances_50, priors_50, sift_type, size_step);

[model1_fisher_50, model2_fisher_50, model3_fisher_50, model4_fisher_50, model5_fisher_50] = train_models_gaussian(X_train_fisher_50, y_2);

[map1, map2, map3, map4, map5] = test(X_test_fisher_50, y_1_test, model1_fisher_50, model2_fisher_50, model3_fisher_50, model4_fisher_50, model5_fisher_50);
mean([map1, map2, map3, map4, map5])

K_clusters = 80
[means_80, covariances_80, priors_80] = vl_gmm(d_arr', K_clusters);
[X_train_fisher_80, X_test_fisher_80] = fisher(X_rgb2, X_rgb1_test, means_80, covariances_80, priors_80, sift_type, size_step);

[model1_fisher_80, model2_fisher_80, model3_fisher_80, model4_fisher_80, model5_fisher_80] = train_models_gaussian(X_train_fisher_80, y_2);

[map1, map2, map3, map4, map5] = test(X_test_fisher_80, y_1_test, model1_fisher_80, model2_fisher_80, model3_fisher_80, model4_fisher_80, model5_fisher_80);
mean([map1, map2, map3, map4, map5])


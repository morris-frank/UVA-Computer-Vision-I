%gray images
%[X_train, y_train, X_test, y_test] = prepare_for_SVM_upd('train.mat', 100, 500, 'test.mat', 800 , 1, 400);
%rgb imgaes
%[X_train_2, y_train_2, X_test_2, y_test_2] = prepare_for_SVM_upd('train.mat', 70, 500, 'test.mat', 800 , 2, 400);

[model1, model2, model3, model4, model5] = models_gaussian(X_train, y_train);
[map1, map2, map3, map4, map5] = test(X_test, y_test, model1, model2, model3, model4, model5);
[map1, map2, map3, map4, map5]

%rgb images: 0.4163    0.4543    0.5868    0.5583    0.5389
%gray images
%[X_train, y_train, X_test, y_test] = prepare_for_SVM_upd('train.mat', 100, 500, 'test.mat', 800 , 1, 400);
%rgb imgaes
%[X_train_2, y_train_2, X_test_2, y_test_2] = prepare_for_SVM_upd('train.mat', 70, 500, 'test.mat', 800 , 2, 400);

[model1, model2, model3, model4, model5] = models_linear(X_train, y_train);
[map1, map2, map3, map4, map5] = test(X_test, y_test, model1, model2, model3, model4, model5);
[map1, map2, map3, map4, map5]

%gray 0.4572    0.3228    0.5228    0.4714    0.5191
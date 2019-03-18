% run everything

[X_train, y_train, X_test, y_test] = prepare_for_SVM('train.mat', 200,'test.mat', 800 , 1, 100);
[model1, model2, model3, model4, model5] = models(X_train, y_train);
[map1, map2, map3, map4, map5] = test(X_test, y_test, model1, model2, model3, model4, model5);
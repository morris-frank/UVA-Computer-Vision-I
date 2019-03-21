function [model1, model2, model3, model4, model5] = models_gaussian(X_train, y_train)
y1 = y_train;
y1(y1 ~= 1) = 0;
model1 = fitcsvm(X_train, y1','Standardize',true, 'KernelFunction', 'gaussian','OptimizeHyperparameters','auto');

y2 = y_train;
y2(y2 ~= 2) = 0;
model2 = fitcsvm(X_train, y2','Standardize',true, 'KernelFunction', 'gaussian','OptimizeHyperparameters','auto');

y3 = y_train;
y3(y3 ~= 3) = 0;
model3 = fitcsvm(X_train, y3','Standardize',true, 'KernelFunction', 'gaussian','OptimizeHyperparameters','auto');

y4 = y_train;
y4(y4 ~= 7) = 0;
model4 = fitcsvm(X_train, y4','Standardize',true, 'KernelFunction', 'gaussian','OptimizeHyperparameters','auto');

y5 = y_train;
y5(y5 ~= 9) = 0;
model5 = fitcsvm(X_train, y5','Standardize',true, 'KernelFunction', 'gaussian','OptimizeHyperparameters','auto');

end
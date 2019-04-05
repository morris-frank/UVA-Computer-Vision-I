
function [map1, map2, map3, map4, map5] = test(X_test, y_test, model1, model2, model3, model4, model5)

[label1, score1] = predict(model1, double(X_test));
[label2, score2] = predict(model2, double(X_test));
[label3, score3] = predict(model3, double(X_test));
[label4, score4] = predict(model4, double(X_test));
[label5, score5] = predict(model5, double(X_test));

m = size(y_test);

t = [label1, score1(:, 1), y_test'];
out=sortrows(t,2);
r1 = out(:, 1) == out(:, 3);
map1 = map(r1, m(2)/5);

t = [label2, score2(:, 1), y_test'];
out=sortrows(t,2);
r2 = out(:, 1) == out(:, 3);
map2 = map(r2, m(2)/5);

t = [label3, score3(:, 1), y_test'];
out=sortrows(t,2);
r3 = out(:, 1) == out(:, 3);
map3 = map(r3, m(2)/5);

t = [label4, score4(:, 1), y_test'];
out=sortrows(t,2);
r4 = out(:, 1) == out(:, 3);
map4 = map(r4, m(2)/5);

t = [label5, score5(:, 1), y_test'];
out=sortrows(t,2);
r5 = out(:, 1) == out(:, 3);
map5 = map(r5, m(2)/5);


end
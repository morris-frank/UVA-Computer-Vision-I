function acc = knn(X_train, y_train, X_test, y_test)
Idx = knnsearch(X_train,X_test);
r = y_train(Idx) == y_test;

acc = sum(r)/length(r);
end
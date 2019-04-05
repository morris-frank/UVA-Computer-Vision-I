model1 = model1_3_400;
model2 = model2_3_400;
model3 = model3_3_400;
model4 = model4_3_400;
model5 = model5_3_400;
X_test = X_test_3_400;
X_img = X_rgb1_test;

 
colour_space  = 3;


[label1, score1] = predict(model1, double(X_test));
[label2, score2] = predict(model2, double(X_test));
[label3, score3] = predict(model3, double(X_test));
[label4, score4] = predict(model4, double(X_test));
[label5, score5] = predict(model5, double(X_test));

[top5, bottom5] = top_bottom_5(score1);

[X1_t, X2_t, X3_t, X4_t, X5_t] = get_img(X_img, colour_space, top5);
figure
subplot(2, 5, 1)
imshow(X1_t)

subplot(2,5, 2)
imshow(X2_t)

subplot(2, 5, 3)
imshow(X3_t)
title('Top 5')

subplot(2, 5, 4)
imshow(X4_t)

subplot(2, 5, 5)
imshow(X5_t)


[X1_b, X2_b, X3_b, X4_b, X5_b] = get_img(X_img, colour_space, bottom5);

%figure
subplot(2, 5, 6)
imshow(X1_b)

subplot(2, 5, 7)
imshow(X2_b)

subplot(2, 5, 8)
imshow(X3_b)
title('Bottom 5')

subplot(2, 5, 9)
imshow(X4_b)

subplot(2, 5, 10)
imshow(X5_b)

suptitle('Airplane class')


[top5, bottom5] = top_bottom_5(score2);

[X1_t, X2_t, X3_t, X4_t, X5_t] = get_img(X_img, colour_space, top5);
figure
subplot(2, 5, 1)
imshow(X1_t)

subplot(2,5, 2)
imshow(X2_t)

subplot(2, 5, 3)
imshow(X3_t)
title('Top 5')

subplot(2, 5, 4)
imshow(X4_t)

subplot(2, 5, 5)
imshow(X5_t)


[X1_b, X2_b, X3_b, X4_b, X5_b] = get_img(X_img, colour_space, bottom5);

%figure
subplot(2, 5, 6)
imshow(X1_b)

subplot(2, 5, 7)
imshow(X2_b)

subplot(2, 5, 8)
imshow(X3_b)
title('Bottom 5')

subplot(2, 5, 9)
imshow(X4_b)

subplot(2, 5, 10)
imshow(X5_b)

suptitle('Birds class')




[top5, bottom5] = top_bottom_5(score3);

[X1_t, X2_t, X3_t, X4_t, X5_t] = get_img(X_img, colour_space, top5);
figure
subplot(2, 5, 1)
imshow(X1_t)

subplot(2,5, 2)
imshow(X2_t)

subplot(2, 5, 3)
imshow(X3_t)
title('Top 5')

subplot(2, 5, 4)
imshow(X4_t)

subplot(2, 5, 5)
imshow(X5_t)


[X1_b, X2_b, X3_b, X4_b, X5_b] = get_img(X_img, colour_space, bottom5);

%figure
subplot(2, 5, 6)
imshow(X1_b)

subplot(2, 5, 7)
imshow(X2_b)

subplot(2, 5, 8)
imshow(X3_b)
title('Bottom 5')

subplot(2, 5, 9)
imshow(X4_b)

subplot(2, 5, 10)
imshow(X5_b)

suptitle('Cars class')



[top5, bottom5] = top_bottom_5(score4);

[X1_t, X2_t, X3_t, X4_t, X5_t] = get_img(X_img, colour_space, top5);
figure
subplot(2, 5, 1)
imshow(X1_t)

subplot(2,5, 2)
imshow(X2_t)

subplot(2, 5, 3)
imshow(X3_t)
title('Top 5')

subplot(2, 5, 4)
imshow(X4_t)

subplot(2, 5, 5)
imshow(X5_t)


[X1_b, X2_b, X3_b, X4_b, X5_b] = get_img(X_img, colour_space, bottom5);

%figure
subplot(2, 5, 6)
imshow(X1_b)

subplot(2, 5, 7)
imshow(X2_b)

subplot(2, 5, 8)
imshow(X3_b)
title('Bottom 5')

subplot(2, 5, 9)
imshow(X4_b)

subplot(2, 5, 10)
imshow(X5_b)

suptitle('Horses class')



[top5, bottom5] = top_bottom_5(score5);

[X1_t, X2_t, X3_t, X4_t, X5_t] = get_img(X_img, colour_space, top5);
figure
subplot(2, 5, 1)
imshow(X1_t)

subplot(2,5, 2)
imshow(X2_t)

subplot(2, 5, 3)
imshow(X3_t)
title('Top 5')

subplot(2, 5, 4)
imshow(X4_t)

subplot(2, 5, 5)
imshow(X5_t)


[X1_b, X2_b, X3_b, X4_b, X5_b] = get_img(X_img, colour_space, bottom5);

%figure
subplot(2, 5, 6)
imshow(X1_b)

subplot(2, 5, 7)
imshow(X2_b)

subplot(2, 5, 8)
imshow(X3_b)
title('Bottom 5')

subplot(2, 5, 9)
imshow(X4_b)

subplot(2, 5, 10)
imshow(X5_b)

suptitle('Ships class')







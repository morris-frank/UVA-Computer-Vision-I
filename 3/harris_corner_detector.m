function H = harris_corner_detector(image)

% should I transfrom it to gray?
I = im2double(rgb2gray(imread(image)));
I = im2double(imrotate(I,45));

RGB = imread(image);
RGB = im2double(imrotate(RGB,45));

%sobel as an approx. to 1D gaussian
Gx = [1, 0, -1; 2, 0, -2; 1, 0, -1];
Gy = [1, 2, 1; 0, 0, 0; -1, -2, -1];
G = fspecial('gauss');
Ix = double(imfilter(I, Gx));
Iy = double(imfilter(I, Gy));

%[Ix,Iy]=gaussgradient(I,sigma);

% is it element wise?!??!
Ix2 = Ix.*Ix;
Iy2 = Iy.*Iy;
Ixy = Ix.*Iy;

A = double(imfilter(Ix2, G));
B = double(imfilter(Ixy, G));
C = double(imfilter(Iy2, G));

N = size(A);
Nx = N(1);
Ny = N(2);


for i=1:Nx
    for j=1:Ny
        R_matrix(i, j) = (A(i, j)*C(i, j)-B(i, j)^2)- 0.04*(A(i, j)+C(i, j))^2;
    end
end

% non-max suppression
threshold = 0.01;

%max(R_matrix,[],'all')
 
H_ = padarray(R_matrix, [1, 1], 'replicate');

for i=1:Nx
    for j=1:Ny
        if R_matrix(i, j)>threshold && R_matrix(i, j)>H_(i, j+1) && R_matrix(i, j)>H_(i+2, j+1) && R_matrix(i, j)>H_(i+1, j) && R_matrix(i, j)>H_(i+1, j+2) && R_matrix(i, j)>H_(i, j) && R_matrix(i, j)>H_(i+2, j) && R_matrix(i, j)>H_(i, j+2) && R_matrix(i, j)>H_(i+2, j+2)
            H(i, j) = 1;
            RGB = insertShape(RGB, 'circle', [j, i, 3]);
        else
            H(i, j) = 0;
        

        end
            
    end
end





figure
subplot(1, 3, 1)
imshow(mat2gray(Ix))
title('Gradient x-direction')
subplot(1, 3, 2)
imshow(mat2gray(Iy))
title('Gradient y-direction')
subplot(1, 3, 3)
imshow(RGB)
title('H')

end


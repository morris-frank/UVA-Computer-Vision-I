function X = tracking(folder)

S = dir(fullfile(folder,'*.jpg'));
i = 0;
for k = 1:numel(S)
    
    F = fullfile(folder,S(k).name);
    I = imread(F);
    
    H = harris_corner_detector(I);
    
    
    if i == 1
        [Vx, Vy] = lucas_kanade(I, I2, H);
        
    elseif i == 0
        imshow(H)
    end
        
    i = 1;
    S(k).data = I;
    I2 = I;

end
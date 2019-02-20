close all
clear all
clc

image = 'SphereColor'; shadow_trick = false; 
image_dir = ['./' image '/']; 

for i = 1:3
    [image_stack(:,:,:,i), scriptV(:,:,i)] = load_syn_images(image_dir, i);
end

%index1 = [1:12:size(image_stack,3)]; %images to keep
%image_stack = image_stack(:,:,index1);
%scriptV = scriptV(index1,:);

[h, w, n, ~] = size(image_stack);
fprintf('Finish loading %d images.\n\n', n);

% compute the surface gradient from the stack of imgs and light source mat
disp('Computing surface albedo and normal map...')
albedo = zeros(size(image_stack,1),size(image_stack,2),3);
normals = zeros(size(image_stack,1),size(image_stack,2),3,3);
for i = 1:3    
    [albedo(:,:,i), normals(:,:,:,i)] = estimate_alb_nrm(image_stack(:,:,:,i), scriptV(:,:,i), shadow_trick);
end
% figure; imshow(albedo)
albedo = im2uint8(albedo);
if shadow_trick == true
    shtr = 'trick';
else shtr = 'notrick';
end
% imwrite(albedo,[write_dir,'albedo_',image, shtr, '.jpg'])
%% integrability check: is (dp / dy  -  dq / dx) ^ 2 small everywhere?
disp('Integrability checking')
normals_n = mean(normals,4);
[p, q, SE] = check_integrability(normals(:,:,:,3));

threshold = 0.005;
SE(SE <= threshold) = NaN; % for good visualization
fprintf('Number of outliers: %d\n\n', sum(sum(SE > threshold)));
figure; imshow(SE)
% imwrite(SE,[write_dir,'SE',image, shtr, '.jpg'])
%% compute the surface height
height_map = construct_surface( p, q, 'average' );

index2 = [1:25:512];
x = index2;
y = index2;
quiver3(height_map(index2,index2),normals(index2,index2,1),-normals(index2,index2,2),normals(index2,index2,3),'r')
hold on; surf(height_map(index2,index2))
zlim([-1, max(max(height_map))])
xlim([0, length(index2)]); ylim([0,length(index2)])

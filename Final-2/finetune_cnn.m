function [net, info, expdir] = finetune_cnn(varargin)

%% Define options
run(fullfile(fileparts(mfilename('fullpath')), ...
  'MatConvNet', 'matlab', 'vl_setupnn.m')) ;

opts.modelType = 'lenet' ;
[opts, varargin] = vl_argparse(opts, varargin) ;

opts.expDir = fullfile('data', ...
  sprintf('cnn_assignment-%s', opts.modelType)) ;
[opts, varargin] = vl_argparse(opts, varargin) ;

opts.dataDir = './data/' ;
opts.imdbPath = fullfile(opts.expDir, 'imdb-stl.mat');
opts.whitenData = true ;
opts.contrastNormalization = true ;
opts.networkType = 'simplenn' ;
opts.train = struct() ;
opts = vl_argparse(opts, varargin) ;
if ~isfield(opts.train, 'gpus'), opts.train.gpus = []; end;

opts.train.gpus = [];



%% update model
net = update_model();

%% TODO: Implement getIMDB function below

%{
if exist(opts.imdbPath, 'file')
  disp("running if");
  imdb = load(opts.imdbPath) ;
else
  disp("running else");
  imdb = getIMDB() ;
  mkdir(opts.expDir) ;
  save(opts.imdbPath, '-struct', 'imdb') ;
end
%}

disp("running getIMDB");
imdb = getIMDB() ;
disp("expdir: ");
disp(opts.expDir);
save(opts.imdbPath, '-struct', 'imdb') ;

%%
net.meta.classes.name = imdb.meta.classes(:)' ;

% -------------------------------------------------------------------------
%                                                                     Train
% -------------------------------------------------------------------------

trainfn = @cnn_train ;
[net, info] = trainfn(net, imdb, getBatch(opts), ...
  'expDir', opts.expDir, ...
  net.meta.trainOpts, ...
  opts.train, ...
  'val', find(imdb.images.set == 2)) ;

expdir = opts.expDir;
end
% -------------------------------------------------------------------------
function fn = getBatch(opts)
% -------------------------------------------------------------------------
switch lower(opts.networkType)
  case 'simplenn'
    fn = @(x,y) getSimpleNNBatch(x,y) ;
  case 'dagnn'
    bopts = struct('numGpus', numel(opts.train.gpus)) ;
    fn = @(x,y) getDagNNBatch(bopts,x,y) ;
end

end

function [images, labels] = getSimpleNNBatch(imdb, batch)
% -------------------------------------------------------------------------
images = imdb.images.data(:,:,:,batch) ;
labels = imdb.images.labels(1,batch) ;
if rand > 0.5, images=fliplr(images) ; end

end

% -------------------------------------------------------------------------
function imdb = getIMDB()
% -------------------------------------------------------------------------
% Preapre the imdb structure, returns image data with mean image subtracted
classes = {'airplane', 'bird', 'ship', 'horse', 'car'};
splits = {'train', 'test'};

%% TODO: Implement your loop here, to create the data structure described in the assignment
%% Use train.mat and test.mat we provided from STL-10 to fill in necessary data members for training below
%% You will need to, in a loop function,  1) read the image, 2) resize the image to (32,32,3), 3) read the label of that image

%%
%load('test.mat')
%load('train.mat')
%load('unlabeled.mat')

disp("##########################################");

filename = 'train.mat'
file = load(filename);
[n, ~] = size(file.X);
%Create imagestack+label reference
j = 1;
for i=1:n
    if ismember(file.class_names(file.y(i)), classes)
        img = reshape(file.X(i,:), [96,96,3]);
        imdb.images.data(:,:,:,j) = imresize(img,[32,32]);
        %map to 5 classes
        if file.y(i) == 1
            fiveclass = 1
        elseif file.y(i) == 2
            fiveclass = 2
        elseif file.y(i) == 9
            fiveclass = 3
        elseif file.y(i) == 7
            fiveclass = 4
        elseif file.y(i) == 3
            fiveclass = 5
        end                                   
        imdb.images.labels(1, j) = single(fiveclass);
        imdb.images.set(1, j) = 1
        j = j+1;
    end
end

filename = 'test.mat'
file = load(filename);
[n, ~] = size(file.X);
%Create imagestack+label reference
for i=1:n
    if ismember(file.class_names(file.y(i)), classes)
        img = reshape(file.X(i,:), [96,96,3]);
        imdb.images.data(:,:,:,j) = imresize(img,[32,32]);
        %map to 5 classes
        if file.y(i) == 1
            fiveclass = 1
        elseif file.y(i) == 2
            fiveclass = 2
        elseif file.y(i) == 9
            fiveclass = 3
        elseif file.y(i) == 7
            fiveclass = 4
        elseif file.y(i) == 3
            fiveclass = 5
        end                                   
        imdb.images.labels(1, j) = single(fiveclass);
        imdb.images.set(1, j) = 2
        j = j+1;
    end
end

%Show a random picture
%temp_3d = reshape(imdb.images.data(:,:,:,205), [32,32,3]);
%imshow(temp_3d)

% subtract mean
dataMean = mean(imdb.images.data(:, :, :, imdb.images.set == 1), 4);
data = bsxfun(@minus, double(imdb.images.data), double(dataMean));

imdb.images.data = single(data) ;
%imdb.images.labels = single(labels) ;
%imdb.images.set = sets;
imdb.meta.sets = {'train', 'val'} ;
imdb.meta.classes = classes;

perm = randperm(numel(imdb.images.labels));
imdb.images.data = imdb.images.data(:,:,:, perm);
imdb.images.labels = imdb.images.labels(perm);
imdb.images.set = imdb.images.set(perm);

end

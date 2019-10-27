%predict salient object saliency maps.
clear,clc
%caffe.reset_all();
addpath('/caffe_path/matlab');

%if you don't have a CUDA enabled GPU for acceleration, change
%it to 0, then the code will run slowly.
use_gpu=1;
gpu_id=0;
if use_gpu
  caffe.set_mode_gpu();
  caffe.set_device(gpu_id);
else
  caffe.set_mode_cpu();
end

modelname='CCRF_iter_4500.caffemodel';
protoname='deploy.prototxt';

net = caffe.Net(protoname, modelname, 'test');

mean_pix = [104.008, 116.669, 122.675];
alpha = 0.2 %for binarizing

imgRoot='./Img';
resRoot='./Result';

mkdir(resRoot);

modelfile = dir(imgRoot);
isfold = [modelfile(:).isdir];
modelname = {modelfile(isfold).name}';
modelname(ismember(modelname,{'.','..'})) = [];

for imodel = 1:length(modelname)
    imgFiles=dir([imgRoot '/' modelname{imodel} '/' '*' 'g']);
    imgNum=length(imgFiles);
    imgPath = [imgRoot '/' modelname{imodel}];
    resPath = [resRoot '/' modelname{imodel}];
    mkdir(resPath);
    for i=1:imgNum
        disp(['Processing the ' num2str(i) 'st image out of ' num2str(imgNum)]);

        im=imread([imgPath '/' imgFiles(i).name]);
        if size(im,3)==1
            im = cat(3, im, im, im);
        end
        im = single(im);
        img = imresize(im, [240, 320]);
        img = img(:, :, [3 2 1]);
        img = permute(img, [2 1 3]); 
        for c = 1:3
            img(:, :, c) = img(:, :, c) - mean_pix(c);
        end
        net.blobs('data').set_data(img);
        net.forward_prefilled();

		%sm=imresize((net.blobs('predicted-map4-sig').get_data())',[size(im,1),size(im,2)]);
        sm=imresize((net.blobs('predicted-map4').get_data())',[size(im,1),size(im,2)]);
        sm = 1./(exp(-(1+alpha)*sm)+1);
        sm= (sm-min(sm(:)))./(max(sm(:))-min(sm(:)));
        imwrite(sm,[resPath '/' imgFiles(i).name]);
    end   
end

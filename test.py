import numpy as np
from skimage.data import imread
import os
import cv2 as cv
import os, errno
import sys

caffe_root = '/caffe_path/'
sys.path.insert(0, caffe_root + 'python')

import caffe

EPSILON = 1e-8
img_width = 320
img_height = 240
alpha = 0; # for binarizing

data_root = './Img/'
res_root = './Result/'

#remove the following two lines if testing with cpu
caffe.set_mode_gpu()
# choose which GPU you want to use
caffe.set_device(0)
caffe.SGDSolver.display = 1

# load net
net = caffe.Net('./deploy.prototxt', './CRF_iter_4500.caffemodel', caffe.TEST)

if not os.path.exists(res_root):
    os.makedirs(res_root)

for main_root, main_dirs, iii in os.walk(data_root):
    for datafolder in main_dirs:
        dataset_path = os.path.join(data_root,datafolder)
        result_path = os.path.join(res_root,datafolder)
        if not os.path.exists(result_path):
            os.makedirs(result_path)
            
        for root, dirs, filenames in os.walk(dataset_path):
            for f in filenames:
                img_path = os.path.join(dataset_path,f)
                img = imread(img_path)
                height, width = img.shape[:2]
                img = cv.resize(img, (img_width, img_height))
                img = np.array(img, dtype=np.uint8)
                im = np.array(img, dtype=np.float32)
                if im.ndim<3:
                    im = cv.cvtColor(im, cv.COLOR_GRAY2RGB)

                im = im[:, :, ::-1]
                im -= np.array((104.00698793, 116.66876762, 122.67891434))
                im = im.transpose((2, 0, 1))

                # shape for input (data blob is N x C x H x W), set data
                net.blobs['data'].reshape(1, *im.shape)
                net.blobs['data'].data[...] = im
                # run net and take argmax for prediction
                net.forward()
				#res = net.blobs['predicted-map4-sig'].data[0][0, :, :]
                res = net.blobs['predicted-map4'].data[0][0, :, :]
                res = 1 / (1 + np.exp(-(1+alpha)*res))
                res = cv.resize(res, (width, height))
                res = (res - np.min(res)) / (np.max(res) - np.min(res))
                res = res* 255
                res_path = os.path.join(result_path, f)
                cv.imwrite(res_path, res)

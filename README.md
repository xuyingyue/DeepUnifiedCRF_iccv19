# DeepUnifiedCRF_ICCV19

Main code for the ICCV2019 paper "Structured Modeling of Joint Deep Feature and Prediction Refinement for Salient Object Detection". [Arxiv Link](https://arxiv.org/pdf/1909.04366)

## Caffe Installation
Please install Caffe with the continous CRF layers based on the work [ContinuousCRF-CNN](https://arxiv.org/pdf/1704.02157.pdf). 

```
cd <caffe_root>/examples
git clone https://github.com/danxuhk/ContinuousCRF-CNN.git
```

## Training & Testing
1. The training code can be found in `run_sal.py`.
2. The solver can be found in `solver.prototxt`.
3. The network protocol can be found in `train.prototxt`.
4. The corresponding files for pre-training are listed in the `pretrain` folder.
5. The testing code can be found in `test.m` or `test.py`. We used the matlab code in our own experiement.


## Pre-trained Model
The model can be downloaded [here](https://drive.google.com/open?id=11ZRdobvUDY49_FG0SyiD6d77LiMeSwu8).
Note that this released model is newly trained and is slightly different from the one reported in our paper.

## Saliency Maps
The resulted saliency maps can be downloaded [here](https://drive.google.com/open?id=1CPB7G7w4Fb_74oIQ4L9ZrUbKrRQNrdHE).


## Citation
```
@inproceedings{xu2019deepcrf, 
  title={Structured Modeling of Joint Deep Feature and Prediction Refinement for Salient Object Detection}, 
  author={Xu, Yingyue and Xu, Dan and Hong, Xiaopeng and Ouyang, Wanli and Ji, Rongrong and Xu, Min and Zhao, Guoying}, 
  booktitle={ICCV}, 
  year={2019}
} 

ContinuousCRF-CNN:
@article{xu2018monocular,
  title={Monocular Depth Estimation using Multi-Scale Continuous CRFs as Sequential Deep Networks},
  author={Xu, Dan and Ricci, Elisa and Ouyang, Wanli and Wang, Xiaogang and Sebe, Nicu},
  journal={IEEE TPAMI},
  year={2018}
}
```

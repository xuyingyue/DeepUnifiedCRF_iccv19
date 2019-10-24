# DeepUnifiedCRF_ICCV19

Main code for the ICCV2019 paper "Structured Modeling of Joint Deep Feature and Prediction Refinement for Salient Object Detection". [Arxiv Link](https://arxiv.org/pdf/1909.04366)

## Caffe Installation
Please install Caffe with the continous CRF layers based on the work [ContinuousCRF-CNN](https://arxiv.org/pdf/1704.02157.pdf). 

```
cd <caffe_root>/examples
git clone https://github.com/danxuhk/ContinuousCRF-CNN.git
```

##







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

##PTB-TIR: A Thermal Infrared Pedestrian Tracking Benchmark (TMM19)
This toolkit is used to evaluate the tracker on the thermal infrared pedestrian tracking benchmark, PTB-TIR.
##News
* We correct some annotation mistakes, so the results are slightly different from the results of the paper. 
* We evaluate more trackers on the benchmark and provide their results in the raw results.
##Download dataset and  raw results
* You can download the overall **dataset** from [Baidu Pan](https://pan.baidu.com/s/1RHhvc7fOA9QF5uHJ2LNdQQ) or Goggle Drive or [Local](http://www.hezhenyu.cn/UpLoadFiles/dataset/tirsequences_new.rar).
* You can download  the **raw results** of 27 trackers from [Baidu Pan](https://pan.baidu.com/s/184B11HWgSrrLEdR_gLbO1g) or [Google Drive](https://drive.google.com/open?id=1m1evJbTBpl_R4oAnsQQnV9NFpZ58J9DW) or [Local](http://www.hezhenyu.cn/UpLoadFiles/dataset/results_OPE_all.rar).
##Usage
1. Download this toolkit and unzip it in your computer.
2. Download and unzip the raw results and put it into the `results` folder of the toolkit.
3. Download and unzip the dataset and put it into the toolkit.
4. Now, you can run `run_evaluation.m` and `run_speed.m` to draw the result plots.
5. You can configure `configTrackers.m` and then use `run_tracker_interface.m` to run your own tracker on the benchmark.
##Result's plots
![Alt text](./figs/results_OPE_all/results.jpg)
## Trackers and codes
### TIR trackers
* **ECO-stir.**  Zhang L, et al. Synthetic data generation for end-to-end thermal infrared tracking, TIP, 2018. [[Github]](https://github.com/zhanglichao/generatedTIR_tracking)
*  **MLSSNet.** Liu Q, et al, Learning Deep Multi-Level Similarity for Thermal Infrared Object Tracking, arXiv, 2019. [[Paper]](https://arxiv.org/abs/1906.03568)
*  **HSSNet.**  Li X, et al, Hierarchical spatial-aware Siamese network for thermal infrared object tracking, KBS, 2019.[[Github]](https://github.com/QiaoLiuHit/HSSNet)
*  **MCFTS.** Liu Q, et al, Deep convolutional neural networks for thermal infrared object tracking, KBS, 2017. [[Github]](https://github.com/QiaoLiuHit/MCFTS) 
###RGB trackers
* **ECO.** Danelljan M, et al, ECO: efficient convolution operators for tracking, CVPR, 2017. [[Github]](https://github.com/martin-danelljan/ECO)
*  **DeepSTRCF.** Li F et al, Learning spatial-temporal regularized correlation filters for visual tracking, CVPR, 2018. [[Github]](https://github.com/lifeng9472/STRCF)
*  **MDNet.** Nam H, et al, Learning multi-domain convolutional neural networks for visual tracking, CVPR, 2016. [[Github]](https://github.com/hyeonseobnam/MDNet)
* **SRDCF.**  Danelljan M, et al, Learning spatially regularized correlation filters for visual tracking, ICCV, 2015. [[Project]](https://www.cvl.isy.liu.se/research/objrec/visualtracking/regvistrack/)
* **VITAL.** Song Y, et al., Vital: Visual tracking via adversarial learning, CVPR, 2018. [[Github]](https://github.com/ybsong00/Vital_release)
* **TADT.** Li X, et al, Target-aware deep tracking, CVPR, 2019. [[Github]](https://github.com/XinLi-zn/TADT)
* **MCCT.** Wang N, et al, Multi-cue correlation filters for robust visual tracking, CVPR, 2018. [[Github]](https://github.com/594422814/MCCT)
* **Staple.** Bertinetto, L, et al, Staple: Complementary learners for real-time tracking, CVPR, 2016. [[Github]](https://github.com/bertinetto/staple)
* **DSST.** Danelljan M, et al, Accurate scale estimation for robust visual tracking, BMVC, 2014. [[Github]](https://github.com/gnebehay/DSST)
* **UDT.** Wang N, et al, Unsupervised deep tracking, CVPR, 2019. [[Github]](https://github.com/594422814/UDT)
* **CREST.** Song Y, et al, Crest: Convolutional residual learning for visual tracking, ICCV, 2017. [[Github]](https://github.com/ybsong00/CREST-Release)
*  **SiamFC.** Bertinetto, L, et al, Fully-Convolutional Siamese Networks for Object Tracking, ECCVW, 2016. [[Github]](https://github.com/bertinetto/siamese-fc)
*  **SiamFC-tri.** Dong X, et al, Triplet loss in Siamese network for object tracking, ECCV, 2018. [[Github]](https://github.com/shenjianbing/TripletTracking)
*  **HDT.** Qi Y, et al, Hedged deep tracking, CVPR, 2016. [[Project]](https://sites.google.com/site/yuankiqi/hdt/)
*  **CFNet.**  Valmadre, J, et al,  End-to-end representation learning for correlation filter based tracking, CVPR, 2017. [[Github]](https://github.com/bertinetto/cfnet)
*   **HCF.** Ma, C, et al, Hierarchical convolutional features for visual tracking, ICCV, 2015. [[Github]](https://github.com/jbhuang0604/CF2)
*   **L1APG.** Bao, C, et al,  Real time robust L1 tracker using accelerated proximal gradient approach, CVPR, 2012. [[Project]](http://www.dabi.temple.edu/~hbling/code_data.htm)
*  **SVM.** Wang N, et al, Understanding and diagnosing visual tracking systems, ICCV, 2015. [[Project]](http://winsty.net/tracker_diagnose.html)
*  **KCF.** Henriques, J, et al, High-speed tracking with kernelized correlation filters, TPAMI, 2015. [[Project]](http://www.robots.ox.ac.uk/~joao/circulant/)
*  **DSiam.** Guo, Q, et al, Learning dynamic siamese network for visual object tracking, ICCV, 2017. [[Github]](https://github.com/tsingqguo/DSiam)
##Citation
If you use this benchmark, please consider citing our paper.

```
@article{PTB-TIR,
  title={PTB-TIR: A Thermal Infrared Pedestrian Tracking Benchmark},
  author={Liu, Qiao and He, Zhenyu and Li, Xin and Zheng, Yuan},
  journal={IEEE Transactions on Multimedia},
  year={2019},
  DOI ={10.1109/TMM.2019.2932615}
}
```
##Contact
Feedbacks and comments are welcome! 
Feel free to contact us via liuqiao.hit@gmail.com or liuqiao@stu.hit.edu.cn
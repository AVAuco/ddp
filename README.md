# 3D Pose Estimation from Depth Maps using a Deep combination of Poses

This is support code for [1].

Visit the [project web page](http://www.uco.es/~in1majim/research/ddp.html) (under construction) for further information.

## Quick start

This code has been tested on Ubuntu 16.04 with Matlab R2017a and [MatConvNet-1.0-beta25](http://www.vlfeat.org/matconvnet/)  
Inside Matlab, type the following commands:  

```
run <matconvnet_root>/matlab/vl_setupnn.m  
cd <ddp_root>  
addpath(genpath(pwd))  
mj_testITOPmodel  

```
If everything worked fine, a new figure showing the estimated poses should be opened.

## Qualitative results

Video with estimations on ITOP:  
[![Estimations on ITOP](https://img.youtube.com/vi/4gPI-GOf9wg/0.jpg)](https://www.youtube.com/watch?v=4gPI-GOf9wg "Watch video")


## References

[1] [Manuel J. Marin-Jimenez](http://www.uco.es/~in1majim/), Francisco J. Romero-Ramirez, Rafael Muñoz-Salinas, Rafael Medina-Carnicer  
[*3D Pose Estimation from Depth Maps using a Deep combination of Poses*](https://arxiv.org/abs/1807.05389)  
Journal of Visual Communication and Image Representation (in press), 2018   

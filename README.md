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

![Estimations on ITOP](http://www.uco.es/~in1majim/research/media/itopresults.mp4)


## References

[1] Manuel J. Marin-Jimenez, Francisco J. Romero-Ramirez, Rafael Muñoz-Salinas, Rafael Medina-Carnicer  
*3D Pose Estimation from Depth Maps using a Deep combination of Poses*  
Journal of Visual Communication and Image Representation (in press), 2018   

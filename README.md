# 3D Pose Estimation from Depth Maps using a Deep combination of Poses

This is support code for [1].

Visit the [project web page](http://www.uco.es/~in1majim/research/ddp.html) for further information.

<div align="center">
  <img src="https://www.uco.es/~in1majim/research/images/pipeline_ddp.jpg"><br><br>
</div>

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
Alternatively, after the setup steps, you can run the following demo:  
```
mj_testITOPmodel_frontal
```

Note that first of all you have to download the 'mat' data files as indicated in the folder 'Data'.

## Code reference

### How to load the original ITOP data?

An example of how to read the ITOP depth maps and skeletons can be found in:
```
Utils/mj_loadITOPdataFromH5
```

## Qualitative results

Video with estimations on ITOP:  
<div align="center">
<a href="https://www.youtube.com/watch?v=4gPI-GOf9wg" alt="Watch video" title="Watch video">
<img src="https://img.youtube.com/vi/4gPI-GOf9wg/0.jpg">
</a>
</div>

## References

[1] [Manuel J. Marin-Jimenez](http://www.uco.es/~in1majim/), Francisco J. Romero-Ramirez, Rafael Muñoz-Salinas, Rafael Medina-Carnicer  
[*3D Pose Estimation from Depth Maps using a Deep combination of Poses*](https://arxiv.org/abs/1807.05389)  
Journal of Visual Communication and Image Representation (in press), 2018
```
@Article{Marin18ijvcr,
  author     = "Marin-Jimenez, M.J. and Romero-Ramirez, F.J. and Mu\~noz-Salinas, R. and Medina-Carnincer, R.",
  title      = "3D Pose Estimation from Depth Maps using a Deep combination of Poses",
  journal    = "Journal of Visual Communication and Image Representation",
  year       = "2018",
  doi  = "https://doi.org/10.1016/j.jvcir.2018.07.010",
  note = "In press"
}
```

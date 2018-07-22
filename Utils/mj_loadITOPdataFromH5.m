% File: mj_loadITOPdataFromH5.m
%
% Sample code for loading data from ITOP dataset h5-files
%
% (c) MJMJ/2018

% Download and unzip data files. For example,
%  https://www.albert.cm/projects/viewpoint_3d_pose/data/ITOP_side_test_depth_map.tgz
%  https://www.albert.cm/projects/viewpoint_3d_pose/data/ITOP_side_test_labels.tgz

% Set your path
depthfile = '/home/mjmarin/databases/itop/ITOP_side_test_depth_map.h5';
labelsfile = '/home/mjmarin/databases/itop/ITOP_side_test_labels.h5';

displayFigure = false; % Set me to show what is loaded

% Show info about files
h5disp(depthfile)
h5disp(labelsfile)

is_valid = h5read(labelsfile,'/is_valid');

idx_list = find(is_valid > 0);

id_itop_all = h5read(labelsfile,'/id');
id_itop = id_itop_all(idx_list);

nsamples = length(idx_list);
depthM = zeros(100,100,nsamples, 'single');
jointsM = zeros(45,nsamples, 'single');
jointsMcent = zeros(45,nsamples, 'single');
ns = 0;

for idx = idx_list'
   fprintf('* Image %d \r', idx);
   init = 1+(320*240*(idx-1));
   
   [i_,j_,k_] = ind2sub([320,240,10501],init);
   masks = h5read(labelsfile,'/segmentation', [i_,j_,k_], [320,240,1]);
      
   %% Read depth map
   depthmap = h5read(depthfile,'/data', [i_,j_,k_], [320,240,1]);
      
   dcropFull = depthmap(41:280,:)';
   dcropFull = imresize(dcropFull, [100, 100], 'nearest');
   dcropFull = mj_rescale(dcropFull, 0, 1);
   
   %% Get joints
   joints = h5read(labelsfile,'/real_world_coordinates', [i_,j_,k_], [3,15,1]);

   if displayFigure
      figure(3); clf
      subplot(1,2,1);
      imagesc(dcropFull); axis image, axis off
      
      subplot(1,2,2);
      hdl = mj_drawPose3DITOP(joints, gcf);
      drawnow
      pause      
   end

   %% Store
   ns = ns + 1;
   jointsM(:,ns) = joints(:);
   
   depthM(:,:,ns) = dcropFull;

   % Center skeleton
   ca = joints(:,2);
   cb = joints(:,9);
   cjnt = (ca+cb)*0.5;
   jointsC = bsxfun(@minus, joints, cjnt);
   jointsMcent(:,ns) =jointsC(:);
end

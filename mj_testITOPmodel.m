% Demo of DDP model on ITOP dataset
%
% (c) MJMJ/2018


% IMPORTANT: matconvnet library is needed!

%% Load model
disp('Loading model...');
netdir = './Data/';

matnet = fullfile(netdir, 'net_ITOP_top_noseg.mat');

load(matnet)

net = dagnn.DagNN.loadobj(net) ;
net.mode = 'test' ;

% if gpuDeviceCount > 0
%    net.move('gpu');
% else
%    net.move('cpu');
% end

%% Load sample test data
disp('Loading data...');
datadir = './Data/';
matimdb = fullfile(datadir, 'samples_ITOP_top_noseg.mat');

load(matimdb);

%% Estimating poses
disp('Estimating poses...');
batchSize = 64;
meanSample = metanet.mean;
meanJoint = metanet.meanJoint;
varJoint = metanet.varJoint;

preData = bsxfun(@minus, samples.data, meanSample);
tic
% Get weights
weightsC = mj_evalLCPoseNet(net, preData, batchSize);
% Apply linear combination
mEstimatedJoints = mj_getFullPoseLincomb(weightsC, samples.centroids, meanJoint, varJoint);

time_net = toc;
time_net_per_sample = (1000*time_net) / size(preData,3);
fprintf('\t Time per sample: %f ms\n', time_net_per_sample);

%% Load parameters for rotating cameras
load(fullfile(datadir, 'campars.mat'));

Ttf = pinv(regParams.M);
% Show results
for ix = 1:size(mEstimatedJoints,2)
   hdl = figure(9); clf
   subplot(2,2,1)
   imagesc(samples.data(:,:,ix)); axis image, axis off
   title('Input sample')
   
   subplot(2,2,4);
   mj_drawPose3DITOP(mEstimatedJoints(:,ix), gcf, 'c'); axis off
   title('Estimated pose')
   
   % GT pose
   subplot(2,2,3);
   mj_drawPose3DITOP(samples.joints_gt(:,ix), gcf, 'g'); axis off
   title('Ground-truth pose')
   
   % Animated model: changing viewpoint
   transfP_ = Ttf * [reshape(mEstimatedJoints(:,ix), 3,[]);  ones(1,15)];
   transfP = transfP_(1:3,:);   
   
   subplot(2,2,2);
   mj_drawPose3DITOP(transfP, gcf, 'c'); axis off
   %title('Estimated pose - different viewpoint')
   
   set(gcf, 'Position', [10 10 720 480]);
   set(gcf, 'Name', sprintf('Sample %03d', ix));
   set(gcf, 'Color', 'white');
         
   for aa = 0:10:180, view(aa, 135), drawnow,pause(1/25), end
   
end

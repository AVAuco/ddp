% Demo of DDP model on ITOP dataset
%
% (c) MJMJ/2018


% IMPORTANT: matconvnet library is needed!

%% Load model
disp('Loading model...');
netdir = './Data/';

matnet = fullfile(netdir, 'net_ITOP_frontal_noseg.mat');

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
matimdb = fullfile(datadir, 'samples_ITOP_frontal_noseg.mat');

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


%% Show results
for ix = 1:size(mEstimatedJoints,2)
   hdl = figure(9); clf
   subplot(2,2,1)
   imagesc(samples.data(:,:,ix)); axis image, axis off
   title('Input sample')

   % GT pose
   subplot(2,2,3);
   mj_drawPose3DITOP(samples.joints_gt(:,ix), gcf, 'g'); axis off
   title('Ground-truth pose')   
   
   % Estimated pose
   subplot(2,2,4);
   mj_drawPose3DITOP(mEstimatedJoints(:,ix), gcf, 'c'); axis off
   title('Estimated pose')
              
   set(gcf, 'Color', 'white')
   set(gcf, 'Position', [10 10 720 480]);
   set(gcf, 'Name', sprintf('Sample %03d', ix));


   drawnow
   pause(1/15)
end

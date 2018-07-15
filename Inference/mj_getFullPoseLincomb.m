function poses = mj_getFullPoseLincomb(W, centroids, meanJoint, varJoint)
% poses = mj_getFullPoseLincomb(W, centroids, meanJoint, varJoint)
% COMMENT ME!!!
%
%
% (c) MJMJ/2018

images.centroids = bsxfun(@minus, centroids, meanJoint);
images.centroids = bsxfun(@rdivide, images.centroids, sqrt(varJoint));

estimated = images.centroids * W;

estimated = bsxfun(@times, estimated, sqrt(varJoint));
poses = bsxfun(@plus, estimated, meanJoint);

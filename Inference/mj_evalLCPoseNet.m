function weights = mj_evalLCPoseNet(net, samples, batchSize)
% weights = mj_evalLCPoseNet(net, samples, batchSize)
% Given samples, estimate weigths of prototype poses
%
% Inputs:
%  - net:
%  - samples: matrix [nrows, ncols, nsamples] 
%
% Outputs:
%  - weights: for linear combination
% 
% (c) MJMJ/2018


weights = [];

nsamples = size(samples, 3);
nBatches = floor(nsamples / batchSize);
nRemaining = nsamples - (nBatches*batchSize);

gpuMode = 0;
if strcmp(net.device, 'gpu')
   gpuMode = 1;   
end

% if gpuMode
%    samples = gpuArray(samples);
% end

%% Process batches

batch = zeros(size(samples,1), size(samples,2), 1, batchSize, 'single');
for bix = 1:nBatches+1
   if bix == nBatches+1 % remaining samples      
      batch = zeros(size(samples,1), size(samples,2), 1, nRemaining, 'single');
      batch(:,:,1,:) = samples(:,:, 1+(bix-1)*batchSize:end);
   else
      batch(:,:,1,:) = samples(:,:, 1+(bix-1)*batchSize:bix*batchSize);
   end
   
   if isempty(batch)
      continue
   end
   
   if gpuMode
      net.eval({'input', gpuArray(batch)}) ;
   else      
      net.eval({'input', batch}) ;
   end
   
   full02j = net.vars(net.getVarIndex('full02j')).value;
   
   if gpuMode
      offsets_ = squeeze(gather(full02j));
   else
      offsets_ = squeeze(full02j);
   end
   
   if isempty(weights) % Create it
      weights = zeros(size(offsets_,1), nsamples, class(offsets_));
   end
   weights(:, 1+(bix-1)*batchSize:min(bix*batchSize, nsamples)) = offsets_;
         
end % bix


end


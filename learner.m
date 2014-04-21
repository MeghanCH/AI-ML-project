
% Train neural network

%% PCA 
[eigenvectors,weights,latent,~,variance] = pca(audio_data_compressed');
data_mean = mean(audio_data_compressed');
s = 0;
count = 1;
while (s<90)
    s = s+variance(count);
    count = count+1;
end
data_projected = weights(:,1:count);

%% Train neural network
setdemorandstream(491218382);
net = feedforwardnet(50);
net.divideParam.trainRatio = 0.99;
net.divideParam.valRatio = 0.01;
net.divideParam.testRatio = 0;
[net,tr]=train(net,data_projected',label);

% save('models/videoModel.mat','net', 'data_mean', 'eigenvectors','count')

%% Testing
% test_data_compressed_mean = bsxfun(@minus,test_data_compressed',data_mean);
% weights_test_data = test_data_compressed_mean*eigenvectors(:,1:count);
% test_y = net(weights_test_data');
% test_l = vec2ind(test_y);

test_y = net(data_projected');
test_l = vec2ind(test_y);

% test_l = svmclassify(svmstruct,data_projected);
%% manual  neural network running variable

d = data_projected';
t = weights_test_data';


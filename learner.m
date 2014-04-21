function [net,options,data_mean,count,eigenvectors] = learner(data,label)
% PCA 
[eigenvectors,weights,latent,~,variance] = pca(data');
data_mean = mean(data');
s = 0;
count = 1;
while (s<90)
    s = s+variance(count);
    count = count+1;
end
data_projected = weights(:,1:count);
% Train neural network

% setdemorandstream(491218382);
% net = feedforwardnet(50);
% net.divideParam.trainRatio = 0.99;
% net.divideParam.valRatio = 0.01;
% net.divideParam.testRatio = 0;
% [net,tr]=train(net,data_projected',label);

net = mlp(count,100,26,'logistic');
options = zeros(1,18);
options(1)=1; %display iteration values
options(14)=1000; %maximum number of training cycles (epochs)

[net,options]=netopt(net,options,data_projected,label','scg');
end
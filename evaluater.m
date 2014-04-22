
% Script to repeat training and testing while varying parameters

% Make sure data is cleansed and seperated before starting 

N = 10; % number of node iterations
M = 10; % number of max iterations
accuracyTest = zeros(M,N); 
accuracyTrain = zeros(M,N); 

% Build accuracy matrices 
for ii=1:N

    for jj=1:M
        [net,options,data_mean,count,eigenvectors] = learner(train_video,train_label,ii*20, jj*50);
        accuracyTrain(ii,jj) = tester(net,data_mean,count,eigenvectors,train_video,train_label);
        accuracyTest(ii,jj) = tester(net,data_mean,count,eigenvectors,test_video,test_label);
    end
end
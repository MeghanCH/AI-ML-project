
% Script to repeat training and testing while varying parameters

% Make sure data is cleansed and seperated before starting 

N = 15; % number of iterations
accuracy = zeros(1,N); 

for iter=1:N

    [net,options,data_mean,count,eigenvectors] = learner(train_video,train_label,iter*10);
    accuracy(iter) = tester(net,data_mean,count,eigenvectors,test_video,test_label);

end
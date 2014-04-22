
% Seperate clean data into training and testing set

%% load
load('cleanData/data.mat')

%% Seperate

percentTrain = 70;
percentTest =  30; 

numSamples = size(video_data_compressed,2); 
numTrainSamples = floor(70/100*numSamples); 
numTestSamples = numSamples - numTrainSamples; 

p = randperm(numSamples);
idx_train = p(1:numTrainSamples);
idx_test = p((numTrainSamples + 1):end);

%training data
train_audio = audio_data_compressed(:,idx_train);
train_video = video_data_compressed(:,idx_train);
train_label = label(:,idx_train);

%test data
test_audio = audio_data_compressed(:,idx_test);
test_video = video_data_compressed(:,idx_test);
test_label = label(:,idx_test);
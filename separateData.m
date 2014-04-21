load('E:\Documents\MATLAB\24-787\av character classification\cleanData\data.mat')
%% separate data into train and test
p = randperm(size(video_data_compressed,2));
idx_train = p(1:(size(video_data_compressed,2)-50));
idx_test = p((length(idx_train)+1):end);

%training data
train_audio = audio_data_compressed(:,idx_train);
train_video = video_data_compressed(:,idx_train);
train_label = label(:,idx_train);

%test data
test_audio = audio_data_compressed(:,idx_test);
test_video = video_data_compressed(:,idx_test);
test_label = label(:,idx_test);
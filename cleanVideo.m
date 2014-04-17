% Ryler Hockenbury
% 4/17/2014
% Clean video data 

function [cleanData] = cleanVideo(inputData)
% Clean the video frames by grayscaling and cropping

n = size(inputData, 4);
for i = 1:n
    grayData(:,:,i) = rgb2gray(im2double(inputData(:,:,:,i))); 
    cropData(:,:,i) = grayData(121:end, 81:240, i);
    videoData(:,:,i) = cropData(66:95, 58:103, i); 
    
    %figure(i)
    %imshow(videoData(:,:,i)); % show cleaned video frames
end

cleanData = videoData(:); % flatten

end


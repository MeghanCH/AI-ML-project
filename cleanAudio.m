% Ryler Hockenbury
% 4/17/2014
% Clean audio data 

function [cleanData] = cleanAudio(inputData)
% clean the audio frames by windowing

n = size(inputData, 1);

% find the peak and the associated index
peak = max(inputData);
peakIndex = find(inputData == peak);

peakIndexSize = size(peakIndex,2);

if(peakIndexSize > 1)
    peakIndex = floor(mean(peakIndex));
end

% set up a box filter
width = 4000; 
filterLength = 30000; 
audioData = zeros(1,width); 

filter = zeros(1,filterLength);
filter(filterLength/2 - width/2:filterLength/2 + width/2) = 1;

tempData = zeros(1,filterLength); 

if(n <= filterLength)
    tempData(1:n) = inputData; 
else
    disp('Need longer filter length.'); 
end

% align signal peak with center of box
shift = floor(filterLength/2 - peakIndex);
tempData = circshift(tempData(:), shift);

temp = filter.*tempData'; 
audioData = temp(filterLength/2 - width/2 + 1: filterLength/2 + width/2); 

%visualize filter
% subplot(2,1,1)
% plot(filter,'r');
% hold on
% plot(tempData,'b'); 
% hold on
% 
% subplot(2,1,2)
% plot(audioData); 
% 
% pause(2)
% clf

cleanData = audioData(:); % flatten

end
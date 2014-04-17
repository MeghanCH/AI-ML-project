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
filterLength = 24000; 
audioData = zeros(1,width); 

filter = zeros(1,filterLength);
filter(filterLength/2 - width/2:filterLength/2 + width/2) = 1;

% align center of box with signal peak
shift = floor(filterLength/2 - peakIndex);
filter = circshift(filter', -shift);

inputData(n:filterLength) = 0; 
temp = filter.*inputData; 
audioData = temp(filterLength/2 - shift - width/2: filterLength/2 - shift + width/2); 

% visualize filter
% subplot(2,1,1)
% plot(filter,'r');
% hold on
% plot(inputData,'b'); 
% 
% subplot(2,1,2)
% plot(audioData); 
% 
% pause(2)
% clf

cleanData = audioData(:); % flatten

end
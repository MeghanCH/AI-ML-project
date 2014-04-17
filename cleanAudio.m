% Ryler Hockenbury
% 4/17/2014
% Clean audio data 

function [cleanData] = cleanAudio(inputData)
% clean the audio frames by windowing

n = size(inputData, 2); 

% find the peak and the associated index
peak = max(inputData); 
peakIndex = find(inputData == peak); 

peakIndexSize = size(peakIndex,2); 

if(peakIndexSize > 1)
    peakIndex = floor(mean(peakIndex));
end

window = 8000; 
audioData = zeros(1,window); 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% finish this processing function

% 
% if(floor(peakIndex-window/2) < 1)
% 
% audioData = inputData(peakIndex-window/2:peakIndex+window/2)
% 
% end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

cleanData = audioData(:); % flatten

end
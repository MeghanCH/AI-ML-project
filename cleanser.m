% Post process video/audio samples for learning

% clc
% clear
% close all

% check we can load data samples
videodirpath = fullfile('rawTest','video');
audiodirpath = fullfile('rawTest','audio'); 
      
% Count other files in folder to determine index
D = dir(videodirpath);
sampleCounter = 0; 


% go thru each char folder
%indexer = [2, 15, 23];
for charIndex=3:length(D); 
    
    videopath = strcat(videodirpath, '\', D(charIndex).name);
    audiopath = strcat(audiodirpath, '\', D(charIndex).name); 
    subD = dir(videopath);
    
    % go thru each char sample 
    for sampleIndex=3:length(subD)
    
        sampleCounter = sampleCounter + 1; 
        videofile = strcat(videopath, '\', subD(sampleIndex).name)
        load(videofile); 

        if(exist('videodata')) 
            %figure(sampleCounter);
            %imaqmontage(videodata);
        else
            display('Invalid folder.'); 
        end
        

        %subD(sampleIndex).name
%         audiofile = strcat(audiopath, '\', subD(sampleIndex).name)
%         load(audiofile); 
%         if(exist('audiodata')) 
%             file  = subD(sampleIndex).name;
%             file(end-3:end) = []; 
%             figure(str2num(file));
%             plot(audiodata);
%             pause(2); 
%         end
        
        % clean the video frames 
        % grayscale
        [~,~,~,n] = size(videodata);
        for i = 1:n
            vdata(:,:,i)=rgb2gray(im2double(videodata(:,:,:,i))); 
            procdata(:,:,i) = vdata(121:end, 81:240, i);
            data(:,:,i) = procdata(66:95, 58:103, i); 
%             figure(i)
%             imshow(data(:,:,i)); 
        end
        
        % dump the data
        test_data_compressed(:,sampleCounter) = data(:);
        temp(sampleCounter) = uint8(D(charIndex).name) - 96;
        temp2 = zeros(26,1);
        temp2(temp(sampleCounter))=1;
        test_label(:,sampleCounter)=temp2;
        
    end
    
end

save('train.mat','data_compressed','label')




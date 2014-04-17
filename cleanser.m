
% Post process video/audio samples and save compressed data

folder = 'rawTrain'; 
videodirpath = fullfile(folder,'video');
audiodirpath = fullfile(folder,'audio'); 

% Count files in folder to determine index
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
        videofile = strcat(videopath, '\', subD(sampleIndex).name);
        audiofile = strcat(audiopath, '\', subD(sampleIndex).name); 
        disp(videofile); 
        load(videofile); 
        load(audiofile); 
        
        if(exist('videodata')) 
            %figure(sampleCounter);
            %imaqmontage(videodata);
        else
            disp('Invalid video data.');
        end
        
        if(exist('audiodata')) 
            %figure(sampleCounter);
            %plot(audiodata);
        else
            disp('Invalid audio data.'); 
        end
        
        % build video/audio data set with clean frames
        video_data_compressed(:,sampleCounter) = cleanVideo(videodata); 
        audio_data_compressed(:,sampleCounter) = cleanAudio(audiodata); 
        
        both_data_compressed = [video_data_compressed; audio_data_compressed];

        % generate data labels from folder names
        charIndex(sampleCounter) = uint8(D(charIndex).name) - 96;
        temp2 = zeros(26,1);
        temp2(charIndex(sampleCounter)) = 1;
        label(:,sampleCounter) = temp2;
       
    end
    
end

save('cleanData/train.mat','video_data_compressed','audio_data_compressed',...
        'both_data_compressed','label')



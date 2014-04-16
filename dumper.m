% Ryler Hockenbury
% 4/10/2104
% Dump all samples

function dumper(folder)
% Dump the .mat files in the folder

audiopath = fullfile(folder,'audio'); 
videopath = fullfile(folder,'video'); 
D = dir(videopath);
num_folders = length(D([D.isdir]));
%strcat(videopath, '\', D(i).name, '\*.mat');

for i=3:num_folders 
    delete(strcat(videopath, '\', D(i).name, '\*.mat')); 
    delete(strcat(audiopath, '\', D(i).name, '\*.mat')); 
end

end
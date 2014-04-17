% Ryler Hockenbury
% 4/9/2014
% Test audio device

clear
clc
close all

%audiodevinfo

% Create audio object
audioDevice = 0; 
recObj = audiorecorder(8000, 8, 1, audioDevice);

% Record your voice for 3 seconds.
disp('Start speaking.')
recordblocking(recObj, 3);
disp('End of Recording.');

% Play back the recording.
play(recObj);

% Store data in double-precision array.
myRecording = getaudiodata(recObj);

% Plot the waveform.
plot(myRecording);



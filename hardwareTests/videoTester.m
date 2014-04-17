% Ryler Hockenbury
% 4/9/2014
% Test video device

clear
clc
close all

vid = imaqhwinfo('winvideo',1);
vid.SupportedFormats

% % Create video object
% vidObj = videoinput('winvideo',1,'RGB24_160x120'); 
% vidObj.FramesPerTrigger = 100;
% 
% % Calculate frame rate
% % start(vidObj); 
% % wait(vidObj, Inf);
% %
% % [frames, time] = getdata(vidObj, vidObj.FramesAvailable);
% % frameRate = mean(1./diff(time));
% % disp(frameRate); 
% % 
% % % capture every nth frame
% % set(vidObj, 'FrameGrabInterval', 10); 
% % 
% % captureTime = 2; 
% % interval = vidObj.FrameGrabInterval;
% % numFrames = floor(captureTime * frameRate / interval); 
% 
% start(vidObj);
% videodata = getdata(vidObj);
% 
% imaqmontage(videodata);
% 
% delete(vidObj);
% 
% 
% % % logging to file
% % set(vidObj, 'LoggingMode', 'disk'); 
% % vidFile = VideoWriter('logfile.avi')
% % %avi = avifile('timelapsevideo', 'fps', frameRate); %deprecated
% % set(vidObj, 'DiskLogger', vidFile); 
% % 
% % % grab some video
% % start(vidObj); 
% % wait(vidObj, Inf);
% % 
% % % close resources 
% % avi = get(vidObj, 'DiskLogger'); 
% % close(avi); 



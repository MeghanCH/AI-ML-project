% Ryler Hockenbury
% 4/9/2014
% User interface for collecting audio/video samples. 

function varargout = collectorGUI(varargin)
% COLLECTORGUI MATLAB code for collectorGUI.fig
%      COLLECTORGUI, by itself, creates a new COLLECTORGUI or raises the existing
%      singleton*.
%
%      H = COLLECTORGUI returns the handle to a new COLLECTORGUI or the handle to
%      the existing singleton*.
%
%      COLLECTORGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in COLLECTORGUI.M with the given input arguments.
%
%      COLLECTORGUI('Property','Value',...) creates a new COLLECTORGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the COLLECTORGUI before collectorGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to collectorGUI_OpeningFcn via varargin.
%
%      *See COLLECTORGUI Options on GUIDE's Tools menu.  Choose "COLLECTORGUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help collectorGUI

% Last Modified by GUIDE v2.5 10-Apr-2014 02:18:58

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @collectorGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @collectorGUI_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before collectorGUI is made visible.
function collectorGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to collectorGUI (see VARARGIN)

% Choose default command line output for collectorGUI
handles.output = hObject;

% Create audio object
audioDevice = 0; 
handles.audio = audiorecorder(8000, 8, 1, audioDevice);

% Create video object
handles.video = videoinput('winvideo', 1, 'RGB24_320x240');
set(handles.video,'TimerPeriod', 0.05, 'TimerFcn', {@info_update});

% Set video object parameters
triggerconfig(handles.video,'manual');
handles.video.FrameGrabInterval = 2;  % Capture every 5th frame
frameRate = 30; 
captureTime = 1; 

% Determine number of frames needed for desired duration
handles.video.FramesPerTrigger = floor(captureTime * frameRate / handles.video.FrameGrabInterval);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes collectorGUI wait for user response (see UIRESUME)
uiwait(handles.collectorGUI);


% --- Outputs from this function are returned to the command line.
function varargout = collectorGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
handles.output = hObject;
varargout{1} = handles.output;


% --- Executes when user attempts to close collectorGUI.
function collectorGUI_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to collectorGUI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
delete(hObject);
delete(imaqfind);


% --- Executes on button press in startStopCamera.
function startStopCamera_Callback(hObject, eventdata, handles)
% hObject    handle to startStopCamera (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% start/stop camera
if strcmp(get(handles.startStopCamera,'String'),'Start Camera')
      % Camera is off. Change button string and start camera.
      set(handles.startStopCamera,'String','Stop Camera')
      start(handles.video)
      set(handles.startAcquisition,'Enable','on');
else
      % Camera is on. Stop camera and change button string.
      set(handles.startStopCamera,'String','Start Camera')
      stop(handles.video)
      set(handles.startAcquisition,'Enable','off');
end

% --- Executes on button press in startAcquisition.
function startAcquisition_Callback(hObject, eventdata, handles)
% hObject    handle to startAcquisition (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if strcmp(get(handles.startAcquisition,'String'),'Start Acquisition')
      % Camera is not acquiring. Change button string and start acquisition.
      set(handles.startAcquisition,'Enable','off'); 
      set(handles.startAcquisition,'String','Acquiring...');
      
      % Record video and audio
      trigger(handles.video);
      record(handles.audio); 
      wait(handles.video);
      stop(handles.audio); 
      
      % Save the acquired media
      set(handles.startAcquisition,'String','Saving...');
      
      % Generate directory paths
      index_selected = get(handles.charOptions,'Value');
      list = get(handles.charOptions,'String');
      char_selected = list{index_selected};
      videopath = fullfile('rawTrain','video', char_selected);
      audiopath = fullfile('rawTrain','audio', char_selected); 
      
      % Count other files in folder to determine index
      D = dir([videopath, '\*.mat']);
      num_vidsamples = length(D(not([D.isdir])));
      
      D = dir([audiopath, '\*.mat']);
      num_audsamples = length(D(not([D.isdir])));
      
      videodata = getdata(handles.video);
      audiodata = getaudiodata(handles.audio);
      
      % Save to folder
      save( strcat(videopath, '/', num2str(num_vidsamples+1),'.mat'), 'videodata');
      disp( strcat('Video saved to file ', videopath));
      
      save( strcat(audiopath, '/', num2str(num_audsamples+1),'.mat'), 'audiodata');
      disp( strcat('Audio saved to file ', audiopath));
      
      % Restart the camera
      start(handles.video); 
      set(handles.startAcquisition,'Enable','on'); 
      set(handles.startAcquisition,'String','Start Acquisition');
end

% --- Executes on selection change in charOptions.
function charOptions_Callback(hObject, eventdata, handles)
% hObject    handle to charOptions (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% empty

% --- Executes during object creation, after setting all properties.
function charOptions_CreateFcn(hObject, eventdata, handles)
% hObject    handle to charOptions (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function startAcquisition_CreateFcn(hObject, eventdata, handles)
% hObject    handle to startAcquisition (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Disable acquisition until camera is on
set(hObject,'Enable','off'); 

% --- Executes during object creation, after setting all properties.
function startStopCamera_CreateFcn(hObject, eventdata, handles)
% hObject    handle to startStopCamera (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% empty

% --- Executes on timed periodic callback. 
function info_update(video, handles)
% video     handle to inputvideo
% handles   structure with handles and user data (see GUIDATA)

% Create image mask for lip centering box
% Hardcoded for now
xCenter = 80; 
yCenter = 80;

mask = double(ones(120, 160));
mask(xCenter-15:xCenter+15, yCenter-30:yCenter+30) = 0; 
mask(xCenter-13:xCenter+13, yCenter-28:yCenter+28) = 1;
%mask = repmat(mask,[1,1,3]);

if(~isempty(gco))
    handles=guidata(gcf);  % Update handles
    %size(mask);
    %size(getsnapshot(handles.video))
    
    % Get picture using GETSNAPSHOT and put it into axes using IMAGE
    rawimage = getsnapshot(handles.video);
    %rawimage = rawimage(:,:,1); 
    rawimage = rgb2gray(im2double(rawimage));
    
    
    rawimage = fliplr((rawimage(121:end, 81:240))); 
    %size(rawimage)
    imshow(rawimage.*mask);    
    
    % Remove tickmarks and labels that are inserted when using IMAGE
    set(handles.cameraAxes,'ytick',[],'xtick',[]);  
else
    delete(imaqfind);   % Clean up - delete any image acquisition objects
end

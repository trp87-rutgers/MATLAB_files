function varargout = Stereo(varargin)
% STEREO MATLAB code for Stereo.fig
%      STEREO, by itself, creates a new STEREO or raises the existing
%      singleton*.
%
%      H = STEREO returns the handle to a new STEREO or the handle to
%      the existing singleton*.
%
%      STEREO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in STEREO.M with the given input arguments.
%
%      STEREO('Property','Value',...) creates a new STEREO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Stereo_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Stereo_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Stereo

% Last Modified by GUIDE v2.5 27-Apr-2018 23:43:30

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Stereo_OpeningFcn, ...
                   'gui_OutputFcn',  @Stereo_OutputFcn, ...
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


% --- Executes just before Stereo is made visible.
function Stereo_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Stereo (see VARARGIN)

% Choose default command line output for Stereo
handles.output = hObject;
[handles.mySound, handles.myFreq] = audioread('exSong.mp3'); % initialize default
handles.xCirc = linspace(-1,1,100);
handles.yCirc = zeros(1,length(handles.xCirc));
for i = 1:length(handles.xCirc)
    handles.yCirc(i) = sqrt(1-(handles.xCirc(i))^2);
end
plot(handles.xCirc,handles.yCirc);
xlim([-1 1]);
ylim([0 1.25]);
hold on
scatter(0,0)
hold off
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Stereo wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Stereo_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double

try % Learned this in python, apperantly matlab has this too, woohoo error checking
    [handles.mySound, handles.myFreq] = audioread(get(hObject,'String'));
catch
    errordlg('File does not exist within MATLAB folder.  Please try again or default song with be selected.')
    [handles.mySound, handles.myFreq] = audioread('exSong.mp3');
end
disp(hObject.String)
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
x = cosd(handles.slider1.Value); % gives y coord on unit semicircle
y = sind(handles.slider1.Value); % gives x coord on unit semicircle
plot(handles.xCirc,handles.yCirc);
xlim([-1 1]);
ylim([0 1.25]);
hold on
scatter(x,y);
hold off
handles.angleBox.String = num2str(hObject.Value);


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in play.
function play_Callback(hObject, eventdata, handles)
% hObject    handle to play (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[rows, cols] = size(handles.mySound);
ratioL = handles.slider1.Value/180; % Coefficient for Left side
ratioR = (180-handles.slider1.Value)/180; % Coefficient for Right Side
for i = 1:rows
    handles.mySound(i,1) = handles.mySound(i,1) * ratioL; % Left side
    handles.mySound(i,2) = handles.mySound(i,2) * ratioR; % Right side
end
handles.FinalSound = audioplayer(handles.mySound, handles.myFreq);
handles.play = true; % For pause/resume
play(handles.FinalSound);
guidata(hObject, handles);


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
stop(handles.FinalSound);
guidata(hObject,handles);


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if handles.play
    pause(handles.FinalSound);
    handles.play = false;
else
    resume(handles.FinalSound);
    handles.play = true;
end
guidata(hObject,handles);

function varargout = dataEditor(varargin)
% DATAEDITOR MATLAB code for dataEditor.fig
%      DATAEDITOR, by itself, creates a new DATAEDITOR or raises the existing
%      singleton*.
%
%      H = DATAEDITOR returns the handle to a new DATAEDITOR or the handle to
%      the existing singleton*.
%
%      DATAEDITOR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DATAEDITOR.M with the given input arguments.
%
%      DATAEDITOR('Property','Value',...) creates a new DATAEDITOR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before dataEditor_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to dataEditor_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help dataEditor

% Last Modified by GUIDE v2.5 07-Feb-2018 15:48:21

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @dataEditor_OpeningFcn, ...
                   'gui_OutputFcn',  @dataEditor_OutputFcn, ...
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



function dataEditor_OpeningFcn(hObject, eventdata, handles, varargin)

handles.output = hObject;


guidata(hObject, handles);


function varargout = dataEditor_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;



function dataName_Callback(hObject, eventdata, handles)

function dataName_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function newNum_Callback(hObject, eventdata, handles)

function newNum_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function addNum_Callback(hObject, eventdata, handles)

if isempty(str2double(handles.newNum.String))
    errordlg('You must enter a number to add to a data set!')
elseif ~strcmp(handles.dataName.String,matlab.lang.makeValidName(handles.dataName.String))
    errordlg('You must enter a valid variable name for your data!')
else
    if exist([handles.dataName.String '.mat'],'file')
        load([handles.dataName.String '.mat'])
        try
            myData = addData(myData,str2double(handles.newNum.String));
        catch
            errordlg('There was something wrong with your addData function. Please debug elsewhere before using this GUI.')
        end
        try
            myData = updateStats(myData);
        catch
            errordlg('There was something wrong with your updateStats function. Please debug elsewhere before using this GUI.')
        end
    else
        try 
            myData = createData(str2double(handles.newNum.String));
        catch
            errordlg('There was something wrong with your createData function. Please debug elsewhere before using this GUI.')
        end 
    end
    try
        handles.mean.String = num2str(myData.mean);
        handles.median.String = num2str(myData.median);
        handles.variance.String = num2str(myData.variance);
        axes(handles.axes1)
        hold off
        plot(1:length(myData.values),myData.values,'Marker','s','Color',[0.7,0.2,0.1],'LineStyle','none')
        hold on
        plot([-1 length(myData.values)+1], [myData.mean myData.mean],'LineWidth',2,'Color',[0 0 1])
        plot([-1 length(myData.values)+1], [myData.median myData.median],'LineWidth',2,'Color',[0.5 0 1])
        legend('Data points','mean','median')
        xlim([.99 length(myData.values)+0.01])
        xlabel('Index')
        ylabel('Element')
        title(['Data set: ' handles.dataName.String])
        save([handles.dataName.String '.mat'],'myData');
        clear myData
    catch
        errordlg('Make sure the properties of your data structure are named correctly!')
    end
end

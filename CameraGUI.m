    function varargout = CameraGUI(varargin)


% CAMERAGUI MATLAB code for CameraGUI.fig
%      CAMERAGUI, by itself, creates a new CAMERAGUI or raises the existing
%      singleton*.
%
%      H = CAMERAGUI returns the handle to a new CAMERAGUI or the handle to
%      the existing singleton*.
%
%      CAMERAGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CAMERAGUI.M with the given input arguments.
%
%      CAMERAGUI('Property','Value',...) creates a new CAMERAGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before CameraGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to CameraGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help CameraGUI

% Last Modified by GUIDE v2.5 02-Feb-2017 16:09:03

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @CameraGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @CameraGUI_OutputFcn, ...
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


% --- Executes just before CameraGUI is made visible.
function CameraGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to MainFigure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to CameraGUI (see VARARGIN)

% Choose default command line output for CameraGUI
handles.output = hObject;

%Initialise Push Button, Check Box and Slider
set(handles.EditShutterSpeedValue1,'Enable','off');
set(handles.EditShutterSpeedValue2,'Enable','off');

set(handles.SliderShutterSpeed1,'Enable','off');
set(handles.SliderShutterSpeed2,'Enable','off');

set(handles.CheckBoxAutoShutterSpeed1,'Enable','off');
set(handles.CheckBoxAutoShutterSpeed2,'Enable','off');

set(handles.EditGainValue1,'Enable','off');
set(handles.EditGainValue2,'Enable','off');

set(handles.SliderGain1,'Enable','off');
set(handles.SliderGain2,'Enable','off');

set(handles.CheckBoxAutoGain1,'Enable','off');
set(handles.CheckBoxAutoGain2,'Enable','off');

set(handles.PopupMenuFrameRate1,'Enable','off');
set(handles.PopupMenuFrameRate2,'Enable','off');

set(handles.StartStopPreviewCameras, 'Enable', 'off');
set(handles.StartStopAcquireCameras, 'Enable', 'off');

set(handles.NumberOfImages, 'Enable', 'off');
set(handles.CaptureImages, 'Enable', 'off');
set(handles.CameraName1,'Enable', 'off');
set(handles.CameraName2,'Enable', 'off');

set(handles.VideoFormat1,'Enable','off');
set(handles.VideoFormat2,'Enable','off');

set(handles.ImagesNameCamera1, 'Enable','off');
set(handles.ImagesNameCamera2, 'Enable','off');

set(handles.ImageExtension, 'Enable', 'off');

set(handles.Browse, 'Enable', 'off');

set(handles.PushButtonBrowse, 'Enable',  'off')

set(handles.StartStopPreviewCameras,'String','Start preview stereo camera')
set(handles.StartStopAcquireCameras,'String','Start acquisition stereo camera')


%Set the available Video Format in the pop menu for the 1st and 2nd camera
%info = imaqhwinfo('pointgrey');
info = imaqhwinfo;
set(handles.PopupMenuInstalledAdaptors, 'String', cellstr(info.InstalledAdaptors));

% set(handles.VideoFormat1, 'String',cellstr(info.DeviceInfo(1).SupportedFormats));
% set(handles.VideoFormat2, 'String',cellstr(info.DeviceInfo(2).SupportedFormats));

%Set the range values for the Shutter Speed of the two cameras
set(handles.SliderShutterSpeed1, 'Min',0.00465);
set(handles.SliderShutterSpeed1, 'Max', 33.293247222900391);%33.293247

set(handles.SliderShutterSpeed2, 'Min',0.00465);
set(handles.SliderShutterSpeed2, 'Max',33.293247222900391);

%Set the range values for the Gain of the two cameras

set(handles.SliderGain1, 'Min', -6.26);
set(handles.SliderGain1, 'Max',24.00);

set(handles.SliderGain2, 'Min', -6.26);
set(handles.SliderGain2, 'Max',24.00);


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes CameraGUI wait for user response (see UIRESUME)
 uiwait(handles.MainFigure);


% --- Outputs from this function are returned to the command line.
function varargout = CameraGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to MainFigure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
handles.output = hObject;
varargout{1} = handles.output;

% --- Executes on selection change in PopupMenuInstalledAdaptors.
function PopupMenuInstalledAdaptors_Callback(hObject, eventdata, handles)
% hObject    handle to PopupMenuInstalledAdaptors (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns PopupMenuInstalledAdaptors contents as cell array
%        contents{get(hObject,'Value')} returns selected item from PopupMenuInstalledAdaptors

set(handles.VideoFormat1,'Enable','on');
set(handles.VideoFormat2,'Enable','on');
contents = cellstr(get(handles.PopupMenuInstalledAdaptors, 'String'));
adaptor = contents{get(handles.PopupMenuInstalledAdaptors, 'Value')};

info = imaqhwinfo(adaptor);
set(handles.CameraName1, 'String', cellstr(info.DeviceInfo(1).DeviceName));
set(handles.CameraName2, 'String', cellstr(info.DeviceInfo(2).DeviceName));
set(handles.VideoFormat1, 'String',cellstr(info.DeviceInfo(1).SupportedFormats));
set(handles.VideoFormat2, 'String',cellstr(info.DeviceInfo(2).SupportedFormats));


% --- Executes during object creation, after setting all properties.
function PopupMenuInstalledAdaptors_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PopupMenuInstalledAdaptors (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on selection change in VideoFormat1.
function VideoFormat1_Callback(hObject, eventdata, handles)
% hObject    handle to VideoFormat1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns VideoFormat1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from VideoFormat1

% Enable Push Button, PopupMenu, Check Box

set(handles.CheckBoxAutoShutterSpeed1,'Enable','on');
set(handles.CheckBoxAutoGain1,'Enable','on');
set(handles.PopupMenuFrameRate1,'Enable','on');
set(handles.StartStopPreviewCameras, 'Enable', 'on');

set(handles.StartStopAcquireCameras, 'Enable', 'off');
set(handles.NumberOfImages, 'Enable', 'off');
set(handles.CaptureImages, 'Enable', 'off');
set(handles.ImagesNameCamera1, 'Enable','off');
set(handles.ImagesNameCamera2, 'Enable','off');
set(handles.ImageExtension, 'Enable', 'off');
set(handles.Browse, 'Enable', 'off');
set(handles.Browse, 'String', pwd);
set(handles.PushButtonBrowse, 'Enable',  'off')



contents_adaptor = cellstr(get(handles.PopupMenuInstalledAdaptors, 'String'));
adaptor = contents_adaptor{get(handles.PopupMenuInstalledAdaptors, 'Value')};


contents = cellstr(get(hObject,'String'));
format = contents{get(hObject,'Value')};


%handles.cam1 = videoinput('pointgrey', 1, format);
handles.cam1 = videoinput(adaptor, 1, format);

handles.src1 = getselectedsource(handles.cam1);

handles.vidRes1 = get(handles.cam1, 'VideoResolution');
 
handles.imWidth1 = handles.vidRes1(1);

handles.imHeight1 = handles.vidRes1(2);

handles.nBands1 = get(handles.cam1, 'NumberOfBands');
 
handles.Image1 = image(zeros(handles.imHeight1, handles.imWidth1, handles.nBands1), 'parent', handles.axes1);

%
Settings = set(handles.src1);
FrameRateAvailables1 = Settings.FrameRate;
set(handles.PopupMenuFrameRate1, 'String',cellstr(FrameRateAvailables1));
set(handles.src1, 'FrameRateMode', 'Auto')


%
set(handles.CheckBoxAutoShutterSpeed1, 'Value', 1)
set(handles.SliderShutterSpeed1, 'Enable', 'off')
set(handles.EditShutterSpeedValue1, 'Enable', 'off')
set (handles.src1, 'ShutterMode', 'Auto')
set(handles.CheckBoxAutoGain1, 'Value', 1)
set(handles.SliderGain1, 'Enable', 'off')
set(handles.EditGainValue1, 'Enable', 'off')
set (handles.src1, 'GainMode', 'Auto')
pause(0.5)
AutoValueShutterSpeed1 = get(handles.src1, 'Shutter');
set(handles.EditShutterSpeedValue1,'String', num2str(AutoValueShutterSpeed1))
AutoValueGain1 = get(handles.src1, 'Gain');
set(handles.EditGainValue1,'String', num2str(AutoValueGain1))


% Update handles structure
guidata(hObject, handles);



 
% --- Executes during object creation, after setting all properties.
function VideoFormat1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to VideoFormat1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in VideoFormat2.
function VideoFormat2_Callback(hObject, eventdata, handles)
% hObject    handle to VideoFormat2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns VideoFormat2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from VideoFormat2

%
set(handles.CheckBoxAutoShutterSpeed2,'Enable','on');
set(handles.CheckBoxAutoGain2,'Enable','on');


set(handles.PopupMenuFrameRate2,'Enable','on');

set(handles.StartStopPreviewCameras, 'Enable', 'on');

set(handles.StartStopAcquireCameras, 'Enable', 'off');
set(handles.NumberOfImages, 'Enable', 'off');
set(handles.CaptureImages, 'Enable', 'off');

set(handles.ImagesNameCamera1, 'Enable','off');
set(handles.ImagesNameCamera2, 'Enable','off');
set(handles.ImageExtension, 'Enable', 'off');
set(handles.Browse, 'Enable', 'off');
set(handles.Browse, 'String', pwd);
set(handles.PushButtonBrowse, 'Enable',  'off')


%

contents_adaptor = cellstr(get(handles.PopupMenuInstalledAdaptors, 'String'));
adaptor = contents_adaptor{get(handles.PopupMenuInstalledAdaptors, 'Value')};

contents = cellstr(get(hObject,'String'));

format = contents{get(hObject,'Value')};

%handles.cam2 = videoinput('pointgrey', 2, format);
handles.cam2 = videoinput(adaptor, 2, format);

handles.src2 = getselectedsource(handles.cam2);

handles.vidRes2 = get(handles.cam2, 'VideoResolution');

handles.imWidth2 = handles.vidRes2(1);

handles.imHeight2 = handles.vidRes2(2); 

handles.nBands2 = get(handles.cam2, 'NumberOfBands');

handles.Image2 = image(zeros(handles.imHeight2, handles.imWidth2, handles.nBands2), 'parent', handles.axes2);

%
Settings = set(handles.src2);
FrameRateAvailables2 = Settings.FrameRate;
set(handles.PopupMenuFrameRate2, 'String',cellstr(FrameRateAvailables2));
set(handles.src2, 'FrameRateMode', 'Auto')

%
%
set(handles.CheckBoxAutoShutterSpeed2, 'Value', 1)
set(handles.SliderShutterSpeed2, 'Enable', 'off')
set(handles.EditShutterSpeedValue2, 'Enable', 'off')
set (handles.src2, 'ShutterMode', 'Auto')
set(handles.CheckBoxAutoGain2, 'Value', 1)
set(handles.SliderGain2, 'Enable', 'off')
set(handles.EditGainValue2, 'Enable', 'off')
set (handles.src2, 'GainMode', 'Auto')
pause(0.5)
AutoValueShutterSpeed2 = get(handles.src2, 'Shutter');
set(handles.EditShutterSpeedValue2,'String', num2str(AutoValueShutterSpeed2))
AutoValueGain2 = get(handles.src2, 'Gain');
set(handles.EditGainValue2,'String', num2str(AutoValueGain2))

% Update handles structure
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function VideoFormat2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to VideoFormat2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function MainFigure_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MainFigure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1


% --- Executes during object creation, after setting all properties.
function axes2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes2

% --- Executes during object creation, after setting all properties.
function StartStopPreviewCameras_CreateFcn(hObject, eventdata, handles)
% hObject    handle to StartStopPreviewCameras (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function CaptureImages_CreateFcn(hObject, eventdata, handles)
% hObject    handle to CaptureImages (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% --- Executes on button press in StartStopPreviewCameras.
function StartStopPreviewCameras_Callback(hObject, eventdata, handles)
% hObject    handle to StartStopPreviewCameras (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Start/Stop Camera

if strcmp(get(handles.StartStopPreviewCameras,'String'),'Start preview stereo camera')
      % Camera is off. Change button string and start camera.
      set(handles.StartStopPreviewCameras,'String','Stop preview stereo camera')
      
      % begin the cameras preview
      preview(handles.cam1, handles.Image1)
      preview(handles.cam2, handles.Image2)
      set(handles.StartStopAcquireCameras, 'Enable', 'off');
     
      
%       start([handles.cam1, handles.cam2])
%       set(handles.CaptureImages,'Enable','on');
else
      % Camera is on. Stop camera and change button string.
      set(handles.StartStopPreviewCameras,'String','Start preview stereo camera')
      stoppreview([handles.cam1, handles.cam2])
      
      set(handles.StartStopAcquireCameras, 'Enable', 'on');
   
%       stoppreview(handles.cam2)
%       stop([handles.cam1, handles.cam2])
%       set(handles.CaptureImages,'Enable','off');
end
% Update handles structure 
guidata(hObject, handles);

function NumberOfImages_Callback(hObject, eventdata, handles)
% hObject    handle to NumberOfImages (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NumberOfImages as text
%        str2double(get(hObject,'String')) returns contents of NumberOfImages as a double


% --- Executes during object creation, after setting all properties.
function NumberOfImages_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NumberOfImages (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in CaptureImages.
function CaptureImages_Callback(hObject, eventdata, handles)
% hObject    handle to CaptureImages (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% %Select the trigger configuration
% triggerconfig([handles.cam1, handles.cam2], 'Manual')
% 
% %Start Acquisition
% start([handles.cam1, handles.cam2])
% %pause to "warm up" the cameras
% pause(3)


handles.n_images = str2double(get(handles.NumberOfImages, 'String'));

% Cameras acquisitions
frames1 = cell(1,handles.n_images); 
frames2 = cell(1,handles.n_images);

tic
for i = 1:handles.n_images;

    frames1{i} = getsnapshot(handles.cam1);
    frames2{i} = getsnapshot(handles.cam2);
end

handles.elapsedTime = toc;

% Compute the time per frame and effective frame rate.
handles.timePerFrame = handles.elapsedTime/handles.n_images;
handles.effectiveFrameRate = 1/handles.timePerFrame;

set(handles.EditEffectiveFrameRate, 'String', num2str(handles.effectiveFrameRate))



% stop([handles.cam1, handles.cam2])

% for i=1:handles.n_images;
%     imwrite(frames1{i},sprintf('image_first_camera%d.tif',i)); 
%     imwrite(frames2{i},sprintf('image_second_camera%d.tif',i));
% end


contents = cellstr(get(handles.ImageExtension,'String')); 
extension = contents{get(handles.ImageExtension,'Value')};


ImagesNameCamera1 = get(handles.ImagesNameCamera1,'String');
ImagesNameCamera2 = get(handles.ImagesNameCamera2,'String');

Directory = get(handles.Browse, 'String');
for i=1:handles.n_images;
    imwrite(frames1{i},[Directory, '\', ImagesNameCamera1,num2str(i), extension]);
    imwrite(frames2{i},[Directory, '\', ImagesNameCamera2,num2str(i), extension]);
end

msgbox('Capturing and Saving Completed (Press OK)','Success');

% --- Executes when user attempts to close MainFigure.
function MainFigure_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to MainFigure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the MainFigure
delete(hObject);
delete(imaqfind);


% --- Executes during object deletion, before destroying properties.
function VideoFormat1_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to VideoFormat1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on slider movement.
function SliderShutterSpeed1_Callback(hObject, eventdata, handles)
% hObject    handle to SliderShutterSpeed1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

%obtains the slider value from the slider component

handles.SliderShutterSpeedValue1 = get(handles.SliderShutterSpeed1,'Value');

%puts the slider value into the edit text component 

set(handles.EditShutterSpeedValue1,'String', num2str(handles.SliderShutterSpeedValue1));
%Change the Shutter of the cameras1
set(handles.src1, 'Shutter', handles.SliderShutterSpeedValue1);

% Update handles structure 
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function SliderShutterSpeed1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SliderShutterSpeed1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function EditShutterSpeedValue1_Callback(hObject, eventdata, handles)
% hObject    handle to EditShutterSpeedValue1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EditShutterSpeedValue1 as text
%        str2double(get(hObject,'String')) returns contents of EditShutterSpeedValue1 as a double
%get the string for the editText component 
handles.SliderEditShutterSpeedValue1 = get(handles.EditShutterSpeedValue1,'String'); 

%convert from string to number if possible, otherwise returns empty 
handles.SliderEditShutterSpeedValue1 = str2double(handles.SliderEditShutterSpeedValue1); 


%if user inputs something is not a number, or if the input is less than 0 
%or greater than 33.2932, then the slider value defaults to 0 
if (isempty(handles.SliderEditShutterSpeedValue1) || handles.SliderEditShutterSpeedValue1 < 0.00465 || handles.SliderEditShutterSpeedValue1 > 33.293247222900391) 
    
    set(handles.SliderShutterSpeed1,'Value',0.00465); 
    set(handles.EditShutterSpeedValue1,'String','0.00465'); 
    set(handles.src1, 'Shutter', 0.00465)
else
    
    set(handles.SliderShutterSpeed1,'Value',handles.SliderEditShutterSpeedValue1);
    set(handles.src1, 'Shutter', handles.SliderEditShutterSpeedValue1)

end

% Update handles structure 
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function EditShutterSpeedValue1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EditShutterSpeedValue1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function SliderShutterSpeed2_Callback(hObject, eventdata, handles)
% hObject    handle to SliderShutterSpeed2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
%obtains the slider value from the slider component

handles.SliderShutterSpeedValue2 = get(handles.SliderShutterSpeed2,'Value');

%puts the slider value into the edit text component 

set(handles.EditShutterSpeedValue2,'String', num2str(handles.SliderShutterSpeedValue2));

%Change the Shutter of the cameras

set(handles.src2, 'Shutter', handles.SliderShutterSpeedValue2);

% Update handles structure 
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function SliderShutterSpeed2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SliderShutterSpeed2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function EditShutterSpeedValue2_Callback(hObject, eventdata, handles)
% hObject    handle to EditShutterSpeedValue2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EditShutterSpeedValue2 as text
%        str2double(get(hObject,'String')) returns contents of EditShutterSpeedValue2 as a double
%get the string for the editText component 
handles.SliderEditShutterSpeedValue2 = get(handles.EditShutterSpeedValue2,'String'); 

%convert from string to number if possible, otherwise returns empty 
handles.SliderEditShutterSpeedValue2 = str2double(handles.SliderEditShutterSpeedValue2); 


%if user inputs something is not a number, or if the input is less than 0 
%or greater than 33.2932, then the slider value defaults to 0 
if (isempty(handles.SliderEditShutterSpeedValue2) || handles.SliderEditShutterSpeedValue2 < 0.00465 || handles.SliderEditShutterSpeedValue2 > 33.293247222900391) 
    set(handles.SliderShutterSpeed2,'Value',0.00465); 
    set(handles.EditShutterSpeedValue2,'String','0.00465'); 
    set(handles.src2, 'Shutter', 0.00465)
else
    set(handles.SliderShutterSpeed2,'Value',handles.SliderEditShutterSpeedValue2);
    set(handles.src2, 'Shutter', handles.SliderEditShutterSpeedValue2)
end
% Update handles structure 
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function EditShutterSpeedValue2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EditShutterSpeedValue2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function SliderGain1_Callback(hObject, eventdata, handles)
% hObject    handle to SliderGain1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

%obtains the slider value from the slider component

handles.SliderGainValue1 = get(handles.SliderGain1,'Value');

%puts the slider value into the edit text component 

set(handles.EditGainValue1,'String', num2str(handles.SliderGainValue1));
%Change the Gain of the Camera 1

set(handles.src1, 'Gain', handles.SliderGainValue1);
% Update handles structure 
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function SliderGain1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SliderGain1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function EditGainValue1_Callback(hObject, eventdata, handles)
% hObject    handle to EditGainValue1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EditGainValue1 as text
%        str2double(get(hObject,'String')) returns contents of EditGainValue1 as a double

%get the string for the editText component 
handles.SliderEditGainValue1 = get(handles.EditGainValue1,'String'); 

%convert from string to number if possible, otherwise returns empty 
handles.SliderEditGainValue1 = str2double(handles.SliderEditGainValue1); 


%if user inputs something is not a number, or if the input is less than -6.26 
%or greater than 24.00, then the slider value defaults to -6.26 
if (isempty(handles.SliderEditGainValue1) || handles.SliderEditGainValue1 < -6.26 || handles.SliderEditGainValue1 > 24.00) 
    set(handles.SliderGain1,'Value',-6.26); 
    set(handles.EditGainValue1,'String','-6.26'); 
    set(handles.src1, 'Gain', -6.26)
else
    set(handles.SliderGain1,'Value',handles.SliderEditGainValue1);
    set(handles.src1, 'Gain', handles.SliderEditGainValue1)
end
% Update handles structure 
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function EditGainValue1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EditGainValue1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function SliderGain2_Callback(hObject, eventdata, handles)
% hObject    handle to SliderGain2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

%obtains the slider value from the slider component

handles.SliderGainValue2 = get(handles.SliderGain2,'Value');

%puts the slider value into the edit text component 

set(handles.EditGainValue2,'String', num2str(handles.SliderGainValue2));
%Change the Gain of the Camera 2

set(handles.src2, 'Gain', handles.SliderGainValue2);
% Update handles structure 
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function SliderGain2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SliderGain2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function EditGainValue2_Callback(hObject, eventdata, handles)
% hObject    handle to EditGainValue2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EditGainValue2 as text
%        str2double(get(hObject,'String')) returns contents of EditGainValue2 as a double

%get the string for the editText component 
handles.SliderEditGainValue2 = get(handles.EditGainValue2,'String'); 

%convert from string to number if possible, otherwise returns empty 
handles.SliderEditGainValue2 = str2double(handles.SliderEditGainValue2); 


%if user inputs something is not a number, or if the input is less than -6.26 
%or greater than 24.00, then the slider value defaults to -6.26 
if (isempty(handles.SliderEditGainValue2) || handles.SliderEditGainValue2 < -6.26 || handles.SliderEditGainValue2 > 24.00) 
    set(handles.SliderGain2,'Value',-6.26); 
    set(handles.EditGainValue2,'String','-6.26'); 
    set(handles.src2, 'Gain', -6.26)
else
    set(handles.SliderGain2,'Value', handles.SliderEditGainValue2);
    set(handles.src2, 'Gain', handles.SliderEditGainValue2)
end
% Update handles structure 
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function EditGainValue2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EditGainValue2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in CheckBoxAutoShutterSpeed1.
function CheckBoxAutoShutterSpeed1_Callback(hObject, eventdata, handles)
% hObject    handle to CheckBoxAutoShutterSpeed1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of CheckBoxAutoShutterSpeed1

mode = get(hObject, 'Value');

if ( mode == 1)
    set(handles.SliderShutterSpeed1, 'Enable', 'off')
    set (handles.src1, 'ShutterMode', 'Auto')
    pause(0.5)
    AutoValueShutterSpeed1 = get(handles.src1, 'Shutter');
    set(handles.EditShutterSpeedValue1,'String', num2str(AutoValueShutterSpeed1))
    set(handles.EditShutterSpeedValue1,'Enable', 'off')
else
    set(handles.SliderShutterSpeed1, 'Enable', 'on')
    set(handles.EditShutterSpeedValue1,'Enable', 'on')
    handles.SliderShutterSpeedValue1 = get(handles.SliderShutterSpeed1,'Value');
    set(handles.src1, 'Shutter',  handles.SliderShutterSpeedValue1)
    %puts the slider value into the edit text component 
    set(handles.EditShutterSpeedValue1,'String', num2str(handles.SliderShutterSpeedValue1));
    
    
end
% Update handles structure 
guidata(hObject, handles);


% --- Executes on button press in CheckBoxAutoGain1.
function CheckBoxAutoGain1_Callback(hObject, eventdata, handles)
% hObject    handle to CheckBoxAutoGain1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of CheckBoxAutoGain1
mode = get(hObject, 'Value');

if ( mode == 1)
    set(handles.SliderGain1, 'Enable', 'off')
    set (handles.src1, 'GainMode', 'Auto')
    pause(0.5)
    AutoValueGain1 = get(handles.src1, 'Gain');
    set(handles.EditGainValue1,'String', num2str(AutoValueGain1))
    set(handles.EditGainValue1,'Enable', 'off')
else
    set(handles.SliderGain1, 'Enable', 'on')
    set(handles.EditGainValue1,'Enable', 'on')
    handles.SliderGainValue1 = get(handles.SliderGain1,'Value');
    set(handles.src1, 'Gain', handles.SliderGainValue1)
    %puts the slider value into the edit text component 
    set(handles.EditGainValue1,'String', num2str(handles.SliderGainValue1));

end
% Update handles structure 
guidata(hObject, handles);


% --- Executes on button press in CheckBoxAutoShutterSpeed2.
function CheckBoxAutoShutterSpeed2_Callback(hObject, eventdata, handles)
% hObject    handle to CheckBoxAutoShutterSpeed2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of CheckBoxAutoShutterSpeed2

mode = get(hObject, 'Value');

if ( mode == 1)
    set(handles.SliderShutterSpeed2, 'Enable', 'off')
    set (handles.src2, 'ShutterMode', 'Auto')
    pause(0.5)
    AutoValueShutterSpeed2 = get(handles.src2, 'Shutter');
    set(handles.EditShutterSpeedValue2,'String', num2str(AutoValueShutterSpeed2))
    set(handles.EditShutterSpeedValue2,'Enable', 'off')
else
    set(handles.SliderShutterSpeed2, 'Enable', 'on')
    set(handles.EditShutterSpeedValue2,'Enable', 'on')
    handles.SliderShutterSpeedValue2 = get(handles.SliderShutterSpeed2,'Value');
    set(handles.src2, 'Shutter',  handles.SliderShutterSpeedValue2)
    %puts the slider value into the edit text component 
    set(handles.EditShutterSpeedValue2,'String', num2str(handles.SliderShutterSpeedValue2));
    
    
end
% Update handles structure 
guidata(hObject, handles);

% --- Executes on button press in CheckBoxAutoGain2.
function CheckBoxAutoGain2_Callback(hObject, eventdata, handles)
% hObject    handle to CheckBoxAutoGain2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of CheckBoxAutoGain2

mode = get(hObject, 'Value');

if ( mode == 1)
    set(handles.SliderGain2, 'Enable', 'off')
    set (handles.src2, 'GainMode', 'Auto')
    pause(0.5)
    AutoValueGain2 = get(handles.src2, 'Gain');
    set(handles.EditGainValue2,'String', num2str(AutoValueGain2))
    set(handles.EditGainValue2,'Enable', 'off')
else
    set(handles.SliderGain2, 'Enable', 'on')
    set(handles.EditGainValue2,'Enable', 'on')
    handles.SliderGainValue2 = get(handles.SliderGain2,'Value');
    set(handles.src2, 'Gain', handles.SliderGainValue2)
    %puts the slider value into the edit text component 
    set(handles.EditGainValue2,'String', num2str(handles.SliderGainValue2));

end
% Update handles structure 
guidata(hObject, handles);


% --- Executes on selection change in PopupMenuFrameRate1.
function PopupMenuFrameRate1_Callback(hObject, eventdata, handles)
% hObject    handle to PopupMenuFrameRate1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns PopupMenuFrameRate1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from PopupMenuFrameRate1

%Set the available Frame Rate for the first camera
handles.ContentsPopupMenuFrameRate1 = cellstr(get(hObject,'String'));
handles.FrameRate1 = handles.ContentsPopupMenuFrameRate1{get(hObject,'Value')};
set(handles.src1, 'FrameRate', handles.FrameRate1);

set(handles.CheckBoxAutoShutterSpeed1, 'Value', 1)
set(handles.SliderShutterSpeed1, 'Enable', 'off')
set(handles.EditShutterSpeedValue1, 'Enable', 'off')
set (handles.src1, 'ShutterMode', 'Auto')
set(handles.CheckBoxAutoGain1, 'Value', 1)
set(handles.SliderGain1, 'Enable', 'off')
set(handles.EditGainValue1, 'Enable', 'off')
set (handles.src1, 'GainMode', 'Auto')
pause(0.5)
AutoValueShutterSpeed1 = get(handles.src1, 'Shutter');
set(handles.EditShutterSpeedValue1,'String', num2str(AutoValueShutterSpeed1))
AutoValueGain1 = get(handles.src1, 'Gain');
set(handles.EditGainValue1,'String', num2str(AutoValueGain1))

% Update handles structure 
guidata(hObject, handles);



% --- Executes during object creation, after setting all properties.
function PopupMenuFrameRate1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PopupMenuFrameRate1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in PopupMenuFrameRate2.
function PopupMenuFrameRate2_Callback(hObject, eventdata, handles)
% hObject    handle to PopupMenuFrameRate2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns PopupMenuFrameRate2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from PopupMenuFrameRate2

%Set the available Frame Rate for the second camera

handles.ContentsPopupMenuFrameRate2 = cellstr(get(hObject,'String'));
handles.FrameRate2 = handles.ContentsPopupMenuFrameRate2{get(hObject,'Value')};
set(handles.src2, 'FrameRate', handles.FrameRate2);

set(handles.CheckBoxAutoShutterSpeed2, 'Value', 1)
set(handles.SliderShutterSpeed2, 'Enable', 'off')
set(handles.EditShutterSpeedValue2, 'Enable', 'off')
set (handles.src2, 'ShutterMode', 'Auto')
set(handles.CheckBoxAutoGain2, 'Value', 1)
set(handles.SliderGain2, 'Enable', 'off')
set(handles.EditGainValue2, 'Enable', 'off')
set (handles.src2, 'GainMode', 'Auto')
pause(0.5)
AutoValueShutterSpeed2 = get(handles.src2, 'Shutter');
set(handles.EditShutterSpeedValue2,'String', num2str(AutoValueShutterSpeed2))
AutoValueGain2 = get(handles.src2, 'Gain');
set(handles.EditGainValue2,'String', num2str(AutoValueGain2))

% Update handles structure 
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function PopupMenuFrameRate2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PopupMenuFrameRate2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in StartStopAcquireCameras.
function StartStopAcquireCameras_Callback(hObject, eventdata, handles)
% hObject    handle to StartStopAcquireCameras (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Start/Stop Camera

if strcmp(get(handles.StartStopAcquireCameras,'String'),'Start acquisition stereo camera')
      % Camera is off. Change button string and start camera.
       triggerconfig([handles.cam1, handles.cam2], 'Manual')
      start([handles.cam1, handles.cam2])
      pause(2)
      set(handles.StartStopPreviewCameras, 'Enable', 'off')
      set(handles.StartStopAcquireCameras,'String','Stop acquisition stereo camera')
      set(handles.CaptureImages,'Enable','on')
      set(handles.NumberOfImages,'Enable','on')
      set(handles.Browse,'Enable','on')
      set(handles.PushButtonBrowse,'Enable','on')
      set(handles.ImagesNameCamera1,'Enable','on')
      set(handles.ImagesNameCamera2,'Enable','on')
      set(handles.ImageExtension,'Enable','on')
     
      % begin the cameras preview
%       preview(handles.cam1, handles.Image1)
%       preview(handles.cam2, handles.Image2)
        
%       set(handles.CaptureImages,'Enable','on');
else
      % Camera is on. Stop camera and change button string.
        set(handles.StartStopAcquireCameras,'String','Start acquisition stereo camera')
%       stoppreview(handles.cam1)
%       stoppreview(handles.cam2)
        stop([handles.cam1, handles.cam2])
        set(handles.StartStopPreviewCameras, 'Enable', 'on')
        set(handles.CaptureImages,'Enable','off')
      set(handles.NumberOfImages,'Enable','off')
      set(handles.Browse,'Enable','off')
      set(handles.PushButtonBrowse,'Enable','off')
      set(handles.ImagesNameCamera1,'Enable','off')
      set(handles.ImagesNameCamera2,'Enable','off')
      set(handles.ImageExtension,'Enable','off')
     
%       set(handles.CaptureImages,'Enable','off');
end
% Update handles structure 
guidata(hObject, handles);



function EditEffectiveFrameRate_Callback(hObject, eventdata, handles)
% hObject    handle to EditEffectiveFrameRate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EditEffectiveFrameRate as text
%        str2double(get(hObject,'String')) returns contents of EditEffectiveFrameRate as a double


% --- Executes during object creation, after setting all properties.
function EditEffectiveFrameRate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EditEffectiveFrameRate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function CameraName1_Callback(hObject, eventdata, handles)
% hObject    handle to CameraName1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of CameraName1 as text
%        str2double(get(hObject,'String')) returns contents of CameraName1 as a double


% --- Executes during object creation, after setting all properties.
function CameraName1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to CameraName1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function CameraName2_Callback(hObject, eventdata, handles)
% hObject    handle to CameraName2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of CameraName2 as text
%        str2double(get(hObject,'String')) returns contents of CameraName2 as a double


% --- Executes during object creation, after setting all properties.
function CameraName2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to CameraName2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in ImageExtension.
function ImageExtension_Callback(hObject, eventdata, handles)
% hObject    handle to ImageExtension (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns ImageExtension contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ImageExtension


% --- Executes during object creation, after setting all properties.
function ImageExtension_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ImageExtension (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ImagesNameCamera1_Callback(hObject, eventdata, handles)
% hObject    handle to ImagesNameCamera1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ImagesNameCamera1 as text
%        str2double(get(hObject,'String')) returns contents of ImagesNameCamera1 as a double


% --- Executes during object creation, after setting all properties.
function ImagesNameCamera1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ImagesNameCamera1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ImagesNameCamera2_Callback(hObject, eventdata, handles)
% hObject    handle to ImagesNameCamera2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ImagesNameCamera2 as text
%        str2double(get(hObject,'String')) returns contents of ImagesNameCamera2 as a double


% --- Executes during object creation, after setting all properties.
function ImagesNameCamera2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ImagesNameCamera2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Browse_Callback(hObject, eventdata, handles)
% hObject    handle to Browse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Browse as text
%        str2double(get(hObject,'String')) returns contents of Browse as a double


% --- Executes during object creation, after setting all properties.
function Browse_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Browse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in PushButtonBrowse.
function PushButtonBrowse_Callback(hObject, eventdata, handles)
% hObject    handle to PushButtonBrowse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
path = uigetdir('', 'Save As');
set(handles.Browse, 'String', path)

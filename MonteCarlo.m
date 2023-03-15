function varargout = MonteCarlo(varargin)
import Utility.*
import MoteCarloImageProcessing.*


% MONTECARLO MATLAB code for MonteCarlo.fig
%      MONTECARLO, by itself, creates a new MONTECARLO or raises the existing
%      singleton*.
%
%      H = MONTECARLO returns the handle to a new MONTECARLO or the handle to
%      the existing singleton*.
%
%      MONTECARLO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MONTECARLO.M with the given input arguments.
%
%      MONTECARLO('Property','Value',...) creates a new MONTECARLO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before MonteCarlo_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to MonteCarlo_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help MonteCarlo

% Last Modified by GUIDE v2.5 14-Mar-2023 19:16:32

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @MonteCarlo_OpeningFcn, ...
                   'gui_OutputFcn',  @MonteCarlo_OutputFcn, ...
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


% --- Executes just before MonteCarlo is made visible.
function MonteCarlo_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to MonteCarlo (see VARARGIN)

% Choose default command line output for MonteCarlo
handles.output = hObject;

% create obj object
carlo = MoteCarloImageProcessing();
handles.obj = carlo;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes MonteCarlo wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = MonteCarlo_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in calculate.
function calculate_Callback(hObject, eventdata, handles)
randomNumMin = str2double(get(handles.minValue, 'string'));
randomNumMax = str2double(get(handles.maxValue, 'string'));
maxIteration = str2double(get(handles.iterasi, 'string'));
[pos_x,pos_y, titik, hasil] = handles.obj.calculate(randomNumMin, randomNumMax, maxIteration);
% 
plot(handles.plotData, pos_x, pos_y, '.', 'markersize', 12)
refreshdata;
drawnow;

set(handles.titik, 'string', titik)
set(handles.hasil, 'string', hasil)


% hObject    handle to calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function minValue_Callback(hObject, eventdata, handles)
% hObject    handle to minValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of minValue as text
%        str2double(get(hObject,'String')) returns contents of minValue as a double


% --- Executes during object creation, after setting all properties.
function minValue_CreateFcn(hObject, eventdata, handles)
% hObject    handle to minValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(handles.titik, 'string', '0')
    set(hObject,'BackgroundColor','white');
end



function maxValue_Callback(hObject, eventdata, handles)
% hObject    handle to maxValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of maxValue as text
%        str2double(get(hObject,'String')) returns contents of maxValue as a double


% --- Executes during object creation, after setting all properties.
function maxValue_CreateFcn(hObject, eventdata, handles)

% hObject    handle to maxValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(handles.hasil, 'string', '0')
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in uploadButton.
function uploadButton_Callback(hObject, eventdata, handles)
% Use Memilih file yang ingin dipilih
filePath = mfilename('fullpath');
fullname = Utility.getInputFile(filePath);

%Image Processing
image = imread(fullname);
image = handles.obj.toBinarize(image);
[x_coor, y_coor] = handles.obj.detectBoundaries(image);


% clear plot sebelumnya
axes(handles.plotData); 
cla reset;
 

% Plot kepadda gui Plotting
hold on;
plot(handles.plotData, x_coor, y_coor);
% Utility.checkPlotIfExist(handles.plotData, x_coor, y_coor, getDir) 

% Rubahh direktori
set(handles.directory, 'string', fullname);



% hObject    handle to uploadButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function iterasi_Callback(hObject, eventdata, handles)
% hObject    handle to iterasi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of iterasi as text
%        str2double(get(hObject,'String')) returns contents of iterasi as a double


% --- Executes during object creation, after setting all properties.
function iterasi_CreateFcn(hObject, eventdata, handles)
% hObject    handle to iterasi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in clear.
function clear_Callback(hObject, eventdata, handles)
set(handles.directory, 'string', '')
set(handles.titik, 'string', '0')
set(handles.hasil, 'string', '0')
axes(handles.plotData); 
cla reset;

% hObject    handle to clear (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in sizePic.
function sizePic_Callback(hObject, eventdata, handles)
handles.obj.checkBoxSet(handles.sizePic, handles.minValue, handles.maxValue)
% hObject    handle to sizePic (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of sizePic

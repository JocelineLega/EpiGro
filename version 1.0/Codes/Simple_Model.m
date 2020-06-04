function varargout = Simple_Model(varargin)
% SIMPLE_MODEL MATLAB code for Simple_Model.fig
%      SIMPLE_MODEL, by itself, creates a new SIMPLE_MODEL or raises the existing
%      singleton*.
%
%      H = SIMPLE_MODEL returns the handle to a new SIMPLE_MODEL or the handle to
%      the existing singleton*.
%
%      SIMPLE_MODEL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SIMPLE_MODEL.M with the given input arguments.
%
%      SIMPLE_MODEL('Property','Value',...) creates a new SIMPLE_MODEL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Simple_Model_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Simple_Model_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Simple_Model

% Last Modified by J. Lega 03-Mar-2020
% Please cite J. Lega and H.E. Brown, "Data-driven outbreak forecasting
% with a simple nonlinear growth model", Epidemics 17, 19–26 (2016)
% http://dx.doi.org/10.1016/j.epidem.2016.10.002
% when using these codes

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @Simple_Model_OpeningFcn, ...
    'gui_OutputFcn',  @Simple_Model_OutputFcn, ...
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

% --- Executes just before Simple_Model is made visible.
function Simple_Model_OpeningFcn(hObject, ~, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Simple_Model (see VARARGIN)

% Choose default command line output for Simple_Model
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Simple_Model wait for user response (see UIRESUME)
% uiwait(handles.figure1);

set(handles.popupmenu2,'String',{'Select Data File','Pertussis, WA (2012)',...
    'Measles, CA (2015)','Salmonella (2008)','Gastro, Majorca (2008)',...
    'H1N1, Canada (2009)','Import New Data File'})

set(gcf,'Name','EpiGro')

% --- Outputs from this function are returned to the command line.
function varargout = Simple_Model_OutputFcn(~, ~, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(~, ~, handles) %#ok<*DEFNU>
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global A
global Wid Mxg L2 R2 Mxg2 Lw
global filename
global time_unit
global duration peak Ncases
global s q
global two_p_on

% Check model type
two_p_on=get(handles.checkbox1,'Value');

% Prepares output file
xlswrite(filename,{'Parameters';' ';'Wid';'Mxg';'L2';'R2';'Mxg2';'Lw'},...
    'Output','A1');
DT={' ','Cases'};
DT(1)=time_unit;
xlswrite(filename,DT,'Output','D1');
xlswrite(filename,{'Data','Model'},'Output','E2');

% Write output file
OUT=zeros(duration,1);
x=1:1:duration;
j=find(x==s(1),1,'first');
if j~=1
    OUT(1:j-1)=A(1:j-1,3);
end
jj=find(s==duration,1,'first');
OUT(j:duration)=round(q(1:jj));
xlswrite(filename,x','Output','D3');
xlswrite(filename,A(:,3),'Output','E3');
xlswrite(filename,OUT,'Output','F3');

PRM=[Wid; Mxg; L2; R2; Mxg2; Lw];
xlswrite(filename,PRM,'Output','B3');

xlswrite(filename,{'Duration'; 'Peak'; 'Total Cases'},'Output','A10');
xlswrite(filename,[duration;peak;Ncases],'Output','B10');

% --- Executes on slider movement.
function Slider_Wid_1_Callback(hObject, ~, handles)
% hObject    handle to Slider_Wid_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global Wid

Wid=get(hObject,'Value');
set(handles.Text_Wid_1,'String',num2str(Wid));
EpiGro_run_and_plot(handles);

% --- Executes during object creation, after setting all properties.
function Slider_Wid_1_CreateFcn(hObject, ~, ~)
% hObject    handle to Slider_Wid_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on slider movement.
function Slider_Mxg_1_Callback(hObject, ~, handles)
% hObject    handle to Slider_Mxg_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global Mxg

Mxg=get(hObject,'Value');
set(handles.Text_Mxg_1,'String',num2str(Mxg));
EpiGro_run_and_plot(handles);

% --- Executes during object creation, after setting all properties.
function Slider_Mxg_1_CreateFcn(hObject, ~, ~)
% hObject    handle to Slider_Mxg_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on slider movement.
function Slider_L2_Callback(hObject, ~, handles)
% hObject    handle to Slider_L2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global L2

L2=get(hObject,'Value');
set(handles.Text_L2,'String',num2str(L2));
EpiGro_run_and_plot(handles);

% --- Executes during object creation, after setting all properties.
function Slider_L2_CreateFcn(hObject, ~, ~)
% hObject    handle to Slider_L2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on slider movement.
function Slider_R2_Callback(hObject, ~, handles)
% hObject    handle to Slider_R2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global R2

R2=get(hObject,'Value');
set(handles.Text_R2,'String',num2str(R2));
EpiGro_run_and_plot(handles);

% --- Executes during object creation, after setting all properties.
function Slider_R2_CreateFcn(hObject, ~, ~)
% hObject    handle to Slider_R2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on slider movement.
function Slider_Mxg_2_Callback(hObject, ~, handles)
% hObject    handle to Slider_Mxg_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global Mxg2

Mxg2=get(hObject,'Value');
set(handles.Text_Mxg_2,'String',num2str(Mxg2));
EpiGro_run_and_plot(handles);

% --- Executes during object creation, after setting all properties.
function Slider_Mxg_2_CreateFcn(hObject, ~, ~)
% hObject    handle to Slider_Mxg_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on slider movement.
function Slider_Low_Callback(hObject, ~, handles)
% hObject    handle to Slider_Low (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global Lw

Lw=get(hObject,'Value');
set(handles.Text_Low,'String',num2str(Lw));
EpiGro_run_and_plot(handles);

% --- Executes during object creation, after setting all properties.
function Slider_Low_CreateFcn(hObject, ~, ~)
% hObject    handle to Slider_Low (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on button press in checkbox1.
function checkbox1_Callback(~, ~, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1
global Wid Mxg L2 R2 Mxg2 Lw
global two_p_on

two_p_on=get(handles.checkbox1,'Value');

if two_p_on == 0
    set(handles.Text_L2,'String',' ')
    set(handles.Text_R2,'String',' ')
    set(handles.Text_Mxg_2,'String',' ');
    set(handles.Text_Low,'String',' ');
else
    if L2~=0
        set(handles.Text_L2,'String',num2str(L2));
        set(handles.Text_R2,'String',num2str(R2));
        set(handles.Text_Mxg_2,'String',num2str(Mxg2));
        set(handles.Text_Low,'String',num2str(Lw));
    else
        L2=Wid;
        set(handles.Slider_L2,'Value',L2)
        set(handles.Text_L2,'String',num2str(L2))
        set(handles.Slider_L2,'Min',0);
        set(handles.Slider_L2,'Max',L2*2);
        R2=3*Wid;
        set(handles.Slider_R2,'Value',R2)
        set(handles.Text_R2,'String',num2str(R2))
        set(handles.Slider_R2,'Min',0);
        set(handles.Slider_R2,'Max',R2*4);
        Mxg2=Mxg;
        set(handles.Slider_Mxg_2,'Value',Mxg2);
        set(handles.Text_Mxg_2,'String',num2str(Mxg2));
        set(handles.Slider_Mxg_2,'Min',Mxg2*.1);
        set(handles.Slider_Mxg_2,'Max',Mxg2*20);
        Lw=Mxg/40;
        set(handles.Slider_Low,'Value',Lw);
        set(handles.Text_Low,'String',num2str(Lw));
        set(handles.Slider_Low,'Min',0);
        set(handles.Slider_Low,'Max',Mxg2);
    end
end
EpiGro_run_and_plot(handles);

function EpiGro_run_and_plot(handles)
global Growth Cases W C
global time_unit
global duration peak Ncases
global s q
global plotname
global A
global Wid

% Run model
if Wid~=0
    [s,q,x,ft,duration,peak,Ncases]=EpiGro_Run_Model;
end

% Plot growth rate & its approximation
axes(handles.axes1);
if Wid~=0
    plot(Cases,Growth)
    hold on
    plot(x,ft,'r');
    xlim([0 ceil(max(x))])
    ylim([0 1.1*ceil(max(Growth))])
    hold off
else
    cla;
end
xlabel('Number of Cases')
ylabel('Growth Rate')

% Epidemic information
if Wid ~=0
    set(handles.Text_Duration,'String',[num2str(duration) ' ' char(time_unit) 's']);
    set(handles.Text_Peak,'String',[char(time_unit) ' # ' num2str(peak)]);
    set(handles.Text_Cases,'String',num2str(Ncases));
end

% Plot number of cases
axes(handles.axes2);
if Wid~=0
    plot(s,q,'r',W,C,'bo',s,q,'r*')
    xlim([0 (duration+ceil(size(A,1)*1.5))/2])
else
    cla
end
xlabel(strcat(time_unit,'s'))
ylabel('Number of Cases')
title(plotname,'Interpreter','none')

function Text_Wid_1_Callback(hObject, ~, handles)
% hObject    handle to Text_Wid_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Text_Wid_1 as text
%        str2double(get(hObject,'String')) returns contents of Text_Wid_1 as a double
global Wid

Wid=str2double(get(hObject,'String'));
set(handles.Slider_Wid_1,'Value',Wid);
set(handles.Slider_Wid_1,'Min',0);
set(handles.Slider_Wid_1,'Max',2*Wid);
EpiGro_run_and_plot(handles);

% --- Executes during object creation, after setting all properties.
function Text_Wid_1_CreateFcn(hObject, ~, ~)
% hObject    handle to Text_Wid_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Text_Mxg_1_Callback(hObject, ~, handles)
% hObject    handle to Text_Mxg_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Text_Mxg_1 as text
%        str2double(get(hObject,'String')) returns contents of Text_Mxg_1 as a double
global Mxg

Mxg=str2double(get(hObject,'String'));
set(handles.Slider_Mxg_1,'Value',Mxg);
set(handles.Slider_Mxg_1,'Min',0);
set(handles.Slider_Mxg_1,'Max',2*Mxg);
EpiGro_run_and_plot(handles);

% --- Executes during object creation, after setting all properties.
function Text_Mxg_1_CreateFcn(hObject, ~, ~)
% hObject    handle to Text_Mxg_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Text_L2_Callback(hObject, ~, handles)
% hObject    handle to Text_L2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Text_L2 as text
%        str2double(get(hObject,'String')) returns contents of Text_L2 as a double
global L2

L2=str2double(get(hObject,'String'));
set(handles.Slider_L2,'Value',L2);
set(handles.Slider_L2,'Min',0);
set(handles.Slider_L2,'Max',2*L2);
EpiGro_run_and_plot(handles);

% --- Executes during object creation, after setting all properties.
function Text_L2_CreateFcn(hObject, ~, ~)
% hObject    handle to Text_L2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Text_R2_Callback(hObject, ~, handles)
% hObject    handle to Text_R2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Text_R2 as text
%        str2double(get(hObject,'String')) returns contents of Text_R2 as a double
global R2

R2=str2double(get(hObject,'String'));
set(handles.Slider_R2,'Value',R2);
set(handles.Slider_R2,'Min',0);
set(handles.Slider_R2,'Max',2*R2);
EpiGro_run_and_plot(handles);

% --- Executes during object creation, after setting all properties.
function Text_R2_CreateFcn(hObject, ~, ~)
% hObject    handle to Text_R2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Text_Mxg_2_Callback(hObject, ~, handles)
% hObject    handle to Text_Mxg_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Text_Mxg_2 as text
%        str2double(get(hObject,'String')) returns contents of Text_Mxg_2 as a double
global Mxg2

Mxg2=str2double(get(hObject,'String'));
set(handles.Slider_Mxg_2,'Value',Mxg2);
set(handles.Slider_Mxg_2,'Min',0);
set(handles.Slider_Mxg_2,'Max',2*Mxg2);
EpiGro_run_and_plot(handles);

% --- Executes during object creation, after setting all properties.
function Text_Mxg_2_CreateFcn(hObject, ~, ~)
% hObject    handle to Text_Mxg_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Text_Low_Callback(hObject, ~, handles)
% hObject    handle to Text_Low (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Text_Low as text
%        str2double(get(hObject,'String')) returns contents of Text_Low as a double
global Lw

Lw=str2double(get(hObject,'String'));
set(handles.Slider_Low,'Value',Lw);
set(handles.Slider_Low,'Min',0);
set(handles.Slider_Low,'Max',2*Lw);
EpiGro_run_and_plot(handles);

% --- Executes during object creation, after setting all properties.
function Text_Low_CreateFcn(hObject, ~, ~)
% hObject    handle to Text_Low (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(~, ~, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2
global A
global Growth Cases Weeks W C
global Wid Mxg L2 R2 Mxg2 Lw
global last_week
global filename plotname
global time_unit
global Wid0 Mxg0
global two_p_on

loc=get(handles.popupmenu2,'Value');

% Get data filename
if loc==2
    filename='Pertussis_WA_2012.xlsx'; plotname=filename;
elseif loc==3
    filename='Measles_CA_2015.xlsx'; plotname=filename;
elseif loc==4
    filename='Salmonella_2008.xlsx'; plotname=filename;
elseif loc==5
    filename='Gastro_Majorca_2008.xlsx'; plotname=filename;
elseif loc==6
    filename='H1N1_Canada_2009.xlsx'; plotname=filename;
else
    [fname,pathname]=uigetfile({'*.xlsx';'*.xls'});
    filename=[pathname fname];
    plotname=fname;
end

if filename(1)~=0
    % Read data file
    [A,txt,~]=xlsread(filename); 
    time_unit=txt(2,1);
    
    [Wid,Mxg,L2,R2,Mxg2,Lw,Growth,Cases,W,C,Weeks,...
    last_week]=EpiGro_process_input_data(A);

    % Set two-parabola-option to 0
    two_p_on=0;
    set(handles.checkbox1,'Value',two_p_on);
    
    % Fill-in parameters
    Wid0=Wid;
    set(handles.Text_Wid_1,'String',num2str(Wid));
    set(handles.Slider_Wid_1,'Min',0);
    set(handles.Slider_Wid_1,'Value',Wid);
    set(handles.Slider_Wid_1,'Max',Wid*20);
    Mxg0=Mxg;
    set(handles.Text_Mxg_1,'String',num2str(Mxg));
    set(handles.Slider_Mxg_1,'Value',Mxg);
    set(handles.Slider_Mxg_1,'Min',0);
    set(handles.Slider_Mxg_1,'Max',Mxg*20);
    
    set(handles.Text_L2,'String',' ')
    set(handles.Text_R2,'String',' ')
    set(handles.Text_Mxg_2,'String',' ');
    set(handles.Text_Low,'String',' ');
    
    % Define window name
    set(gcf,'Name','EpiGro')
    
    % Plot data
    EpiGro_run_and_plot(handles);
end

% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, ~, ~)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(~, ~, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Growth Cases W C
global time_unit
global duration
global s q
global plotname
global A
global Wid Mxg L2 R2 Mxg2 Lw

% Plot growth rate & its approximation
figure(100);
set(gcf,'Position',[100 100 900 500])
subplot(1,2,1)
set(gca,'Fontsize',14)
plot(Cases,Growth,'LineWidth',2)
hold on
on=get(handles.checkbox1,'Value');
[x,ft]=EpiGro_plot_growth(Wid,Mxg,L2,R2,Mxg2,Lw,Cases,on);
plot(x,ft,'--','Color',[0.85 0.325 0.098],'LineWidth',2);
xlim([0 ceil(max(x))])
ylim([0 1.1*ceil(max(Growth))])
hold off

xlabel('Number of Cases')
ylabel('Growth Rate')
title(plotname,'Interpreter','none','FontSize',10)
% title(['Source File: ' plotname],'Interpreter','none')

% Plot number of cases
subplot(1,2,2);
set(gca,'Fontsize',14)
% plot(s,q,'--r',W,C,'bo',s,q,'r*','LineWidth',2)
plot(W,C,'o','Color',[0 0.447 0.741],'LineWidth',2)
hold on
plot(s,q,'--','Color',[0.85 0.325 0.098],'LineWidth',2)
% xlim([0 (duration+max(s))/2])
xlim([0 (duration+ceil(size(A,1)*1.5))/2])
xlabel(strcat(time_unit,'s'))
ylabel('Number of Cases')
% text(1,1.05*max(Cases),['Source File: ' plotname],...
%     'FontSize',10,'Interpreter','none')
title(plotname,'Interpreter','none','FontSize',10)

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(~, ~, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Wid Mxg

EpiGro_optipar;
set(handles.Text_Wid_1,'String',num2str(Wid));
set(handles.Slider_Wid_1,'Min',0);
set(handles.Slider_Wid_1,'Value',Wid);
set(handles.Slider_Wid_1,'Max',Wid*2);
set(handles.Text_Mxg_1,'String',num2str(Mxg));
set(handles.Slider_Mxg_1,'Value',Mxg);
set(handles.Slider_Mxg_1,'Min',0);
set(handles.Slider_Mxg_1,'Max',Mxg*2);
EpiGro_run_and_plot(handles);

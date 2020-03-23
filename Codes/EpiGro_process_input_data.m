function [Wid,Mxg,L2,R2,Mxg2,Lw,Growth,Cases,W,C,Weeks,...
    last_week]=EpiGro_process_input_data(A)
% Last Modified by J. Lega 03-Mar-2020
% Please cite J. Lega and H.E. Brown, "Data-driven outbreak forecasting
% with a simple nonlinear growth model", Epidemics 17, 19–26 (2016)
% http://dx.doi.org/10.1016/j.epidem.2016.10.002
% when using these codes

% Remove repeated values in rows of A
% Define a more refined grid on which to interpolate the data
h=1/28;
Weeks=1:h:size(A,1);          % Time in TU
Cases=zeros(size(Weeks));   % Number of cases
Growth=zeros(size(Weeks));  % Growth rate

% Process input data
C = A(:,3);                   % Number of reported cases
W = 1:1:length(C);            % Weeks with new data points
if sum(C) > 0
    % Remove repeated values except zeros and end values
    D=[1; C(2:end)-C(1:end-1)];
    W(D==0 & C~=0 & C~=C(end))=[];
    C(D==0 & C~=0 & C~=C(end))=[];
    % Smooth and then interporlate the data
    Cases=interp1(W,smooth(W,C,6),Weeks,'pchip');
    % Growth rate
    Growth=[(Cases(2)-Cases(1))/h ...
        (Cases(3:end)-Cases(1:end-2))/2/h ...
        (Cases(end)-Cases(end-1))/h];
    % Remove negative values in Cases vector
    Growth(Cases<0)=[];
    Weeks(Cases<0)=[];
    Cases(Cases<0)=[];
end

% Fill-in parameters
Wid=ceil(max(Cases));
Mxg=ceil(max(Growth));
L2=0; R2=L2; Mxg2=0; Lw=0;

% Define duration of simulation
last_week=ceil(size(A,1)*1.5);
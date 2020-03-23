function [s,q,x,ft,duration,peak,Ncases]=EpiGro_Run_Model
% Last Modified by J. Lega 03-Mar-2020
% Please cite J. Lega and H.E. Brown, "Data-driven outbreak forecasting
% with a simple nonlinear growth model", Epidemics 17, 19–26 (2016)
% http://dx.doi.org/10.1016/j.epidem.2016.10.002
% when using these codes

global Wid Thr Mxg L2 R2 Mxg2 Lw
global last_week
% global C W
global Cases Weeks
global two_p_on

Z2=Cases;
% Z2=C;

% Quadratic fit
r1=Mxg;
r2=Wid/2;

if two_p_on==1
    % Double quadratic fit
    r3=Mxg2;
    r4=L2;
    r5=R2;
    r=Lw;
end

% Integrate model ODE
Thr=round(max(Wid,L2)./10);
i0=find(Z2>Thr,1);   % index such that # of cases is larger than Thr(ci)
if isempty(i0)
    i0=find(Z2>max(Z2)/2,1);
end
t0=ceil(Weeks(i0));      % Initial time
i0=find(Weeks==t0);
if two_p_on == 0
    s=(t0:1:last_week)';
    q=2*r2*Z2(i0)/(2*r2-Z2(i0))./(exp(-2*(s-t0)*r1/r2)+Z2(i0)/(2*r2-Z2(i0)));
else
    % [s,q]=ode45(@(t,y)grw(t,y,r1,r2,r3,r4,r5,r,two_p_on),t0:1:last_week,Z2(Weeks==t0));
    [s,q]=ode45(@(t,y)grw(t,y,r1,r2,r3,r4,r5,r,two_p_on),t0:1:last_week,Z2(i0));
end

% Check epidemic has finished
if two_p_on == 1
    Nc=R2;
else
    Nc=Wid;
end

while abs(q(end)-Nc)/Nc > 0.001
    last_week=2*last_week;
    if two_p_on==0
        s=(t0:1:last_week)';
        q=2*r2*Z2(i0)/(2*r2-Z2(i0))./(exp(-2*(s-t0)*r1/r2)+Z2(i0)/(2*r2-Z2(i0)));
    else
        %     [s,q]=ode45(@(t,y)grw(t,y,r1,r2,r3,r4,r5,r,two_p_on),t0:1:last_week,Z2(Weeks==t0));
        [s,q]=ode45(@(t,y)grw(t,y,r1,r2,r3,r4,r5,r,two_p_on),t0:1:last_week,Z2(i0));
    end
end

% Calculate epidemic parameters
[x,ft]=EpiGro_plot_growth(Wid,Mxg,L2,R2,Mxg2,Lw,Cases,two_p_on);
duration=s(find(q>0.9999*(q(end)-1),1,'first'));
peak=s(find(q>x(find(ft==max(ft),1,'first')),1,'first'));
Ncases=round(q(end));


function dy=grw(~,y,r1,r2,r3,r4,r5,r,on)

ft1=r1*(1-(y-r2).^2./r2.^2);
if on ~=0
    ft2=r3*(1-4/(r5-r4)^2*(y-(r4+r5)/2).^2);
    dy=(y<(r4+r5)/2).*(y>r4/2).*...
        (max(ft1,ft2).*(max(ft1,ft2)>=r)+r*(max(ft1,ft2)<r))...
        + (y<(r4+r5)/2).*(y<=r4/2).*max(ft1,ft2) ...
        + (y>=(r4+r5)/2).*max(ft1,ft2);
else
    dy=ft1;
end
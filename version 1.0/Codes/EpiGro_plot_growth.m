function [x,ft]=EpiGro_plot_growth(Wid,Mxg,L2,R2,Mxg2,Lw,Cases,checkbox1)
% Last Modified by J. Lega 03-Mar-2020
% Please cite J. Lega and H.E. Brown, "Data-driven outbreak forecasting
% with a simple nonlinear growth model", Epidemics 17, 19–26 (2016)
% http://dx.doi.org/10.1016/j.epidem.2016.10.002
% when using these codes

% Quadratic fit
r1=Mxg;
r2=Wid/2;
on=checkbox1;
if on==1
    x=0:0.1:max(max(R2,Wid),max(Cases));
else
    x=0:0.1:max(Wid,max(Cases));
end
ft1=r1*(1-(x-r2).^2./r2.^2);

% Double quadratic fit
r3=Mxg2;
r4=L2;
r5=R2;
r=Lw;
if checkbox1 == 1
    ft2=r3*(1-4/(r5-r4)^2*(x-(r4+r5)/2).^2);
else
    ft2=zeros(size(x));
end

% Growth model
if checkbox1 == 0
    ft = ft1;
else
    ft=(x<(r4+r5)/2).*(x>r4/2).*...
        (max(ft1,ft2).*(max(ft1,ft2)>=r)+r*(max(ft1,ft2)<r))...
        + (x<(r4+r5)/2).*(x<=r4/2).*max(ft1,ft2) ...
        + (x>=(r4+r5)/2).*max(ft1,ft2);
end
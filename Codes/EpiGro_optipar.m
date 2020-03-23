function EpiGro_optipar
% Last Modified by J. Lega 03-Mar-2020
% Please cite J. Lega and H.E. Brown, "Data-driven outbreak forecasting
% with a simple nonlinear growth model", Epidemics 17, 19–26 (2016)
% http://dx.doi.org/10.1016/j.epidem.2016.10.002
% when using these codes

global Wid Mxg
global Wid0 Mxg0
global Cases Growth
global r_min r_max

Wid0=Wid;
Mxg0=Mxg;

if mean(Growth(end-10:end)) < max(Growth)/10000
    % If epidemic is over, prioritize total number of cases and
    % find maximum by minimizing error on growth rate curve
    Wid=Cases(end);
    rr=.5:0.1:1.5;
    Mx=max(Growth)*rr;
    Er=10000*ones(size(rr));
    for jj=1:length(rr)
        Mxg=Mx(jj);
        Er(jj)=l2_error;
    end
    [~,jk]=min(Er);
    % jk is a vector of indices giving the minimum of the l2 error
    % for scanned values of Mxg
    % Now refine around the given value of Mxg to find the best
    % match
    Mxg=Mx(jk(end));
    e1=Er(jk(end));
    r_step=.05*Mxg;
    for iter=1:50
        Mxg=Mxg+r_step;
        e2=l2_error;
        if e2>e1
            r_step=-r_step/3;
        end
        e1=e2;
    end
else
    % If not, optimize on growth rate and epidemiological curves
    % Define Error on Integral of Growth
    r_min=0.6; r_max=2.4;
    rg=r_min:0.005:r_max;
    m=Mxg0*rg;
    n0=Wid0*rg;
    [N0,M]=meshgrid(n0,m);
    E=zeros(size(N0));
    for j=1:size(N0,1)
        for i=1:size(N0,2)
            E(j,i)=Errint(N0(j,i),M(j,i));
        end
    end
    figure(300)
    contour(N0,M,sign(E),[0 0]),shading interp
    xlabel('Width'); ylabel('Max')
    
    % Move along transition curve to find minimum of l2 error
    theta=0:0.05:pi/2.5; rr=-tan(theta);
    Wd=Wid*ones(size(rr)); Mx=Mxg*ones(size(rr));
    Er=10000*ones(size(rr));
    for jj=1:length(rr)
        [Wid1,Mxg1]=trans_point(rr(jj));
        if ~isempty(Wid1)
            Wid=Wid1;
            Wd(jj)=Wid;
        end
        if ~isempty(Mxg1)
            Mxg=Mxg1;
            Mx(jj)=Mxg;
        end
        Er(jj)=l2_error;
    end
    [~,jk]=min(Er);
    % jk is a vector of indices giving the minimum of the l2 error
    % for scanned values of r
    % Now refine around the given value of r to find the best match
    Mxg=Mx(jk(end));
    Wid=Wd(jk(end));
    e1=Er(jk(end));
    r=rr(jk(end)); r_step=0.05;
    for iter=1:40
        r=r+r_step;
        [Wid1,Mxg1]=trans_point(r);
        if ~isempty(Wid1)
            Wid=Wid1;
        end
        if ~isempty(Mxg1)
            Mxg=Mxg1;
        end
        e2=l2_error;
        if e2>e1
            r_step=-r_step/3;
        end
        e1=e2;
        figure(300)
        hold on
        plot(Wid,Mxg,'ko')
        hold off
        drawnow
    end
end
E=l2_error;
disp(' ')
disp(['Error on solution= ' num2str(E)]);
disp(['Error on integral of growth rate= ' ...
    num2str(Errint(Wid,Mxg)/Wid)])

function E=l2_error
global W C

[s,q,~,~,~,~,~]=EpiGro_Run_Model;
E=0;
for j=1:length(W)
    k=find(s==W(j),1,'first');
    if ~isempty(k)
        E=E+(C(j)-q(k)).^2;
    end
end
E=sqrt(E);

function [Wid1,Mxg1]=trans_point(r)
global Wid0 Mxg0
global r_min r_max

n1=Wid0*(r_min:0.001:r_max);
m1=r_max*Mxg0-r*(n1-r_max*Wid0)/Wid0*Mxg0;
figure(300)
hold on
plot(n1,m1,'r-')
hold off
er=zeros(size(n1));
for j=1:length(n1)
    er(j)=Errint(n1(j),m1(j));
end
gr=sign(er);
jk=find(gr~=gr(end),1,'last');
Wid1=n1(jk); Mxg1=m1(jk);

function E=Errint(N0,M)
global Cases Growth Weeks

Er=Growth-4*M/N0.*Cases.*(1-Cases/N0);
E=sum(Er)*(Weeks(2)-Weeks(1));


function Prof_R(stp)

% Plot time evolution of ocean tracer profiles with step 'stp' which is a
% multiple of time interval at which results were saved in OutThilda_R.mat.
% For example, Prof_R(10) plots profiles at ten times the time interval for
% saving the results. For the standard value for this time interval (10
% years), profiles are thus plotted every 100 years in this case.

if exist('stp')==0;
disp('Prof_R should be called with a step variable, e.g. Prof_R(2)')
return
end
%-----

load OutThilda_R

%-----
% Get parameter values

ParVal_R % Activate global parameters
global dm d n 

%-----
%Load ocean average, low mid-latitude ocean data for comparison

load ('LLTEMPdata.txt')
load ('LLSALdata.txt')
load ('LLPO4data.txt')
LLPO4data=[LLPO4data(1:40)];
load ('LLO2data.txt')
LLO2data=[LLO2data(1:40)];
load ('LLDICdata.txt')
LLDICdata=[LLDICdata(1:40)];
load ('LLALKdata.txt')
LLALKdata=[LLALKdata(1:40)];

%-----
zcent= [dm/2 dm+(d:d:(n-1)*d)-d/2]/1e3;   % Vertical center of boxes
%-----

% Loop through the time series with step 'stp'
disp(strcat([int2str(round(length(st)/stp)) '  images will be shown with short intervals.']))
disp(strcat(['The model time between images is ' int2str(round(st(2)-st(1))*stp) ' years.' ]))
if length(st)/stp>10 disp('!! Increase input step variable to Prof(step) for fewer images. !!'); end
for i=1:stp:length(st)
%-----

% Iterate carbonate system for the vertical profile of 
% the CO3 concentration, CO3 saturation concentration, and pH 
%-----
[LLCO3,LLCO3s,HpLL]=CarSysPres_R(sLL(:,:,i));
[HLCO3,HLCO3s,HpHL]=CarSysPres_R(sHL(:,:,i));
pHLL=-log10(HpLL);
pHHL=-log10(HpHL);

%-----
% Plotting
%-----

set(gcf,'paperunits','inches','units','inches')
set(gcf,'paperposition',[1 2 6 7])
set(gcf,'position',     [0 0 6 7])
set(0  ,'defaultlinelinewidth',2.2)
set(0  ,'defaultaxesfontname','times')
set(0  ,'defaultaxesfontsize',8)



subplot(4,2,1)
P=get(gca,'position');set(gca,'position',[P(1) P(2) P(3) P(4)*1.04])

%Low mid-latitude ocean temperature profile 
plot([sLL(1,1,i) sLL(1,1,i) sLL(1,2:n,i)],[0 dm/1e3 zcent(2:end)],'r-');axis ij; hold on

%High latitude ocean temperature profile
plot([sHL(1,1,i) sHL(1,1,i) sHL(1,2:n,i)],[0 dm/1e3 zcent(2:end)],'b-');

plot(LLTEMPdata,[50 (150:100:3950)]/1e3,'k+','MarkerSize',2);       
ylabel('z (km)')
xlabel('T (^oC)')
axis([-2 30 0 n*d*1e-3])
ax(1)=gca;


subplot(4,2,2)
P=get(gca,'position');set(gca,'position',[P(1) P(2) P(3) P(4)*1.04])

%Low mid-latitude ocean salinity profile 
plot([sLL(2,1,i) sLL(2,1,i) sLL(2,2:n,i)],[0 dm/1e3 zcent(2:end)],'r-');axis ij; hold on

%Low mid-latitude ocean salinity profile 
plot([sHL(2,1,i) sHL(2,1,i) sHL(2,2:n,i)],[0 dm/1e3 zcent(2:end)],'b-');

plot(LLSALdata,[50 (150:100:3950)]/1e3,'k+','MarkerSize',2);  
ylabel('z (km)')
xlabel('S')
axis([34 37 0 n*d*1e-3])
ax(2)=gca;


subplot(4,2,3)
P=get(gca,'position');set(gca,'position',[P(1) P(2) P(3) P(4)*1.04])

%Low mid-latitude ocean phosphate profile 
plot(1000/1.027*[sLL(3,1,i) sLL(3,1,i) sLL(3,2:n,i)],[0 dm/1e3 zcent(2:end)],'r-');axis ij; hold on

%High latitude ocean phosphate profile 
plot(1000/1.027*[sHL(3,1,i) sHL(3,1,i) sHL(3,2:n,i)],[0 dm/1e3 zcent(2:end)],'b-');

plot(LLPO4data,(50:100:3950)/1e3,'k+','MarkerSize',2);
ylabel('z (km)')
xlabel('P (\mu{mol} kg^{-1})')
axis([0 4 0 n*d*1e-3])
ax(3)=gca;


subplot(4,2,4)
P=get(gca,'position');set(gca,'position',[P(1) P(2) P(3) P(4)*1.04])

%Low mid-latitude ocean dissolved oxygen profile 
plot(1000/1.027*[sLL(6,1,i) sLL(6,1,i) sLL(6,2:n,i)],[0 dm/1e3 zcent(2:end)],'r-');axis ij; hold on

%High latitude ocean dissolved oxygen profile 
plot(1000/1.027*[sHL(6,1,i) sHL(6,1,i) sHL(6,2:n,i)],[0 dm/1e3 zcent(2:end)],'b-');

plot(LLO2data,(50:100:3950)/1e3,'k+','MarkerSize',2);
ylabel('z (km)')
xlabel('O_2 (\mu{mol} kg^{-1})')
axis([0 400 0 n*d*1e-3])
ax(4)=gca;


subplot(4,2,5)
P=get(gca,'position');set(gca,'position',[P(1) P(2) P(3) P(4)*1.04])

%Low mid-latitude ocean dissolved inorganic carbon profile 
plot(1000/1.027*[sLL(4,1,i) sLL(4,1,i) sLL(4,2:n,i)],[0 dm/1e3 zcent(2:end)],'r-');axis ij; hold on

%High latitude ocean dissolved inorganic carbon profile 
plot(1000/1.027*[sHL(4,1,i) sHL(4,1,i) sHL(4,2:n,i)],[0 dm/1e3 zcent(2:end)],'b-');

%Low mid-latitude ocean alkalinity profile 
plot(1000/1.027*[sLL(5,1,i) sLL(5,1,i) sLL(5,2:n,i)],[0 dm/1e3 zcent(2:end)],'r:');axis ij;

%High latitude ocean alkalinity profile 
plot(1000/1.027*[sHL(5,1,i) sHL(5,1,i) sHL(5,2:n,i)],[0 dm/1e3 zcent(2:end)],'b:');

plot(LLDICdata,(50:100:3950)/1e3,'k+','MarkerSize',2);
plot(LLALKdata,(50:100:3950)/1e3,'k+','MarkerSize',2);
ylabel('z (km)')
xlabel('DIC (\mu{mol} kg^{-1}) & Alk (\mu{mol} kg^{-1})')
axis([1800 3000 0 n*d*1e-3])
ax(5)=gca;


subplot(4,2,6)
P=get(gca,'position');set(gca,'position',[P(1) P(2) P(3) P(4)*1.04])

%Low mid-latitude ocean carbonate ion profile 
plot(1000/1.027*[LLCO3(1)  LLCO3(1)  LLCO3(2:n) ],[0 dm/1e3 zcent(2:end)],'r-');axis ij; hold on

%High latitude ocean carbonate ion profile 
plot(1000/1.027*[HLCO3(1)  HLCO3(1)  HLCO3(2:n) ],[0 dm/1e3 zcent(2:end)],'b-');

%Low mid-latitude ocean profile of carbonate ion saturation with calcite
plot(1000/1.027*[LLCO3s(1) LLCO3s(1) LLCO3s(2:n)],[0 dm/1e3 zcent(2:end)],'r:');

%High latitude ocean profile of carbonate ion saturation with calcite
plot(1000/1.027*[HLCO3s(1) HLCO3s(1) HLCO3s(2:n)],[0 dm/1e3 zcent(2:end)],'b:');

ylabel('z (km)')
xlabel('CO_3 & CO_3^{sat} (\mu{mol} kg^{-1})')
axis([0 300 0 n*d*1e-3])
ax(6)=gca;


subplot(4,2,7)
P=get(gca,'position');set(gca,'position',[P(1) P(2) P(3) P(4)*1.04])

%Low mid-latitude ocean pH profile 
plot([pHLL(1)  pHLL(1)  pHLL(2:n) ],[0 dm/1e3 zcent(2:end)],'r-');axis ij; hold on

%High latitude ocean pH profile 
plot([pHHL(1)  pHHL(1)  pHHL(2:n) ],[0 dm/1e3 zcent(2:end)],'b-');

ylabel('z (km)')
xlabel('pH')
axis([6.5 8.5 0 n*d*1e-3])
ax(7)=gca;


subplot(4,2,8)
P=get(gca,'position');set(gca,'position',[P(1) P(2) P(3) P(4)*1.04])

%Low mid-latitude profile with ocean depth of calcite dry weight fraction
%in the bioturbated sediment layer
plot([dwcLL(1,i) dwcLL(1,i) dwcLL(2:end,i)'],[0 dm/1e3 zcent(2:end)],'r-');axis ij; hold on

%High latitude profile with ocean depth of calcite dry weight fraction
%in the bioturbated sediment layer
plot([dwcHL(1,i) dwcHL(1,i) dwcHL(2:end,i)'],[0 dm/1e3 zcent(2:end)],'b-');

ylabel('z (km)')
xlabel('CaCO3 dry weight fraction')
axis([0 1 0 n*d*1e-3])
ax(8)=gca;


drawnow
if i==1
pause(5)
end
pause(.1)

set(ax,'nextplot','replace')

end            % Loop
return

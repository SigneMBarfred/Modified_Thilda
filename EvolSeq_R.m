% Plot tracer evolutions as in Fig. 2 of Shaffer (2010) Nature Geoscience

%-----
clear all

load('OutThilda_R')

load Globalarea.txt    

% Read in parameter values
%-----
ParVal_R
global  n aLL aHL fdiv dm d mgt 

GAw=interp1(Globalarea(1:23,1),Globalarea(1:23,14),[dm dm+d*(1:n-1)]);
GAc=interp1(Globalarea(24:46,1),Globalarea(24:46,14),[dm dm+d*(1:n-1)]);
GAw=GAw./GAw(1);
GAc=GAc./GAc(1);

%Calculate future "dead zone" area (500m) and volume for the global ocean

[Afrac, Vfrac] = O2DistFuture_R(sLL,sHL,GAw,GAc);

for i=1:25
VfracModern(i)=0.0031+i*i*i/5.2e7;
end

Totvol=2*dm*(aLL*sum(GAw)+aHL*sum(GAc));
Icevol=68.8;

for ii=1:length(sAT(4,1,:))

  TL=sLL(1,:,ii);
  TH=sHL(1,:,ii);
  DICL=sLL(4,:,ii);
  DICH=sHL(4,:,ii);
    
 totsumTL=0;totsumTH=0;
 totsumDICL=0;totsumDICH=0; 
 for i=1:n
       sumTL=TL(i)*GAw(i);
       sumTH=TH(i)*GAc(i);
       totsumTL=totsumTL+sumTL;
       totsumTH=totsumTH+sumTH;
       sumDICL=DICL(i)*GAw(i);
       sumDICH=DICH(i)*GAc(i);
       totsumDICL=totsumDICL+sumDICL;
       totsumDICH=totsumDICH+sumDICH;
       
  end


MeanoceanT(ii)=2*dm*(aLL*totsumTL+aHL*totsumTH)/Totvol;   
TotoceanDIC(ii)=2*dm*(aLL*totsumDICL+aHL*totsumDICH)/mgt;   

end

%--------------
%Plotting
%--------------

set(gcf,'paperunits','inches','units','inches')
set(gcf,'paperposition',[1 2 6 7])
set(gcf,'position',     [0 0 6 7])
set(0  ,'defaultlinelinewidth',2.2)
set(0  ,'defaultaxesfontname','times')
set(0  ,'defaultaxesfontsize',8)
%-----

st=st+1765;

subplot(3,2,1)
%-------------
P=get(gca,'position');set(gca,'position',[P(1) P(2) P(3) P(4)*1.2])

%Atmospheric CO2 partial pressure
semilogx(st,squeeze(sAT(4,1,:))*1e6,'r');hold on
line([st(1) st(end)], [278 278],'Color','k', 'LineWidth', 0.4);

set(gca,'xtick',[2000 3000 4000 5000 6000 7000 8000 9000 10000 20000 ...
    30000 40000 50000 60000 70000 80000 90000 99995])
set(gca,'xticklabel','2000|||5000|||||10000|20000|||50000|||||100000')
axis([[min(st) max(st)] 200 1240])
ylabel('pCO_2 (\mu{atm})')

subplot(3,2,2)
%-------------

%Geological carbon storage

P=get(gca,'position');set(gca,'position',[P(1) P(2) P(3) P(4)*1.2])

semilogx(st,2*squeeze(sGS(1,:)),'r');

set(gca,'xtick',[2000 3000 4000 5000 6000 7000 8000 9000 10000 20000 ...
    30000 40000 50000 60000 70000 80000 90000 99995])
set(gca,'xticklabel','2000|||5000|||||10000|20000|||50000|||||100000')
axis([[min(st) max(st)] 0 5900])
ylabel('Geol. CO_2 storage (GtC)')

subplot(3,2,3)
P=get(gca,'position');set(gca,'position',[P(1) P(2) P(3) P(4)*1.2])
% Establish the atmospheric temperature profile, 2.order legendre pol. in 
% sine of lat, Ta(lat) = PTa(1) + .5*PTa(2) * ( 3*sin(lat)^2 -1 )
% Coefficients are calculated so that the area weighted mean of the profile
% matches the surface mean temperatures in each sector.
for ii=1:length(sAT(1,1,:))
  CTa(1,:) = [ 1 .5*(sin(fdiv)^2-1)                   ];
  CTa(2,:) = [ 1 .5*(sin(fdiv)-sin(fdiv)^3)/(1-sin(fdiv)) ];
  RTa      = [ sAT(1,1,ii) sAT(1,2,ii)]';
  PTa(1:2,ii)= CTa\RTa;
end

%Global warming from AD 1765
semilogx(st,PTa(1,:)-15,'r');hold on;
line([st(1) st(end)], [0 0],'Color','k', 'LineWidth', 0.4);

set(gca,'xtick',[2000 3000 4000 5000 6000 7000 8000 9000 10000 20000 ...
    30000 40000 50000 60000 70000 80000 90000 99995])
set(gca,'xticklabel','2000|||5000|||||10000|20000|||50000|||||100000')
axis([[min(st) max(st)] -0.4 5.9])
ylabel('Mean atmos. warming (^oC)')

subplot(3,2,4)
%-------------

%Ocean inorganic carbon inventory change

P=get(gca,'position');set(gca,'position',[P(1) P(2) P(3) P(4)*1.2])

semilogx(st,TotoceanDIC(:)-TotoceanDIC(1),'r');hold on;

set(gca,'xtick',[2000 3000 4000 5000 6000 7000 8000 9000 10000 20000 ...
    30000 40000 50000 60000 70000 80000 90000 99995])
set(gca,'xticklabel','2000|||5000|||||10000|20000|||50000|||||100000')
axis([[min(st) max(st)] 0 5900])
ylabel('Ocean C invent. change (GtC)')


subplot(3,2,5)
%-------------
%Ocean mean temperature change from AD 1765

P=get(gca,'position');set(gca,'position',[P(1) P(2) P(3) P(4)*1.2])

semilogx(st,MeanoceanT(:)-MeanoceanT(1),'r');hold on;
line([st(1) st(end)], [0 0],'Color','k', 'LineWidth', 0.4);

set(gca,'xtick',[2000 3000 4000 5000 6000 7000 8000 9000 10000 20000 ...
    30000 40000 50000 60000 70000 80000 90000 99995])
set(gca,'xticklabel','2000|||5000|||||10000|20000|||50000|||||100000')
axis([[min(st) max(st)] -0.4 5.9])
ylabel('Mean ocean warming (^oC)')
xlabel('Date (years AD) ')

subplot(3,2,6)
%-------------
%"Dead zone" fraction of global ocean volume, defined as volume with
%dissolved oxygen concentration <10 micromole per kilogram

P=get(gca,'position');set(gca,'position',[P(1) P(2) P(3) P(4)*1.2])

if length(sLL(6,1,:))>=24
    semilogx(st(24:end), Vfrac(24:end), 'r'); hold on
    semilogx(st(1:24),VfracModern(1:24), 'r');
else
    semilogx(st(1:end),VfracModern(1:length(st)), 'r');
end

set(gca,'xtick',[2000 3000 4000 5000 6000 7000 8000 9000 10000 20000 ...
    30000 40000 50000 60000 70000 80000 90000 99995])
set(gca,'xticklabel','2000|||5000|||||10000|20000|||50000|||||100000')
axis([[min(st) max(st)] 0 0.045])
ylabel('"Dead zone" vol. frac.')
xlabel('Date (years AD) ')
 
return

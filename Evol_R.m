% Plot tracer evolutions
%-----
clear all

load('OutThilda_R')
load Globalarea.txt


% Read in parameter values
%-----
ParVal_R
global sy rcp n aLL aHL fdiv fland Tseaice Tsnow dm d rc 


GAw=interp1(Globalarea(1:23,1),Globalarea(1:23,14),[dm dm+d*(1:n-1)]);
GAc=interp1(Globalarea(24:46,1),Globalarea(24:46,14),[dm dm+d*(1:n-1)]);
GAw=GAw./GAw(1);
GAc=GAc./GAc(1);

Totvol=2*dm*(aLL*sum(GAw)+aHL*sum(GAc));

st=st+1765;

for ii=1:length(sAT(4,1,:))
    TLL=sLL(1,:,ii);
    THL=sHL(1,:,ii);
    totsumLLT=0;totsumHLT=0;
       for i=1:n
       sumLLT = TLL(i)*GAw(i);
       sumHLT = THL(i)*GAc(i);
       totsumLLT=totsumLLT+sumLLT;
       totsumHLT=totsumHLT+sumHLT;
       end
Totoceanheat(ii)=2*rc*dm*(aLL*totsumLLT+aHL*totsumHLT);
MeanoceanT(ii)=Totoceanheat(ii)/(rc*Totvol);
end

%%-----
set(gcf,'paperunits','inches','units','inches')
set(gcf,'paperposition',[1 2 6 7])
set(gcf,'position',     [0 0 6 7])
set(0  ,'defaultlinelinewidth',2.2)
set(0  ,'defaultaxesfontname','times')
set(0  ,'defaultaxesfontsize',8)

%-----


subplot(5,2,1)
%-------------
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
plot(st,PTa(1,:)-PTa(1,1),'k-');
axis([[min(st) max(st)] -0.4 5.9])
ylabel('delT^{atm} (^oC)')

%-------------

subplot(5,2,2)
%-------------
P=get(gca,'position');set(gca,'position',[P(1) P(2) P(3) P(4)*1.2])
%Ocean mean temperature change from AD 1765
plot(st,MeanoceanT(:)-MeanoceanT(1),'k-'); hold on
axis([[min(st) max(st)] -0.4 5.9])
ylabel('delT^{ocean}(^oC)')
%-------------

subplot(5,2,3)
%-------------
P=get(gca,'position');set(gca,'position',[P(1) P(2) P(3) P(4)*1.2])
% Establish snow and ice latitude lines
for ii=1:length(sAT(1,1,:))
  fseaice(ii)  = min(fland , asin((2/(3*PTa(2,ii))*(Tseaice -PTa(1,ii)+PTa(2,ii)/2))^(.5)) );
  fsnow(ii)    = min(pi/2-.001 , asin((2/(3*PTa(2,ii))*(Tsnow-PTa(1,ii)+PTa(2,ii)/2))^(.5)) );  
end
%Sea ice line latitude
plot(st,fseaice*180/pi,'b');hold on
%Snow line latitude
plot(st,fsnow*180/pi,'r');
axis([[min(st) max(st)] 40 90])
ylabel('\phi^{snow/ice} (deg)')

%-------------

subplot(5,2,4)
%--------------
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
  PTay(1,ii)  = 3*PTa(2,ii)*sin(fdiv)*cos(fdiv);
  PTad(1,ii)  = PTa(1,ii) + PTa(2,ii)*.5*(3*sin(fdiv).^2-1);
  Fw(1,ii)= 1.2*2e-6*10e9 * exp(-5420/(PTad(1,ii)+273))*abs(PTay(1,ii))^2.5; 
end
%Atmospheric moisture transport (poleward) across the dividing latitude (52 degrees) 
plot(st,Fw(1,:),'r');
axis([[min(st) max(st)] 0.6 1.2])
ylabel('Fw (Sv)')
xlabel('t (kyr)')

subplot(5,2,5)
%-------------
P=get(gca,'position');set(gca,'position',[P(1) P(2) P(3) P(4)*1.2])
%Atmospheric CO2 partial pressure
plot(st,squeeze(sAT(4,1,:))*1e6,'k-'); hold on
axis([[min(st) max(st)] 200 1240])
ylabel('pCO_2 (\mu{atm})')
%-------------

subplot(5,2,6)
%-------------
P=get(gca,'position');set(gca,'position',[P(1) P(2) P(3) P(4)*1.2])
%Atmospheric CCH4 partial pressure
plot(st,squeeze(sAT(2,1,:))*1e6,'b-'); hold on 
%Atmospheric N2O partial pressure
plot(st,squeeze(sAT(3,1,:))*1e6,'r-')                           %N20 x 10 (ppm)
axis([[min(st) max(st)] 0 7])
ylabel('pCH4, pN2O (\mu{atm})')
%-------------

subplot(5,2,7)
%-------------
P=get(gca,'position');set(gca,'position',[P(1) P(2) P(3) P(4)*1.2])
%Calculate organic carbon production from gross ocean surface layer
%phosphate sink, corrected for river input of phosphate and multiplied by
%C:P redfield ratio
NPLL(1,1,:)=-2*(srLL(3,1,:)-RoLL(1,1,:))*rcp*12.011*sy/1e15;
NPHL(1,1,:)=-2*(srHL(3,1,:)-RoHL(1,1,:))*rcp*12.011*sy/1e15;
%Calculate biogenic calcium carbonate production ratio
%("rain ratio),Maier-Reimer (1993), GBC 
rpm = 0.36;                                         
Tr  = 10;                                           
p1  = 1;                                            
p2  = 0.1;                                          
rpLL(1,1,:)  = rpm* p1*exp(p2*(sAT(1,1,:)-Tr))./(1+p1*exp(p2*(sAT(1,1,:)-Tr)));  % [-]
rpHL(1,1,:)  = rpm* p1*exp(p2*(sAT(1,2,:)-Tr))./(1+p1*exp(p2*(sAT(1,2,:)-Tr)));
%Low mid-latitude organic C production ("new production")
plot(st,squeeze(NPLL(1,1,:)),'r'), hold on
%High latitude organic C production ("new production")
plot(st,squeeze(NPHL(1,1,:)),'b')
%Low mid-latitude biogenic CaCO3-C production
plot(st,squeeze(NPLL(1,1,:).*rpLL(1,1,:)),'r:')
%High latitude biogenic CaCO3-C production
plot(st,squeeze(NPHL(1,1,:).*rpHL(1,1,:)),'b:')
axis([[min(st) max(st)] 0 8])
ylabel('NP (GtC/y)')
%-------------

subplot(5,2,8)
%-------------
P=get(gca,'position');set(gca,'position',[P(1) P(2) P(3) P(4)*1.2])
%Ocean mean dissolved oxygen concentration at 500 m depth
plot(st,1000/1.027*(squeeze(sLL(6,5,:))*GAw(5)*aLL+squeeze(sHL(6,5,:))*GAc(5)*aHL)/...
    (GAw(5)*aLL+GAc(5)*aHL),'r'); hold on
%Ocean mean dissolved oxygen concentration at 3000 m depth
plot(st,1000/1.027*(squeeze(sLL(6,30,:))*GAw(30)*aLL+squeeze(sHL(6,30,:))*GAc(30)*aHL)/...
    (GAw(30)*aLL+GAc(30)*aHL),'b')
axis([[min(st) max(st)] 0 300])
ylabel('O_2 (\mu{mol} kg^{-1})')
%-------------

subplot(5,2,9)
%-------------
P=get(gca,'position');set(gca,'position',[P(1) P(2) P(3) P(4)*1.2])
%Total amount of carbon sequestered
plot(st,2*squeeze(sGS(1,:)),'k-'); hold on
axis([[min(st) max(st)] 0 3000])
ylabel('GS(GtC)')
xlabel('Date (AD)')
%-------------

subplot(5,2,10)
%-------------
P=get(gca,'position');set(gca,'position',[P(1) P(2) P(3) P(4)*1.2])
%carbon inventory in leaves and wood
plot(st,2*(squeeze(sLB(1,1,:) + sLB(2,1,:))),'b-'); hold on 
%Carbon inventory in litter and soil
plot(st,2*(squeeze(sLB(3,1,:) + sLB(4,1,:))),'r-');
%Total land biospher carbon inventory
plot(st,2*(squeeze(sLB(1,1,:) + sLB(2,1,:) + sLB(3,1,:) + sLB(4,1,:))),'k-');
axis([[min(st) max(st)] 0 4000])
ylabel('LB (GtC)')
xlabel('Date (AD)')

%-------------


% 3rd of june 2026 - changes below: 
for ii=1:length(st)

    DICLL = squeeze(sLL(4,:,ii));
    DICHL = squeeze(sHL(4,:,ii));

    OceanC(ii) = 2*12.011* ...
        ( aLL*sum(DICLL.*GAw)*dm + ...
          aHL*sum(DICHL.*GAc)*dm ) ...
          /1e15;          % GtC

end
subplot(5,2,9)

plot(st,OceanC,'k')
ylabel('Ocean DIC (GtC)')
xlabel('Date (AD)')

subplot(5,2,8)

plot(st,squeeze(sLL(4,1,:)),'r')
hold on
plot(st,squeeze(sLL(4,30,:)),'b')

legend('Surface','3000 m')
ylabel('DIC (mol m^{-3})')


sgtitle('Modelled from B1\_5C, q_{max} \times 0.5')
return

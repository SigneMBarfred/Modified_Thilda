%Plots of forcings for different scenarios and climate sensitivities (CS)


h = 1;          %time step in years (=1/25)
datemax = 10000;    %maximum date for plotting, AD

%Forcings used in Shaffer (2010), Nature Geoscience:

%[daint,MHC,MHA,MHM,LWR,co2emfos,co2emland,ch4em,co2seq1,co2seq2]=ForceA2_3C(h);   %A2forcing,3 CS
%[daint,MHC,MHA,MHM,LWR,co2emfos,co2emland,ch4em,co2seq1,co2seq2]=ForceOS_3C(h);   %OS forcing,3 CS 
%[daint,MHC,MHA,MHM,LWR,co2emfos,co2emland,ch4em,co2seq1,co2seq2]=ForceGS1_3C(h);  %GS1 forcing,3 CS
%[daint,MHC,MHA,MHM,LWR,co2emfos,co2emland,ch4em,co2seq1,co2seq2]=ForceGS2_3C(h);  %GS2 forcing,3 CS
%[daint,MHC,MHA,MHM,LWR,co2emfos,co2emland,ch4em,co2seq1,co2seq2]=ForceGS3_3C(h);  %GS3 forcing,3 CS
%[daint,MHC,MHA,MHM,LWR,co2emfos,co2emland,ch4em,co2seq1,co2seq2]=ForceGS1O_3C(h); %GS1O forcing,3 CS
%[daint,MHC,MHA,MHM,LWR,co2emfos,co2emland,ch4em,co2seq1,co2seq2]=ForceAG_3C(h);   %AG forcing,3 CS 

%Forcings used in Shaffer, Olsen and Pedersen (2009), Nature Geoscience: 

[daint,MHC,MHA,MHM,LWR,co2emfos,co2emland,ch4em,co2seq1,co2seq2]=ForceA2_3C(h);   %A2forcing,3 CS
%[daint,MHC,MHA,MHM,LWR,co2emfos,co2emland,ch4em,co2seq1,co2seq2]=ForceA2_5C(h);   %A2forcing,4.8 CS
%[daint,MHC,MHA,MHM,LWR,co2emfos,co2emland,ch4em,co2seq1,co2seq2]=ForceB1_3C(h);   %B1forcing,3 CS
%[daint,MHC,MHA,MHM,LWR,co2emfos,co2emland,ch4em,co2seq1,co2seq2]=ForceB1_5C(h);   %B1forcing,4.8 CS

for i = 1:datemax-1765                                  % 
emgross(i)=2*MHC(6)*(i-MHC(3))^4*exp(-MHC(7)*(i-MHC(3))); 
emnet(i)=2*MHC(4)*(i-MHC(2))^4*exp(-MHC(5)*(i-MHC(2))); 
metem(i)=2*MHM(2)*(i-MHM(1))^4*exp(-MHM(3)*(i-MHM(1)));
aero(i)=(MHA(2)*(i-MHA(1))^4*exp(-MHA(3)*(i-MHA(1))));
end

%%-----
set(gcf,'paperunits','inches','units','inches')
set(gcf,'paperposition',[1 2 6 7])
set(gcf,'position',     [0 0 6 7])
set(0  ,'defaultlinelinewidth',2.2)
set(0  ,'defaultaxesfontname','times')
set(0  ,'defaultaxesfontsize',8)
%-----


%-----

subplot (3,1,1)
%Gross anthopogenic CO2 emissions
plot(1766:datemax,0,'k');hold on
plot(1766:2100,(co2emland(1:1/h:335/h)+co2emfos(1:1/h:335/h)+...
    co2seq1(1:1/h:335/h)+co2seq2(1:1/h:335/h))*1e-3,'r');
plot(2100:datemax,emgross(335:datemax-1765),'r')
%Carbon sequestration
plot(1766:2100,-(co2seq1(1:1/h:335/h)+co2seq2(1:1/h:335/h))*1e-3,'b');
plot(2100:datemax,-(emgross(335:datemax-1765)-emnet(335:datemax-1765)),'b')
%Net anthropogenic CO2 emissions
plot(1766:2100,(co2emland(1:1/h:335/h)+co2emfos(1:1/h:335/h))*1e-3,'g')
plot(2100:datemax,emnet(335:datemax-1765),'g')

axis([[1766 datemax] -35 35])
ylabel('CO2 em. & seq. (GtC/y)')

subplot (3,1,2)
%Anthropogenic CH4 emission
plot(1766:2100,ch4em(1:1/h:335/h)*0.75*1e-3,'r');hold on
plot(2100:datemax,metem(335:datemax-1765),'r');
axis([[1766 datemax] 0 1])
ylabel('CH4 em. (GtC/y)')

subplot (3,1,3)
%Residual forcing (aerosols, minor greenhouse gases, solar radiation changes)
plot(1766:datemax,0,'k');hold on
plot(1766:2100,daint(1:1/h:335/h),'b');
plot(2100:datemax,aero(335:datemax-1765),'b');
axis([[1766 datemax] -2 1])
ylabel('Resid. forcing (W m^-2)')



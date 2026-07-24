
files = {'OutThilda_A23C_10k_q0.25',...
         'OutThilda_A23C_10k_q0.50',...
         'OutThilda_A23C_10k_q0.75',...
         'OutThilda_A23C_10k_q1.00'};

%%% from Evol_R




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


%%-----
set(gcf,'paperunits','inches','units','inches')
set(gcf,'paperposition',[1 2 6 7])
set(gcf,'position',     [0 0 6 7])
set(0  ,'defaultlinelinewidth',2.2)
set(0  ,'defaultaxesfontname','times')
set(0  ,'defaultaxesfontsize',8)

%%%% End of snippet from Evol_R





figure
hold on

for i = 1:length(files)

    load(files{i},'st','sAT')

    plot(st+1765,squeeze(sAT(4,1,:))*1e6)

end

legend('0.25x','0.5x','0.75x','1x')
ylabel('pCO_2 (\mu atm)')
xlabel('Year')


figure
hold on

for i = 1:length(files)

    load(files{i},'st','sLL','sHL','aLL','aHL','GAw','GAc','dm')

    OceanC = zeros(length(st),1);

    for ii = 1:length(st)

        DICLL = squeeze(sLL(4,:,ii));
        DICHL = squeeze(sHL(4,:,ii));

        OceanC(ii) = 2*12.011 * ...
            ( aLL*sum(DICLL.*GAw)*dm + ...
              aHL*sum(DICHL.*GAc)*dm ) ...
              /1e15;
    end

    plot(st+1765,OceanC,'LineWidth',1.5)

end

legend('0.25x','0.5x','0.75x','1x')
ylabel('Ocean DIC (GtC)')
xlabel('Year')



figure
hold on

for i = 1:length(files)

    load(files{i},'st','sLL')

    plot(st+1765,squeeze(sLL(4,1,:)),'LineWidth',1.5)

end

legend('0.25x','0.5x','0.75x','1x')
ylabel('Surface DIC (mol m^{-3})')
xlabel('Year')


figure
hold on

for i = 1:length(files)

    load(files{i},'st','sLL')

    plot(st+1765,squeeze(sLL(4,30,:)),'LineWidth',1.5)

end

legend('0.25x','0.5x','0.75x','1x')
ylabel('DIC at 3000 m (mol m^{-3})')
xlabel('Year')




% for 10000 year prediction

clear all

files = {'OutThilda_B15C_10k_q0.25.mat',...
         'OutThilda_B15C_10k_q0.50.mat',...
         'OutThilda_B15C_10k_q0.75.mat',...
         'OutThilda_B15C_10k_q1.00.mat'};
%%% from Evol_R



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



%%-----
set(gcf,'paperunits','inches','units','inches')
set(gcf,'paperposition',[1 2 6 7])
set(gcf,'position',     [0 0 6 7])
set(0  ,'defaultlinelinewidth',2.2)
set(0  ,'defaultaxesfontname','times')
set(0  ,'defaultaxesfontsize',8)

%%%% End of snippet from Evol_R

figure
hold on

for i = 1:length(files)

    load(files{i},'st','sAT')

    plot(st+1765,log(squeeze(sAT(4,1,:))*1e6))

end

legend('0.25x','0.5x','0.75x','1x')
ylabel('pCO_2 (\mu atm)')
xlabel('Year')

title("Testing again")



figure; hold on

load(files{end},'st','sAT')
ref = squeeze(sAT(4,1,:)) * 1e6;

for i = 1:length(files)
    load(files{i},'st','sAT')

    pco2 = squeeze(sAT(4,1,:)) * 1e6;
    delta = pco2 - ref;

    plot(st+1765, delta)
end

yline(0,'k--')
legend('0.25x','0.5x','0.75x','1x')
ylabel('\Delta pCO_2 relative to 1x (\mu atm)')
xlabel('Year')
title('Differences made visible')
grid on




figure
hold on

for i = 1:length(files)

    load(files{i},'st','sLL','sHL','aLL','aHL','GAw','GAc','dm')

    OceanC = zeros(length(st),1);

    for ii = 1:length(st)

        DICLL = squeeze(sLL(4,:,ii));
        DICHL = squeeze(sHL(4,:,ii));

        OceanC(ii) = 2*12.011 * ...
            ( aLL*sum(DICLL.*GAw)*dm + ...
              aHL*sum(DICHL.*GAc)*dm ) ...
              /1e15;
    end

    plot(st+1765,OceanC,'LineWidth',1.5)

end

legend('0.25x','0.5x','0.75x','1x')
ylabel('Ocean DIC (GtC)')
xlabel('Year')



figure
hold on

for i = 1:length(files)

    load(files{i},'st','sLL')

    plot(st+1765,squeeze(sLL(4,1,:)),'LineWidth',1.5)

end

legend('0.25x','0.5x','0.75x','1x')
ylabel('Surface DIC (mol m^{-3})')
xlabel('Year')


figure
hold on

for i = 1:length(files)

    load(files{i},'st','sLL')

    plot(st+1765,squeeze(sLL(4,30,:)),'LineWidth',1.5)

end

legend('0.25x','0.5x','0.75x','1x')
ylabel('DIC at 3000 m (mol m^{-3})')
xlabel('Year')
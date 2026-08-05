%hurtig sanity check at ny cirkulation producere resultater der ikke er
%udenfor fornuftens grænser
%% Load simulation

clear
load OutThilda_A23C_dynamicCirc_ver2_10000yr.mat

% time
year = st + 1765;

% circulation in Sv
qSv = sqmax/1e6;

% density difference
drho = sdrho;

%% Plot 1: circulation through time

figure
plot(year,qSv,'LineWidth',2)
xlabel('Year')
ylabel('Overturning (Sv)')
title('Evolution of overturning circulation')
grid on

%% Plot 2: density contrast through time

figure
plot(year,drho,'LineWidth',2)
xlabel('Year')
ylabel('\Delta\rho (scaled)')
title('Evolution of density contrast')
grid on

%% Plot 3: q as function of density difference

figure
plot(drho,qSv,'LineWidth',2)
xlabel('\Delta\rho')
ylabel('Overturning (Sv)')
title('Overturning as function of density difference')
grid on

%% Plot 4: normalized variables

figure
plot(drho/drho(1),qSv/qSv(1),'LineWidth',2)
xlabel('\Delta\rho / \Delta\rho_0')
ylabel('q / q_0')
title('Normalized circulation response')
grid on

%%
DeltaT = squeeze(sHL(1,1,:) - sLL(1,1,:));
DeltaS = squeeze(sHL(2,1,:) - sLL(2,1,:));

figure

subplot(3,1,1)
plot(year,DeltaT,'LineWidth',2)
ylabel('\DeltaT')
grid on

subplot(3,1,2)
plot(year,DeltaS,'LineWidth',2)
ylabel('\DeltaS')
grid on

subplot(3,1,3)
plot(year,sqmax/1e6,'LineWidth',2)
ylabel('q (Sv)')
xlabel('Year')
grid on

%% what dominates: 
alpha = 2e-4;
beta  = 8e-4;

thermal = -alpha*DeltaT;
haline  =  beta*DeltaS;
figure

plot(year,thermal,'r','LineWidth',2)
hold on
plot(year,haline,'b','LineWidth',2)
plot(year,thermal+haline,'k','LineWidth',2)

legend('Thermal contribution',...
       'Haline contribution',...
       '\Delta\rho')
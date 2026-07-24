

%plotting the new scenarios
ParVal_R
global fdiv 


load('OutThilda_SSP2_dynamicCirc_10000yr.mat')
time = st+1750;




%% plot dynamic circulation strength
SSP1 = load('OutThilda_SSP1_dynamicCirc_10000yr.mat');
A25C = load('OutThilda_A25C_dynamicCirc_10000yr.mat');
B13C = load('OutThilda_B13C_dynamicCirc_10000yr.mat');
B15C = load('OutThilda_B15C_dynamicCirc_10000yr.mat');

figure
plot(st+1750,sqmax/1e6, 'LineWidth',2)
hold on
plot(A23C.st+1765, A23C.sqmax/1e6, 'LineWidth',2)
plot(A25C.st+1765, A25C.sqmax/1e6, 'LineWidth',2)
plot(B13C.st+1765, B13C.sqmax/1e6, 'LineWidth',2)
plot(B15C.st+1765, B15C.sqmax/1e6, 'LineWidth',2)


xlabel('Year')
ylabel('Overturning circulation (Sv)')
xlim([time(1) time(end)])
legend('SSP2','A2 3C', 'A2 5C','B1 3C', 'B1 5C','Location','best')
title('Dynamically adjusted circulation strength for 5 emission scenarios')
grid on



%% relation between carbon in ocean and dynamically evolved circulation strength

SSP1 = load('OutThilda_SSP1_dynamicCirc_10000yr.mat');
SSP2 = load('OutThilda_SSP2_dynamicCirc_10000yr.mat');
SSP3 = load('OutThilda_SSP3_dynamicCirc_10000yr.mat');

Zero = load('OutThilda_ZeroForce_dynamicCirc_10000yr.mat')
time_zero = Zero.st+1765;

zero_Ocean_Carbon = GetOceanCarbonUptake('OutThilda_ZeroForce_dynamicCirc_10000yr.mat')
SSP1_Ocean_Carbon = GetOceanCarbonUptake('OutThilda_SSP1_dynamicCirc_10000yr.mat');
SSP2_Ocean_Carbon = GetOceanCarbonUptake('OutThilda_SSP2_dynamicCirc_10000yr.mat');
SSP3_Ocean_Carbon = GetOceanCarbonUptake('OutThilda_SSP3_dynamicCirc_10000yr.mat');

%plot the cumulative ocean carbon uptake
figure
plot(SSP1.sqmax/1e6, SSP1_Ocean_Carbon,'LineWidth',2)
hold on

plot(SSP2.sqmax/1e6, SSP1_Ocean_Carbon,'LineWidth',2)
plot(SSP3.sqmax/1e6, SSP1_Ocean_Carbon,'LineWidth',2)
plot(Zero.sqmax/1e6, zero_Ocean_Carbon,'LineWidth',2)


xlabel('Overturning circulation (Sv)')
ylabel('Cumulative Ocean Carbon Uptake (GtC) relative to oceanic carbon in 1750')
legend('SSP1','SSP2','SSP3','Zero force')
grid on


%% atm co2


figure
plot(st+1750,squeeze(SSP1.sAT(4,1,:))*1e6)
legend('ssp1')
ylabel('pCO_2 (\mu atm)')
xlabel('Year')

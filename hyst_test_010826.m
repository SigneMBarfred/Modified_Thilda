%sanity check hyst runs
filename = 'OutThilda_SSP1_3C_Hyst_dynamicCirc_ver2_10000yr.mat';
disp(1)
load(filename,'sqmax','st')

OceanCarbon = GetOceanCarbonUptake(filename);
forcingYears = 1501;
endYear = 0 + forcingYears;   

mid = find(st >= 750,1);
finish = find(st >= endYear,1);

%to hyst or not to hyst
figure
hold on

plot(OceanCarbon(1:mid), sqmax(1:mid), 'b', 'LineWidth',2)
plot(OceanCarbon(mid:finish), sqmax(mid:finish), 'r', 'LineWidth',2)
plot(OceanCarbon(finish:end), sqmax(finish:end), 'g', 'LineWidth',2)

xlabel('Change in ocean carbon inventory (GtC)')
ylabel('Overturning circulation strength')
legend('Increasing forcing','Decreasing forcing','Post 3250AD')
grid on

%% what happens as we go towards simulations end? 
figure
plot(OceanCarbon(finish:end), sqmax(finish:end),'LineWidth',2)

xlabel('Change in ocean carbon inventory (GtC)')
ylabel('Overturning circulation strength')
legend('SSP1 (L)')
grid on

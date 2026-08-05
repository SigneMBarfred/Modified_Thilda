%SRES force, scaled circ (plots and table values)


%created july 2026
%examines how circulation sans anthropogenic forcing influences carbon
%variables under forcing


%% load 
A25C_025 = load('OutThilda_A25C_incr_circ_10000yr_q0.25.mat');
A25C_050 = load('OutThilda_A25C_incr_circ_10000yr_q0.50.mat');
A25C_075 = load('OutThilda_A25C_incr_circ_10000yr_q0.75.mat');
A25C_100 = load('OutThilda_A25C_incr_circ_10000yr_q1.00.mat');
A25C_125 = load('OutThilda_A25C_incr_circ_10000yr_q1.25.mat');
A25C_150 = load('OutThilda_A25C_incr_circ_10000yr_q1.50.mat');
time = A25C_025.st+1765;

%plot ocean carbon
A25C_025_Ocean_Carbon  = GetOceanCarbonUptake('OutThilda_A25C_incr_circ_10000yr_q0.25.mat');
A25C_050_Ocean_Carbon  = GetOceanCarbonUptake('OutThilda_A25C_incr_circ_10000yr_q0.50.mat');
A25C_075_Ocean_Carbon  = GetOceanCarbonUptake('OutThilda_A25C_incr_circ_10000yr_q0.75.mat');
A25C_100_Ocean_Carbon  = GetOceanCarbonUptake('OutThilda_A25C_incr_circ_10000yr_q1.00.mat');
A25C_125_Ocean_Carbon  = GetOceanCarbonUptake('OutThilda_A25C_incr_circ_10000yr_q1.25.mat');
A25C_150_Ocean_Carbon  = GetOceanCarbonUptake('OutThilda_A25C_incr_circ_10000yr_q1.50.mat');


figure 
plot(time,A25C_025_Ocean_Carbon,'LineWidth',2)
hold on
plot(time,A25C_050_Ocean_Carbon,'LineWidth',2)
plot(time,A25C_075_Ocean_Carbon,'LineWidth',2)
plot(time,A25C_100_Ocean_Carbon,'LineWidth',2)
plot(time,A25C_125_Ocean_Carbon,'LineWidth',2)
plot(time,A25C_150_Ocean_Carbon,'LineWidth',2)

xlabel('Year')
ylabel('Oceanic carbon uptake (GtC)')
xlim([time(1) time(end)])
legend('q*0.25','q*0.50', 'q*0.75','q*1.00', 'q*1.25','q*1.50','Location','best')
title('A25C forcing: Oceanic carbon uptake relative to 1765')
grid on

%shown  ocean carbon for shorter timescale: 
figure 
plot(time,A25C_025_Ocean_Carbon,'LineWidth',2)
hold on
plot(time,A25C_050_Ocean_Carbon,'LineWidth',2)
plot(time,A25C_075_Ocean_Carbon,'LineWidth',2)
plot(time,A25C_100_Ocean_Carbon,'LineWidth',2)
plot(time,A25C_125_Ocean_Carbon,'LineWidth',2)
plot(time,A25C_150_Ocean_Carbon,'LineWidth',2)

xlabel('Year')
ylabel('Oceanic carbon uptake (GtC)')
xlim([time(1) time(140)])
legend('q*0.25','q*0.50', 'q*0.75','q*1.00', 'q*1.25','q*1.50','Location','best')
title('A25C forcing: Oceanic carbon uptake relative to 1765')
grid on

% oceanic carbon uptake relative to reference circulation q0
figure 
plot(time,A25C_025_Ocean_Carbon-A25C_100_Ocean_Carbon,'LineWidth',2)
hold on
plot(time,A25C_050_Ocean_Carbon-A25C_100_Ocean_Carbon,'LineWidth',2)
plot(time,A25C_075_Ocean_Carbon-A25C_100_Ocean_Carbon,'LineWidth',2)
plot(time,A25C_100_Ocean_Carbon-A25C_100_Ocean_Carbon,'LineWidth',2)
plot(time,A25C_125_Ocean_Carbon-A25C_100_Ocean_Carbon,'LineWidth',2)
plot(time,A25C_150_Ocean_Carbon-A25C_100_Ocean_Carbon,'LineWidth',2)

xlabel('Year')
ylabel('Oceanic carbon uptake anomaly (GtC)')
xlim([time(1) time(end)])
legend('q*0.25','q*0.50', 'q*0.75','q*1.00', 'q*1.25','q*1.50','Location','best')
title('A25C forcing: Oceanic carbon uptake anomaly relative to 1765')
grid on



%plot atmospheric co2
figure 
plot(time,squeeze(A25C_025.sAT(4,1,:))*1e6,'LineWidth',2)
hold on
plot(time,squeeze(A25C_050.sAT(4,1,:))*1e6,'LineWidth',2)
plot(time,squeeze(A25C_075.sAT(4,1,:))*1e6,'LineWidth',2)
plot(time,squeeze(A25C_100.sAT(4,1,:))*1e6,'LineWidth',2)
plot(time,squeeze(A25C_125.sAT(4,1,:))*1e6,'LineWidth',2)
plot(time,squeeze(A25C_150.sAT(4,1,:))*1e6,'LineWidth',2)

xlabel('Year')
ylabel('Atmospheric CO2 (ppm)')
xlim([time(1) time(end)])
legend('q*0.25','q*0.50', 'q*0.75','q*1.00', 'q*1.25','q*1.50','Location','best')
title('Atmospheric CO2 for A25C forcing, scaled circulation')
grid on


%atm CO2 for shorter time
figure 
plot(time,squeeze(A25C_025.sAT(4,1,:))*1e6,'LineWidth',2)
hold on
plot(time,squeeze(A25C_050.sAT(4,1,:))*1e6,'LineWidth',2)
plot(time,squeeze(A25C_075.sAT(4,1,:))*1e6,'LineWidth',2)
plot(time,squeeze(A25C_100.sAT(4,1,:))*1e6,'LineWidth',2)
plot(time,squeeze(A25C_125.sAT(4,1,:))*1e6,'LineWidth',2)
plot(time,squeeze(A25C_150.sAT(4,1,:))*1e6,'LineWidth',2)

xlabel('Year')
ylabel('Atmospheric CO2 (ppm)')
xlim([time(1) time(80)])
legend('q*0.25','q*0.50', 'q*0.75','q*1.00', 'q*1.25','q*1.50','Location','best')
title('Atmospheric CO2 for A25C forcing, scaled circulation')
grid on





%plot ocean carbon / depth / time
%%

%plot sediment? 


[CorgBurial,CcarbBurial,TotalBurial] = ...
    GetSedimentCarbonBurial( ...
    'OutThilda_A25C_incr_circ_10000yr_q1.00.mat');

[min(CorgBurial) max(CorgBurial)]
[min(CcarbBurial) max(CcarbBurial)]


load('OutThilda_A25C_incr_circ_10000yr_q1.00.mat','st')

CumCorg = cumtrapz(st,CorgBurial);
CumCarb = cumtrapz(st,CcarbBurial);

CumTotal = cumtrapz(st,TotalBurial);
disp(CumTotal)

%plot
figure
plot(st+1765,CorgBurial,'LineWidth',1.5)
hold on
plot(st+1765,CcarbBurial,'LineWidth',1.5)
plot(st+1765,TotalBurial,'LineWidth',1.5)

xlabel('Year')
ylabel('Carbon burial (GtC yr^{-1})')
legend('Organic C','CaCO_3-C','Total C')
grid on

%%

%%

%% PLOT: inspecting where carbon is stored: 
%carbon redistribution relative to q0
% Preallocate
OceanC_all    = zeros(nq,nt);
CumBurial_all = zeros(nq,nt);
TempLL_all    = zeros(nq,nt);
TempHL_all    = zeros(nq,nt);

for iq = 1:nq

    filename = sprintf( ...
        'OutThilda_A25C_incr_circ_10000yr_q%.2f.mat',qmult(iq));

    %Ocean carbon
    OceanC_all(iq,:) = GetOceanCarbonUptake(filename);

    %Sediment carbon burial
    [CorgBurial,CcarbBurial,TotalBurial] = ...
        GetSedimentCarbonBurial(filename);

    TotalBurial = -TotalBurial;
    CumBurial_all(iq,:) = cumtrapz(st,TotalBurial);

    %Surface ocean temperature
    S = load(filename,'sLL','sHL');

    TempLL_all(iq,:) = squeeze(S.sLL(1,1,:));
    TempHL_all(iq,:) = squeeze(S.sHL(1,1,:));

end

iref = find(qmult == 1);

DeltaOcean  = OceanC_all - OceanC_all(iref,:);
DeltaBurial = CumBurial_all - CumBurial_all(iref,:);

DeltaTempLL = TempLL_all - TempLL_all(iref,:);
DeltaTempHL = TempHL_all - TempHL_all(iref,:);

%plotting 
figure
tiledlayout(2,3)

for iq = 1:nq

    nexttile

    %LEFT AXIS: carbon
    yyaxis left
    hold on

    h1 = plot(year,DeltaOcean(iq,:), ...
        'LineWidth',1.5);

    h2 = plot(year,-DeltaBurial(iq,:), ...
        '--','LineWidth',1.5);

    yline(0,'k:')

    ylabel('\Delta C (GtC)')

    %RIGHT AXIS: SST anomaly ( temperature)
    yyaxis right
    hold on

    h3 = plot(year,DeltaTempLL(iq,:), ...
        ':','LineWidth',1.5);

    h4 = plot(year,DeltaTempHL(iq,:), ...
        '-.','LineWidth',1.5);

    ylabel('\Delta T (^{\circ}C)')

    %labels
    xlabel('Year')

    title(sprintf('$q/q_0 = %.2f$',qmult(iq)), ...
        'Interpreter','latex')

    grid on

       %place the legend
    if iq == 4
        legend([h1 h2 h3 h4], ...
            '\Delta C_{ocean}', ...
            '-\Delta C_{burial}', ...
            '\Delta T_{LL}', ...
            '\Delta T_{HL}', ...
            'Location','southwest')
    end

end

sgtitle('Ocean carbon, sediment burial and SST anomalies relative to q_0')

%% Outputting data for report tables: 
%% DATA FOR TABLE 1

qmult = [0.25 0.50 0.75 1.00 1.25 1.50];
nq = length(qmult);

% Desired times after initialization
target_t = [335 1000 5000 10000];

% Preallocate
OCU_table = zeros(nq,length(target_t));
DeltaOCU_10k = zeros(nq,1);
CumBurial_10k = zeros(nq,1);

for iq = 1:nq

    filename = sprintf( ...
        'OutThilda_A25C_incr_circ_10000yr_q%.2f.mat',qmult(iq));

    S = load(filename,'st');

    % Ocean carbon uptake relative to 1765
    OCU = GetOceanCarbonUptake(filename);

    % Find nearest saved timestep to requested times
    for it = 1:length(target_t)
        [~,idx] = min(abs(S.st-target_t(it)));
        OCU_table(iq,it) = OCU(idx);
    end

    % Sediment burial
    [~,~,TotalBurial] = GetSedimentCarbonBurial(filename);

    % Make positive = burial
    TotalBurial = -TotalBurial;

    % Cumulative burial [GtC]
    CumBurial = cumtrapz(S.st,TotalBurial);
    CumBurial_10k(iq) = CumBurial(end);

end

% q0 reference
iref = find(qmult == 1);

DeltaOCU_10k = OCU_table(:,end) - OCU_table(iref,end);

DeltaBurial_10k = ...
    CumBurial_10k - CumBurial_10k(iref);

% Display
Table1 = table(qmult', ...
    OCU_table(:,1), ...
    OCU_table(:,2), ...
    OCU_table(:,3), ...
    OCU_table(:,4), ...
    DeltaOCU_10k, ...
    DeltaBurial_10k, ...
    'VariableNames', ...
    {'q_q0','OCU_335yr','OCU_1kyr','OCU_5kyr','OCU_10kyr', ...
     'DeltaOCU_10k','DeltaBurial_10k'});

disp(Table1)

%% for b15c


%% load 
B15C_025 = load('OutThilda_B15C_incr_circ_10000yr_q0.25.mat');
B15C_050 = load('OutThilda_B15C_incr_circ_10000yr_q0.50.mat');
B15C_075 = load('OutThilda_B15C_incr_circ_10000yr_q0.75.mat');
B15C_100 = load('OutThilda_B15C_incr_circ_10000yr_q1.00.mat');
B15C_125 = load('OutThilda_B15C_incr_circ_10000yr_q1.25.mat');
B15C_150 = load('OutThilda_B15C_incr_circ_10000yr_q1.50.mat');
time = B15C_025.st+1765;

%plot ocean carbon
B15C_025_Ocean_Carbon  = GetOceanCarbonUptake('OutThilda_B15C_incr_circ_10000yr_q0.25.mat');
B15C_050_Ocean_Carbon  = GetOceanCarbonUptake('OutThilda_B15C_incr_circ_10000yr_q0.50.mat');
B15C_075_Ocean_Carbon  = GetOceanCarbonUptake('OutThilda_B15C_incr_circ_10000yr_q0.75.mat');
B15C_100_Ocean_Carbon  = GetOceanCarbonUptake('OutThilda_B15C_incr_circ_10000yr_q1.00.mat');
B15C_125_Ocean_Carbon  = GetOceanCarbonUptake('OutThilda_B15C_incr_circ_10000yr_q1.25.mat');
B15C_150_Ocean_Carbon  = GetOceanCarbonUptake('OutThilda_B15C_incr_circ_10000yr_q1.50.mat');


figure 
plot(time,B15C_025_Ocean_Carbon,'LineWidth',2)
hold on
plot(time,B15C_050_Ocean_Carbon,'LineWidth',2)
plot(time,B15C_075_Ocean_Carbon,'LineWidth',2)
plot(time,B15C_100_Ocean_Carbon,'LineWidth',2)
plot(time,B15C_125_Ocean_Carbon,'LineWidth',2)
plot(time,B15C_150_Ocean_Carbon,'LineWidth',2)

xlabel('Year')
ylabel('Oceanic carbon uptake (GtC)')
xlim([time(1) time(end)])
legend('q*0.25','q*0.50', 'q*0.75','q*1.00', 'q*1.25','q*1.50','Location','best')
title('B15C forcing: Oceanic carbon uptake relative to 1765')
grid on

%shown  ocean carbon for shorter timescale: 
figure 
plot(time,B15C_025_Ocean_Carbon,'LineWidth',2)
hold on
plot(time,B15C_050_Ocean_Carbon,'LineWidth',2)
plot(time,B15C_075_Ocean_Carbon,'LineWidth',2)
plot(time,B15C_100_Ocean_Carbon,'LineWidth',2)
plot(time,B15C_125_Ocean_Carbon,'LineWidth',2)
plot(time,B15C_150_Ocean_Carbon,'LineWidth',2)

xlabel('Year')
ylabel('Oceanic carbon uptake (GtC)')
xlim([time(1) time(140)])
legend('q*0.25','q*0.50', 'q*0.75','q*1.00', 'q*1.25','q*1.50','Location','best')
title('B15C forcing: Oceanic carbon uptake relative to 1765')
grid on

% oceanic carbon uptake relative to reference circulation q0
figure 
plot(time,B15C_025_Ocean_Carbon-B15C_100_Ocean_Carbon,'LineWidth',2)
hold on
plot(time,B15C_050_Ocean_Carbon-B15C_100_Ocean_Carbon,'LineWidth',2)
plot(time,B15C_075_Ocean_Carbon-B15C_100_Ocean_Carbon,'LineWidth',2)
plot(time,B15C_100_Ocean_Carbon-B15C_100_Ocean_Carbon,'LineWidth',2)
plot(time,B15C_125_Ocean_Carbon-B15C_100_Ocean_Carbon,'LineWidth',2)
plot(time,B15C_150_Ocean_Carbon-B15C_100_Ocean_Carbon,'LineWidth',2)

xlabel('Year')
ylabel('Oceanic carbon uptake anomaly (GtC)')
xlim([time(1) time(end)])
legend('q*0.25','q*0.50', 'q*0.75','q*1.00', 'q*1.25','q*1.50','Location','best')
title('B15C forcing: Oceanic carbon uptake anomaly relative to 1765')
grid on



%plot atmospheric co2
figure 
plot(time,squeeze(B15C_025.sAT(4,1,:))*1e6,'LineWidth',2)
hold on
plot(time,squeeze(B15C_050.sAT(4,1,:))*1e6,'LineWidth',2)
plot(time,squeeze(B15C_075.sAT(4,1,:))*1e6,'LineWidth',2)
plot(time,squeeze(B15C_100.sAT(4,1,:))*1e6,'LineWidth',2)
plot(time,squeeze(B15C_125.sAT(4,1,:))*1e6,'LineWidth',2)
plot(time,squeeze(B15C_150.sAT(4,1,:))*1e6,'LineWidth',2)

xlabel('Year')
ylabel('Atmospheric CO2 (ppm)')
xlim([time(1) time(end)])
legend('q*0.25','q*0.50', 'q*0.75','q*1.00', 'q*1.25','q*1.50','Location','best')
title('Atmospheric CO2 for B15C forcing, scaled circulation')
grid on


%atm CO2 for shorter time
figure 
plot(time,squeeze(B15C_025.sAT(4,1,:))*1e6,'LineWidth',2)
hold on
plot(time,squeeze(B15C_050.sAT(4,1,:))*1e6,'LineWidth',2)
plot(time,squeeze(B15C_075.sAT(4,1,:))*1e6,'LineWidth',2)
plot(time,squeeze(B15C_100.sAT(4,1,:))*1e6,'LineWidth',2)
plot(time,squeeze(B15C_125.sAT(4,1,:))*1e6,'LineWidth',2)
plot(time,squeeze(B15C_150.sAT(4,1,:))*1e6,'LineWidth',2)

xlabel('Year')
ylabel('Atmospheric CO2 (ppm)')
xlim([time(1) time(80)])
legend('q*0.25','q*0.50', 'q*0.75','q*1.00', 'q*1.25','q*1.50','Location','best')
title('Atmospheric CO2 for B15C forcing, scaled circulation')
grid on





%plot ocean carbon / depth / time
%%

%plot sediment? 


[CorgBurial,CcarbBurial,TotalBurial] = ...
    GetSedimentCarbonBurial( ...
    'OutThilda_B15C_incr_circ_10000yr_q1.00.mat');

[min(CorgBurial) max(CorgBurial)]
[min(CcarbBurial) max(CcarbBurial)]


load('OutThilda_B15C_incr_circ_10000yr_q1.00.mat','st')

CumCorg = cumtrapz(st,CorgBurial);
CumCarb = cumtrapz(st,CcarbBurial);

CumTotal = cumtrapz(st,TotalBurial);
disp(CumTotal)

%plot
figure
plot(st+1765,CorgBurial,'LineWidth',1.5)
hold on
plot(st+1765,CcarbBurial,'LineWidth',1.5)
plot(st+1765,TotalBurial,'LineWidth',1.5)

xlabel('Year')
ylabel('Carbon burial (GtC yr^{-1})')
legend('Organic C','CaCO_3-C','Total C')
grid on

%%

%%

%% PLOT: inspecting where carbon is stored: 
%carbon redistribution relative to q0
% Preallocate
OceanC_all    = zeros(nq,nt);
CumBurial_all = zeros(nq,nt);
TempLL_all    = zeros(nq,nt);
TempHL_all    = zeros(nq,nt);

for iq = 1:nq

    filename = sprintf( ...
        'OutThilda_B15C_incr_circ_10000yr_q%.2f.mat',qmult(iq));

    %Ocean carbon
    OceanC_all(iq,:) = GetOceanCarbonUptake(filename);

    %Sediment carbon burial
    [CorgBurial,CcarbBurial,TotalBurial] = ...
        GetSedimentCarbonBurial(filename);

    TotalBurial = -TotalBurial;
    CumBurial_all(iq,:) = cumtrapz(st,TotalBurial);

    %Surface ocean temperature
    S = load(filename,'sLL','sHL');

    TempLL_all(iq,:) = squeeze(S.sLL(1,1,:));
    TempHL_all(iq,:) = squeeze(S.sHL(1,1,:));

end

iref = find(qmult == 1);

DeltaOcean  = OceanC_all - OceanC_all(iref,:);
DeltaBurial = CumBurial_all - CumBurial_all(iref,:);

DeltaTempLL = TempLL_all - TempLL_all(iref,:);
DeltaTempHL = TempHL_all - TempHL_all(iref,:);

%plotting 
figure
tiledlayout(2,3)

for iq = 1:nq

    nexttile

    %LEFT AXIS: carbon
    yyaxis left
    hold on

    h1 = plot(year,DeltaOcean(iq,:), ...
        'LineWidth',1.5);

    h2 = plot(year,-DeltaBurial(iq,:), ...
        '--','LineWidth',1.5);

    yline(0,'k:')

    ylabel('\Delta C (GtC)')

    %RIGHT AXIS: SST anomaly ( temperature)
    yyaxis right
    hold on

    h3 = plot(year,DeltaTempLL(iq,:), ...
        ':','LineWidth',1.5);

    h4 = plot(year,DeltaTempHL(iq,:), ...
        '-.','LineWidth',1.5);

    ylabel('\Delta T (^{\circ}C)')

    %labels
    xlabel('Year')

    title(sprintf('$q/q_0 = %.2f$',qmult(iq)), ...
        'Interpreter','latex')

    grid on

       %place the legend
    if iq == 4
        legend([h1 h2 h3 h4], ...
            '\Delta C_{ocean}', ...
            '-\Delta C_{burial}', ...
            '\Delta T_{LL}', ...
            '\Delta T_{HL}', ...
            'Location','southwest')
    end

end

sgtitle('Ocean carbon, sediment burial and SST anomalies relative to q_0')

%% Outputting data for report tables: 
%% DATA FOR TABLE 1

qmult = [0.25 0.50 0.75 1.00 1.25 1.50];
nq = length(qmult);

% Desired times after initialization
target_t = [335 1000 5000 10000];

% Preallocate
OCU_table = zeros(nq,length(target_t));
DeltaOCU_10k = zeros(nq,1);
CumBurial_10k = zeros(nq,1);

for iq = 1:nq

    filename = sprintf( ...
        'OutThilda_B15C_incr_circ_10000yr_q%.2f.mat',qmult(iq));

    S = load(filename,'st');

    % Ocean carbon uptake relative to 1765
    OCU = GetOceanCarbonUptake(filename);

    % Find nearest saved timestep to requested times
    for it = 1:length(target_t)
        [~,idx] = min(abs(S.st-target_t(it)));
        OCU_table(iq,it) = OCU(idx);
    end

    % Sediment burial
    [~,~,TotalBurial] = GetSedimentCarbonBurial(filename);

    % Make positive = burial
    TotalBurial = -TotalBurial;

    % Cumulative burial [GtC]
    CumBurial = cumtrapz(S.st,TotalBurial);
    CumBurial_10k(iq) = CumBurial(end);

end

% q0 reference
iref = find(qmult == 1);

DeltaOCU_10k = OCU_table(:,end) - OCU_table(iref,end);

DeltaBurial_10k = ...
    CumBurial_10k - CumBurial_10k(iref);

% Display
Table1 = table(qmult', ...
    OCU_table(:,1), ...
    OCU_table(:,2), ...
    OCU_table(:,3), ...
    OCU_table(:,4), ...
    DeltaOCU_10k, ...
    DeltaBurial_10k, ...
    'VariableNames', ...
    {'q_q0','OCU_335yr','OCU_1kyr','OCU_5kyr','OCU_10kyr', ...
     'DeltaOCU_10k','DeltaBurial_10k'});

disp(Table1)
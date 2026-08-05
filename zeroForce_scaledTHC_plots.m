%%% Zero forcing and scaled circulations

%created july 2026
%examines how circulation sans anthropogenic forcing influences carbon
%variables


%% load 
Zero_025 = load('OutThilda_Zero_incr_circ_10000yr_q0.25.mat');
Zero_050 = load('OutThilda_Zero_incr_circ_10000yr_q0.50.mat');
Zero_075 = load('OutThilda_Zero_incr_circ_10000yr_q0.75.mat');
Zero_100 = load('OutThilda_Zero_incr_circ_10000yr_q1.00.mat');
Zero_125 = load('OutThilda_Zero_incr_circ_10000yr_q1.25.mat');
Zero_150 = load('OutThilda_Zero_incr_circ_10000yr_q1.50.mat');
time = Zero_025.st+1765;

%plot ocean carbon
Zero_025_Ocean_Carbon  = GetOceanCarbonUptake('OutThilda_Zero_incr_circ_10000yr_q0.25.mat');
Zero_050_Ocean_Carbon  = GetOceanCarbonUptake('OutThilda_Zero_incr_circ_10000yr_q0.50.mat');
Zero_075_Ocean_Carbon  = GetOceanCarbonUptake('OutThilda_Zero_incr_circ_10000yr_q0.75.mat');
Zero_100_Ocean_Carbon  = GetOceanCarbonUptake('OutThilda_Zero_incr_circ_10000yr_q1.00.mat');
Zero_125_Ocean_Carbon  = GetOceanCarbonUptake('OutThilda_Zero_incr_circ_10000yr_q1.25.mat');
Zero_150_Ocean_Carbon  = GetOceanCarbonUptake('OutThilda_Zero_incr_circ_10000yr_q1.50.mat');


figure 
plot(time,Zero_025_Ocean_Carbon,'LineWidth',2)
hold on
plot(time,Zero_050_Ocean_Carbon,'LineWidth',2)
plot(time,Zero_075_Ocean_Carbon,'LineWidth',2)
plot(time,Zero_100_Ocean_Carbon,'LineWidth',2)
plot(time,Zero_125_Ocean_Carbon,'LineWidth',2)
plot(time,Zero_150_Ocean_Carbon,'LineWidth',2)

xlabel('Year')
ylabel('Oceanic carbon uptake (GtC)')
xlim([time(1) time(end)])
legend('q*0.25','q*0.50', 'q*0.75','q*1.00', 'q*1.25','q*1.50','Location','best')
title('Zero forcing: Oceanic carbon uptake relative to 1765')
grid on

%shown  ocean carbon for shorter timescale: 
figure 
plot(time,Zero_025_Ocean_Carbon,'LineWidth',2)
hold on
plot(time,Zero_050_Ocean_Carbon,'LineWidth',2)
plot(time,Zero_075_Ocean_Carbon,'LineWidth',2)
plot(time,Zero_100_Ocean_Carbon,'LineWidth',2)
plot(time,Zero_125_Ocean_Carbon,'LineWidth',2)
plot(time,Zero_150_Ocean_Carbon,'LineWidth',2)

xlabel('Year')
ylabel('Oceanic carbon uptake (GtC)')
xlim([time(1) time(140)])
legend('q*0.25','q*0.50', 'q*0.75','q*1.00', 'q*1.25','q*1.50','Location','best')
title('Zero forcing: Oceanic carbon uptake relative to 1765')
grid on

% oceanic carbon uptake relative to reference circulation q0
figure 
plot(time,Zero_025_Ocean_Carbon-Zero_100_Ocean_Carbon,'LineWidth',2)
hold on
plot(time,Zero_050_Ocean_Carbon-Zero_100_Ocean_Carbon,'LineWidth',2)
plot(time,Zero_075_Ocean_Carbon-Zero_100_Ocean_Carbon,'LineWidth',2)
plot(time,Zero_100_Ocean_Carbon-Zero_100_Ocean_Carbon,'LineWidth',2)
plot(time,Zero_125_Ocean_Carbon-Zero_100_Ocean_Carbon,'LineWidth',2)
plot(time,Zero_150_Ocean_Carbon-Zero_100_Ocean_Carbon,'LineWidth',2)

xlabel('Year')
ylabel('Oceanic carbon uptake anomaly (GtC)')
xlim([time(1) time(end)])
legend('q*0.25','q*0.50', 'q*0.75','q*1.00', 'q*1.25','q*1.50','Location','best')
title('Zero forcing: Oceanic carbon uptake anomaly relative to 1765')
grid on



%plot atmospheric co2
figure 
plot(time,squeeze(Zero_025.sAT(4,1,:))*1e6,'LineWidth',2)
hold on
plot(time,squeeze(Zero_050.sAT(4,1,:))*1e6,'LineWidth',2)
plot(time,squeeze(Zero_075.sAT(4,1,:))*1e6,'LineWidth',2)
plot(time,squeeze(Zero_100.sAT(4,1,:))*1e6,'LineWidth',2)
plot(time,squeeze(Zero_125.sAT(4,1,:))*1e6,'LineWidth',2)
plot(time,squeeze(Zero_150.sAT(4,1,:))*1e6,'LineWidth',2)

xlabel('Year')
ylabel('Atmospheric CO2 (ppm)')
xlim([time(1) time(end)])
legend('q*0.25','q*0.50', 'q*0.75','q*1.00', 'q*1.25','q*1.50','Location','best')
title('Atmospheric CO2 for zero forcing, scaled circulation')
grid on


%atm CO2 for shorter time
figure 
plot(time,squeeze(Zero_025.sAT(4,1,:))*1e6,'LineWidth',2)
hold on
plot(time,squeeze(Zero_050.sAT(4,1,:))*1e6,'LineWidth',2)
plot(time,squeeze(Zero_075.sAT(4,1,:))*1e6,'LineWidth',2)
plot(time,squeeze(Zero_100.sAT(4,1,:))*1e6,'LineWidth',2)
plot(time,squeeze(Zero_125.sAT(4,1,:))*1e6,'LineWidth',2)
plot(time,squeeze(Zero_150.sAT(4,1,:))*1e6,'LineWidth',2)

xlabel('Year')
ylabel('Atmospheric CO2 (ppm)')
xlim([time(1) time(80)])
legend('q*0.25','q*0.50', 'q*0.75','q*1.00', 'q*1.25','q*1.50','Location','best')
title('Atmospheric CO2 for zero forcing, scaled circulation')
grid on





%plot ocean carbon / depth / time
%%

%plot sediment? 


[CorgBurial,CcarbBurial,TotalBurial] = ...
    GetSedimentCarbonBurial( ...
    'OutThilda_Zero_incr_circ_10000yr_q1.00.mat');

[min(CorgBurial) max(CorgBurial)]
[min(CcarbBurial) max(CcarbBurial)]


load('OutThilda_Zero_incr_circ_10000yr_q1.00.mat','st')

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
qmult = [0.25 0.50 0.75 1.00 1.25 1.50];
nq = length(qmult);
nt = length(st);
year = st + 1765;
OceanC_all    = zeros(nq,nt);
CumBurial_all = zeros(nq,nt);
TempLL_all    = zeros(nq,nt);
TempHL_all    = zeros(nq,nt);

for iq = 1:nq

    filename = sprintf( ...
        'OutThilda_Zero_incr_circ_10000yr_q%.2f.mat',qmult(iq));

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

iref = find(qmult == 1); %ref is when unscaled

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

sgtitle('Zero forcing: Ocean carbon, sediment burial and SST anomalies relative to q_0')

%% CODE NEEDS PROOFREADING: Outputting data for report tables: 
%%DATA FOR TABLE 1

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
        'OutThilda_Zero_incr_circ_10000yr_q%.2f.mat',qmult(iq));

    S = load(filename,'st');

    % Ocean carbon uptake relative to 1765
    OCU = GetOceanCarbonUptake(filename);

    % Find nearest saved timestep to requested times
    for it = 1:length(target_t)
        [~,idx] = min(abs(S.st-target_t(it)));
        OCU_table(iq,it) = OCU(idx);
    end

    % Sediment burial
    [~,~,TotalBurial] = GetSedimentCarbonBurial(filename); %tildes bc we ignore
    %corg and carb and only keep total

    %Make positive = burial
    TotalBurial = -TotalBurial;

    %Cumulative burial in GtC
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

%% plot for linearity indication: 
q = [0.25 0.50 0.75 1.00 1.25 1.50];

OCU_335 = [-60 -45 -30 -16 -2 11];
OCU_1k  = [-45 -35 -28 -22 -18 -16];
OCU_5k  = [128 88 43 -8 -66 -126];
OCU_10k = [257 186 108 22 -75 -173];

% Put data together
OCU = [OCU_335;
       OCU_1k;
       OCU_5k;
       OCU_10k];

labels = {'335 yr','1 kyr','5 kyr','10 kyr'};

figure
hold on

for i = 1:4

    % Linear fit
    p = polyfit(q,OCU(i,:),1);
    yfit = polyval(p,q);

    % R^2
    SSres = sum((OCU(i,:) - yfit).^2);
    SStot = sum((OCU(i,:) - mean(OCU(i,:))).^2);

    R2 = 1 - SSres/SStot;

    % Plot data
    c = plot(q,OCU(i,:),'o', ...
    'MarkerSize',7, ...
    'LineWidth',1.5, ...
    'DisplayName',sprintf('%s, R^2 = %.3f',labels{i},R2));

plot(q,yfit,'--', ...
    'LineWidth',1.5, ...
    'Color',c.Color,...
    'HandleVisibility','off');

end

xlabel('q/q_0')
ylabel('Ocean carbon uptake (GtC)')
legend('Location','best')
title('Ocean Carbon Uptake as a function of circulation strength')
grid on


%% data for table 2
%% Data for carbon distribution table

qmult = [0.25 0.50 0.75 1.00 1.25 1.50];
nq = length(qmult);

ParVal_R
global dm d n

% Model layer depths
depth = [dm dm+d*(1:n-1)];

% Define depth ranges
idx_surface = depth <= 200;
idx_intermediate = depth > 200 & depth <= 2000;
idx_deep = depth > 2000;

% Preallocate final carbon inventories
C_LL = zeros(nq,n);
C_HL = zeros(nq,n);
pCO2 = zeros(nq,1);


%% Load each simulation

for iq = 1:nq

    filename = sprintf( ...
        'OutThilda_Zero_incr_circ_10000yr_q%.2f.mat',qmult(iq));

    % Carbon change by layer relative to 1765
    [CarbonLL,CarbonHL] = GetOceanCarbonByLayer(filename);

    % Take final timestep (10 kyr)
    C_LL(iq,:) = CarbonLL(:,end)';
    C_HL(iq,:) = CarbonHL(:,end)';

    % Atmospheric CO2 at 10 kyr
    S = load(filename,'sAT');
    pCO2(iq) = S.sAT(4,1,end)*1e6;  % atm -> ppm

end


%% Convert to anomalies relative to q0

iref = find(qmult == 1);

DeltaLL = C_LL - C_LL(iref,:);
DeltaHL = C_HL - C_HL(iref,:);

Delta_pCO2 = pCO2 - pCO2(iref);


%% Vertical distribution

% GtC anomaly in each depth interval
C_surface = ...
    sum(DeltaLL(:,idx_surface),2) + ...
    sum(DeltaHL(:,idx_surface),2);

C_intermediate = ...
    sum(DeltaLL(:,idx_intermediate),2) + ...
    sum(DeltaHL(:,idx_intermediate),2);

C_deep = ...
    sum(DeltaLL(:,idx_deep),2) + ...
    sum(DeltaHL(:,idx_deep),2);

% Total ocean carbon anomaly
C_total = C_surface + C_intermediate + C_deep;

% Convert to percentages
f_surface = 100*C_surface./C_total;
f_intermediate = 100*C_intermediate./C_total;
f_deep = 100*C_deep./C_total;


%% Latitudinal distribution

C_LL_total = sum(DeltaLL,2);
C_HL_total = sum(DeltaHL,2);

f_LL = 100*C_LL_total./C_total;
f_HL = 100*C_HL_total./C_total;


%% q/q0 = 1 has no anomaly relative to itself

f_surface(iref) = NaN;
f_intermediate(iref) = NaN;
f_deep(iref) = NaN;
f_LL(iref) = NaN;
f_HL(iref) = NaN;


%% Create table

T = table( ...
    qmult', ...
    f_surface, ...
    f_intermediate, ...
    f_deep, ...
    f_LL, ...
    f_HL, ...
    Delta_pCO2, ...
    'VariableNames', ...
    {'q_q0','Surface_pct','Intermediate_pct','Deep_pct', ...
     'LL_pct','HL_pct','Delta_pCO2_ppm'});

disp(T)
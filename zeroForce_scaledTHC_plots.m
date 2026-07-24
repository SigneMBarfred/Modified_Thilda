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

%% inspecting where carbon is stored: 
%carbon redistribution relative to q0
% Preallocate
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



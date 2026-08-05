%plots and calculations for zero force dynamic circulation
%created july 2026



%% Zero forcing - dynamic circulation

Dyn = load('OutThilda_ZeroForce_dynamicCirc_10000yr.mat');

year = Dyn.st + 1765;

% Initial circulation = reference circulation
q0 = Dyn.sqmax(1);

% Normalised circulation
qnorm = Dyn.sqmax ./ q0;


figure

plot(year,qnorm,'LineWidth',2)
yline(1,'k--')

xlabel('Year')
ylabel('q/q_0')
title('Dynamic ocean circulation under zero forcing')
grid on
xlim([year(1) year(end)])

% Surface values
T_LL = squeeze(Dyn.sLL(1,1,:));
T_HL = squeeze(Dyn.sHL(1,1,:));

S_LL = squeeze(Dyn.sLL(2,1,:));
S_HL = squeeze(Dyn.sHL(2,1,:));

% HL - LL gradients
DeltaT = T_HL - T_LL;
DeltaS = S_HL - S_LL;

DeltaT_anom = DeltaT - DeltaT(1);
DeltaS_anom = DeltaS - DeltaS(1);

figure
tiledlayout(3,1)

% Circulation
nexttile
plot(year,qnorm,'LineWidth',2)
yline(1,'k:')
ylabel('q/q_0')
grid on
xlim([year(1) year(end)])

% Temperature contrast
nexttile
plot(year,DeltaT_anom,'LineWidth',2)
yline(0,'k:')
ylabel('\Delta(T_{HL}-T_{LL}) (^{\circ}C)')
grid on
xlim([year(1) year(end)])

% Salinity contrast
nexttile
plot(year,DeltaS_anom,'LineWidth',2)
yline(0,'k:')
ylabel('\Delta(S_{HL}-S_{LL})')
xlabel('Year')
grid on
xlim([year(1) year(end)])

sgtitle('Drivers of dynamic ocean circulation with zero forcing')

C_dyn = GetOceanCarbonUptake( ...
    'OutThilda_ZeroForce_dynamicCirc_10000yr.mat');

C_ref = GetOceanCarbonUptake( ...
    'OutThilda_Zero_incr_circ_10000yr_q1.00.mat');

DeltaC_dyn = C_dyn - C_ref;

figure

plot(year,DeltaC_dyn,'LineWidth',2)
yline(0,'k:')

xlabel('Year')
ylabel('\Delta C_{ocean} (GtC)')
title('Ocean carbon anomaly for dynamic circulation')
grid on
xlim([year(1) year(end)])


[~,~,Burial_dyn] = ...
    GetSedimentCarbonBurial( ...
    'OutThilda_ZeroForce_dynamicCirc_10000yr.mat');

[~,~,Burial_ref] = ...
    GetSedimentCarbonBurial( ...
    'OutThilda_Zero_incr_circ_10000yr_q1.00.mat');

% Your burial function uses negative downward flux
Burial_dyn = -Burial_dyn;
Burial_ref = -Burial_ref;

% Cumulative burial
CumBurial_dyn = cumtrapz(Dyn.st,Burial_dyn);
CumBurial_ref = cumtrapz(Dyn.st,Burial_ref);

DeltaBurial_dyn = CumBurial_dyn - CumBurial_ref;


figure
hold on

plot(year,DeltaC_dyn, ...
    'LineWidth',2)

plot(year,-DeltaBurial_dyn, ...
    '--','LineWidth',2)

yline(0,'k:')

xlabel('Year')
ylabel('\Delta C (GtC)')

legend('\Delta C_{ocean}', ...
       '-\Delta C_{burial}', ...
       'Location','best')

title('Carbon response to dynamic circulation with zero forcing')
grid on
xlim([year(1) year(end)])



% Circulation extrema
[qmin,imin] = min(qnorm);
[qmax,imax] = max(qnorm);

year_qmin = year(imin);
year_qmax = year(imax);

% Final anomalies
DeltaC_final = DeltaC_dyn(end);
DeltaBurial_final = DeltaBurial_dyn(end);

% Atmospheric CO2 anomaly
Ref = load( ...
    'OutThilda_Zero_incr_circ_10000yr_q1.00.mat','sAT');

pCO2_dyn = squeeze(Dyn.sAT(4,1,:))*1e6;
pCO2_ref = squeeze(Ref.sAT(4,1,:))*1e6;

Delta_pCO2 = pCO2_dyn - pCO2_ref;

fprintf('Initial q/q0:          %.4f\n',qnorm(1))
fprintf('Minimum q/q0:          %.4f at year %.0f\n',qmin,year_qmin)
fprintf('Maximum q/q0:          %.4f at year %.0f\n',qmax,year_qmax)
fprintf('Final q/q0:            %.4f\n',qnorm(end))
fprintf('Final Delta Ocean C:   %.2f GtC\n',DeltaC_final)
fprintf('Final Delta Burial:    %.2f GtC\n',DeltaBurial_final)
fprintf('Final Delta pCO2:      %.4f ppm\n',Delta_pCO2(end))
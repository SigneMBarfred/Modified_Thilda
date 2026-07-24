%extracting data from 
% https://github.com/chrisroadmap/cmip7-scenariomip/blob/main/data/continuous_emissions_timeseries_1750_2500.csv
%which contains pathway data pertaining to the CMIP7
%script saves it in txt file
function [years,CO2_fossil,CO2_land,CH4] = GetScenario(T,model,scenario,pathway)

years = 1750:2500;
yearNames = "x" + string(years) + "_0";

rows = strcmp(T.model,model) & strcmp(T.scenario,scenario); %logical index
%that is 1 for the relevant model + scenario


S = T(rows,:); %new dataframe containing data for spec. pathway&model



%%
CO2_fossil = S{strcmp(S.variable,...
    "Emissions|CO2|Energy and Industrial Processes"),yearNames}; %extracts 
% variable column and string compares. takes the row where
% Emissions|CO2|Energy and Industrial Processes is and extracts year
% columns

CO2_land = S{strcmp(S.variable,...
    "Emissions|CO2|AFOLU"),yearNames};

CH4 = S{strcmp(S.variable,...
    "Emissions|CH4"),yearNames};
% 
% %% temp diagnostics sect
% 
% GrossPositive = S{strcmp(S.variable,...
%     "Emissions|CO2|Gross Positive Emissions"), yearNames};
% 
% GrossRemovals = S{strcmp(S.variable,...
%     "Emissions|CO2|Gross Removals"), yearNames};
% 
% Net1 = CO2_fossil + CO2_land;
% Net2 = GrossPositive + GrossRemovals;   % GrossRemovals is already negative
% 
% 
% figure
% plot(years, Net1, 'b', 'LineWidth', 2); hold on
% plot(years, Net2, '--r', 'LineWidth', 2);
% 
% legend('Energy & Industry + AFOLU', ...
%        'Gross Positive + Gross Removals', ...
%        'Location','best')
% 
% xlabel('Year')
% ylabel('MtCO_2 yr^{-1}')
% title(['Emission comparison: ' pathway])
% grid on
% 
% Difference = Net1 - Net2;
% 
% fprintf('Maximum absolute difference = %.2f MtCO2/yr\n', ...
%     max(abs(Difference)));
% 
% fprintf('Mean absolute difference = %.2f MtCO2/yr\n', ...
%     mean(abs(Difference)));
% 
% %%







 %convert from MtCO2 to MtC to match 
% how RCES scenario files where formatted
CO2_fossil = CO2_fossil * 12/44;
CO2_land   = CO2_land   * 12/44;

%it stores CH4 in methane mass, so we will keep that as in the csv file

%%save as txt files
filename = "CO2fosem_" + pathway + ".txt";
writematrix(CO2_fossil(:), filename, 'Delimiter','tab');

filename = "CO2landem_" + pathway + ".txt";
writematrix(CO2_land(:), filename, 'Delimiter','tab');

filename = "CH4em_" + pathway + ".txt";
writematrix(CH4(:), filename, 'Delimiter','tab');
end
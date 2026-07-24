%extracting data from 
% https://github.com/chrisroadmap/cmip7-scenariomip/blob/main/data/continuous_emissions_timeseries_1750_2500.csv
%which contains pathway data pertaining to the CMIP7
%script saves it in txt file
function [years,CO2_fossil,CO2_land,CH4] = GetScenario(T,model,scenario,pathway)

years = 1750:2500;
yearNames = string(years);

rows = strcmp(T.model,model) & strcmp(T.scenario,scenario); %logical index
%that is 1 for the relevant model + scenario


S = T(rows,:); %new dataframe containing data for spec. pathway&model

CO2_fossil = S{strcmp(S.variable,...
    "Emissions|CO2|Energy and Industrial Processes"),yearNames}; %extracts 
% variable column and string compares. takes the row where
% Emissions|CO2|Energy and Industrial Processes is and extracts year
% columns

CO2_land = S{strcmp(S.variable,...
    "Emissions|CO2|AFOLU"),yearNames};

CH4 = S{strcmp(S.variable,...
    "Emissions|CH4"),yearNames};

%%save as txt files
writematrix([years' CO2_fossil'], ...
    ['CO2fosem_' pathway '.txt'], ...
    'Delimiter','tab');

writematrix([years' CO2_land'], ...
    ['CO2landem_' pathway '.txt'], ...
    'Delimiter','tab');

writematrix([years' CH4'], ...
    ['CH4em_' pathway '.txt'], ...
    'Delimiter','tab');

end
%script that produces OutThilda files for varied strengths of overturning
%circulation based on bouyancy
%added july 2026
%adjust time duration in Thilda_R

global aLL

ParVal_R


fprintf('Running NEW! dynamic circulation simulation\n')

Thilda_R

movefile('OutThilda_R.mat', ...
    'OutThilda_SSP1_3C_Hyst_dynamicCirc_ver2_10000yr.mat')



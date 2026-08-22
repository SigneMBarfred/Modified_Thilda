%creating forcing files for the hysteresis test 
%For the CMIP7 scenarios, dynamic circulation (version 2)

%created august 2026

load CO2fosem_SSP1.txt
load CO2landem_SSP1.txt
load CH4em_SSP1.txt
load NonGHG_SSP1.txt

%create forcing files where there is a mirrored removal of GHG
%note: removal of CH4 might be unphysical? decays after 10s of yrs...
%BUT we do the same for all the carbon forcings for consistency's sake
%also bc 
CO2fosem_Hyst  = [CO2fosem_SSP1;  -1*flipud(CO2fosem_SSP1)];
CO2landem_Hyst = [CO2landem_SSP1; -1*flipud(CO2landem_SSP1)];
CH4em_Hyst = [CH4em_SSP1; -1*flipud(CH4em_SSP1)]; 
NonGHG_hyst = [NonGHG_SSP1; flipud(NonGHG_SSP1)]; %return to PI

%export them as new forcing txt files:
writematrix(CO2fosem_Hyst,'CO2fosem_SSP1_hyst.txt');
writematrix(CO2landem_Hyst,'CO2landem_SSP1_hyst.txt');
writematrix(CH4em_Hyst,'CH4em_SSP1_hyst.txt');
writematrix(NonGHG_hyst,'NonGHG_SSP1_hyst.txt');
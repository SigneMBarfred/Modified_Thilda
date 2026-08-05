%creating forcing files for the hysteresis test 
%For the CMIP7 scenarios, dynamic circulation (version 2)

%created august 2026

load CO2fosem_SSP3.txt
load CO2landem_SSP3.txt
load CH4em_SSP3.txt
load NonGHG_SSP3.txt

%create forcing files where there is a mirrored removal of GHG
%note: removal of CH4 might be unphysical? decays after 10s of yrs...
%thus it is set to be of same length but later half is zeroes
CO2fosem_Hyst  = [CO2fosem_SSP3;  -1*flipud(CO2fosem_SSP3)];
CO2landem_Hyst = [CO2landem_SSP3; -1*flipud(CO2landem_SSP3)];
CH4em_Hyst = [CH4em_SSP3; zeros(size(CH4em_SSP3))]; %0 after 2500
NonGHG_hyst = [NonGHG_SSP3; flipud(NonGHG_SSP3)]; %return to PI

%export them as new forcing txt files:
writematrix(CO2fosem_Hyst,'CO2fosem_SSP3_hyst.txt');
writematrix(CO2landem_Hyst,'CO2landem_SSP3_hyst.txt');
writematrix(CH4em_Hyst,'CH4em_SSP3_hyst.txt');
writematrix(NonGHG_hyst,'NonGHG_SSP3_hyst.txt');
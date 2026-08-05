%forcing file for the high emission ssp3 (CMIP7)
%hysteresis test
%created august 2026

function [daint,MHC,MHA,MHM,LWR,co2emfos,co2emland,ch4em,co2seq1,co2seq2]=Force_SSP3_hyst(h)

load NonGHG_SSP3_hyst.txt
load CO2fosem_SSP3_hyst.txt
load CO2landem_SSP3_hyst.txt
load CH4em_SSP3_hyst.txt

daint      = interp1(NonGHG_SSP3_hyst,1:h:1502);
co2emfos   = interp1(CO2fosem_SSP3_hyst,1:h:1502);
co2emland  = interp1(CO2landem_SSP3_hyst,1:h:1502);
ch4em      = interp1(CH4em_SSP3_hyst,1:h:1502);


co2seq1 = zeros(size(co2emfos));
co2seq2 = zeros(size(co2emfos));

LWR = [211.13 1.93];         %Clim. Sens. = 3C with LWR = [211.83 1.93] 


%post 2500, the idealised CO2, CH4 and aerosol parametrisation is disabled
%dummy parameters are constructed, so the file is still compliant with the
%model
MHC = zeros(1,9);
MHA = zeros(1,3);
MHM = zeros(1,3);
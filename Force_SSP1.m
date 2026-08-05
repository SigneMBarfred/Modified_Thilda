%forcing file for the low emission ssp1 (REMIND MAgPIE for CMIP7)
%created july 2026, edited from 5CS to 3CS aug 2026

function [daint,MHC,MHA,MHM,LWR,co2emfos,co2emland,ch4em,co2seq1,co2seq2]=Force_SSP1(h)

load NonGHG_SSP1.txt
load CO2fosem_SSP1.txt
load CO2landem_SSP1.txt
load CH4em_SSP1.txt

daint      = interp1(NonGHG_SSP1,1:h:751);
co2emfos   = interp1(CO2fosem_SSP1,1:h:751);
co2emland  = interp1(CO2landem_SSP1,1:h:751);
ch4em      = interp1(CH4em_SSP1,1:h:751);


co2seq1 = zeros(size(co2emfos));
co2seq2 = zeros(size(co2emfos));

LWR = [211.13 1.93];         %Clim. Sens. = 3C with LWR = [211.83 1.93] 


%post 2500, the idealised CO2, CH4 and aerosol parametrisation is disabled
%dummy parameters are constructed, so the file is still compliant with the
%model
MHC = zeros(1,9);
MHA = zeros(1,3);
MHM = zeros(1,3);
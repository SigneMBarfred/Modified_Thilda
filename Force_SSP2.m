%forcing file for the medium emission ssp2 (IMAGE for CMIP7)
%created july 2026, edited aug 2026 from 5C CS to 3C CS

function [daint,MHC,MHA,MHM,LWR,co2emfos,co2emland,ch4em,co2seq1,co2seq2]=Force_SSP2(h)

load NonGHG_SSP3.txt %adapted from the A2 nonGHG file
load CO2fosem_SSP2.txt
load CO2landem_SSP2.txt
load CH4em_SSP2.txt

daint      = interp1(NonGHG_SSP3,1:h:751);
co2emfos   = interp1(CO2fosem_SSP2,1:h:751);
co2emland  = interp1(CO2landem_SSP2,1:h:751);
ch4em      = interp1(CH4em_SSP2,1:h:751);


co2seq1 = zeros(size(co2emfos));
co2seq2 = zeros(size(co2emfos));

LWR = [211.13 1.93];         %Clim. Sens. = 3C with LWR = [211.83 1.93]

%post 2500, the idealised CO2, CH4 and aerosol parametrisation is disabled
%dummy parameters are constructed, so the file is still compliant with the
%model
MHC = zeros(1,9);
MHA = zeros(1,3);
MHM = zeros(1,3);
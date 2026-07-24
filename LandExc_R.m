function [al]=LandExc_R(AT,LB)

% Calculates Land Biomass changes and land-sea gas exchanges of CO_2 and CH_4
% Input : 
%         AT    -  Atmospheric tracers, see ODE_R.m for the data structure.
%         LB    -  Land Biomasses 
%
% Output: 
%         al(1) - increment change in leafy biomass 12C (GtC/s)
%         al(2) - increment change in woody biomass 12C (GtC/s)
%         al(3) - increment change in litter biomass 12C (GtC/s)
%         al(4) - increment change in soil biomass 12C (GtC/s)
%         al(5) - land air exchange of DIC [mol/s]  
%         al(6) - land air exchange of CH4-C [mol/s]  
%         al(7) - N20 production [mol/s]

% Activate global parameters
global sy fdiv Q10 CO2fer mgt rVa Q10met Htem pCH4int pN2Oint pCO2int mdts 

%-------------
% four box Land biosphere model derived from Siegenthaler and Oeschger (1987), includes CO2 fertilisation
% effect, and bacterial respiration in litter and soil as a functions of
% global mean temperature. Biomasses refer to one hemisphere.
% The CO2 fertilization factor, CO2fer, taken from a fit to the results of
% Friedlingstein et al (2006), Journal of Climate

pCO2=AT(4,1); 

Gro = 50;                                                           %Pre-Industrial(PI) leafy biomass, GtC
Woo = 250;                                                          %PI woody biomass, GtC
Lio = 60;                                                           %PI litter biomass, GtC
Slo = 750;                                                          %PI soil biomass, GtC
LBtoto = Gro+Woo+Lio+Slo;

NPPLo = 30;                                                         %PI primary production on land,  GtC/yr
LBMPo = pCH4int/(rVa*mgt*mdts);                                     %PI land biosphere methane production, GtC/yr minus 1/2"PA",
                                                                    % anthropogenic input
N2OPo = pN2Oint/(rVa*150*sy);                                       %PI N2O production, mol/s 

ATem = AT(1,1)*sin(fdiv)+AT(1,2)*(1-sin(fdiv));                     %Mean atmospheric temperature
       
AGr = (35/60)*NPPLo/Gro;                                           %decay rate for leafy biomass, GtC/yr
AWo = (25/60)*NPPLo/Woo;                                           %decay rate for woody biomass, GtC/yr 
ALi = ((55/60)*NPPLo/Lio)*Q10^((ATem-Htem)/10);                    %decay rate for litter biomass with Q10 T dependence, GtC/yr  
ASl = ((15/60)*NPPLo-(LBMPo))/Slo*Q10^((ATem-Htem)/10);            %decay rate for soil biomass with Q10 T dependence, GtC/yr  

NPPL = NPPLo*...
          (1+CO2fer*log(pCO2/pCO2int));                      
LBMP = LBMPo*LB(4,1)/Slo*Q10met^((ATem-Htem)/10);                  % land biosphere methane production with Q10 T dependence
N2OP = N2OPo*LB(4,1)/Slo*Q10^((ATem-Htem)/10);                     % N2O production 

al(1) = ((35/60)*NPPL - AGr*LB(1,1))/sy;                            % 12C rate of change for leafy biomass, GtC/s
al(2) = ((25/60)*NPPL - AWo*LB(2,1))/sy;                            % 12C rate of change for wood, Gt/s
al(3) = (AGr*LB(1,1) + (20/25)*AWo*LB(2,1) - ALi*LB(3,1))/sy;       % 12C rate of change for litter, GtC/s
al(4) = ((10/55)*ALi*LB(3,1) + (5/25)*AWo*LB(2,1)...
         - ASl*LB(4,1)-LBMP)/sy;                                    % 12C rate of change for soil, GtC/s
al(5) = (-NPPL + (45/55)*ALi*LB(3,1) + ASl*LB(4,1))*mgt/sy;         %pCO2-12C sink/source to atmosphere from changes in LB, mol/s
al(6) = LBMP*mgt/sy;                                                %CH4-12C source to atmosphere
al(7) = N2OP;                                                       %N2O source to atmosphere 

return


function [RcarLL,RcarHL,RorgLL,RorgHL,Wcarb,Wsil,Worg]=...
    ExtForce_R(AT)

% Calculates external inputs to atmosphere and ocean
% Input : 
%         AT    -  Atmospheric tracers, see ODE.m for the data structure.
%         
% Output: 
%         Rcar - River input of carbonate carbon (mol/s)
%         Rorg - River input of inorganic phosphorus (mol/s)
%         Wcarb - weathering of carbonate rock (mol/s)
%         Wsil - weathering of silicate rock
%         Worg - weathering of old organic carbon in rocks

%         All the above outputs with Q10 dependency on mean atmospheric
%         temperature


global fdiv Q10 BCarbPA BCorgPA RPPA Volo swf Htem              % Get parameter values


ATem = AT(1,1)*sin(fdiv)+AT(1,2)*(1-sin(fdiv));                 %Mean atmospheric temperature
       
RcarLL = 0.80*(BCarbPA)*exp(0.1*log(Q10)*(ATem-Htem));                       
RcarHL = 0.20*(BCarbPA)*exp(0.1*log(Q10)*(ATem-Htem));          %HL river inout of C, Q10 T dependency 

RorgLL = 0.80*(RPPA)*exp(0.1*log(Q10)*(ATem-Htem));
RorgHL = 0.20*(RPPA)*exp(0.1*log(Q10)*(ATem-Htem));

Wcarb = (BCarbPA)/(1+swf)*exp(0.1*log(Q10)*(ATem-Htem)); 
Wsil  = swf*Wcarb; 
Worg  = ((BCorgPA)+swf*(BCarbPA)/(1+swf)-Volo)*exp(0.1*log(Q10)*(ATem-Htem));%

return

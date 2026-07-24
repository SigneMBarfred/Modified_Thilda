function [mpr,mdr] = AtmMet_R(t,MH,AT)

% Input : t - time
%         At - atmospheric tracers

%Output : mpr(1) - anthropogenic input of methane (for use after 2100 AD)
%         mdr(1) - methane oxydation to CO2 in the atmosphere ,  mol/sec

global sy rVa mdts mgt

pCH4o =  0.72e-6;                    %Pre-industrial (PI) methane concentration
pCH4  =  AT(2,1);
M     = (pCH4-pCH4o)/pCH4o;
                                             
RCH4o   =  1/(rVa*mdts*sy);          %PI decay rate for methane, residence time 8.4 yrs
RCH4    =  RCH4o*(1-0.96*M/(M+6.6)); %non-linear decay law for CH4, approximate fit
                                     %to Schmidt & Shindell (2003), Paleoceanography       
% original: 
% if (t/sy>=MH(1))
%     MRR  =  (mgt*MH(2)*(t/sy-MH(1))^4*exp(-MH(3)*(t/sy-MH(1))))/sy; 
% 
% else
%     MRR =0;
% end
%mpr(1) = MRR;

%edit july 2026: No artificial methane release after the prescribed SSP forcing
mpr(1) = 0;

mdr(1) =  pCH4*RCH4;                       

return



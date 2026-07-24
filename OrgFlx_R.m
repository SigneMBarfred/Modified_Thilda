function [sr] = OrgFlx_R(LH,AT,Ao,Lf,CO2,GA,pCal,pOrg,Rcar,Rorg)

% Calculates tracer sources for one sector due to 
% POM and CaCO_3 production in the euphotic zone, 
% remineralization and dissolution at depth, 
% nitrogen fixation, nitrate reduction and sulphate 
% reduction. Sinks are defined negative.   
% 
% Input : LH  -  Low or High latitude vertical tracer distribution
%                see ODE.m for the data structure.
%         AT -Atmospheric tracer concentrations
%         Ao  - Ocean surface area [m2]
%         Lf  - Limitation factor for new production [-]
%               (eg. light/iron limitation, unity means no limitation)
%         CO2 - surface ocean CO2 concentration [mol/m3] 
%         GA  - Ocean area at depth relative to surface
%         pCal- Percentage of Calcite dissolution in the sediment
%         pOrg- percentage of organic matter remineralization in the sediment
%         Rcar- river input of carbonate carbon (see ExtForce_R.m)
%         Rorg- river input of inorganic phosphorus (see ExtForce_R.m)
%        
% Output: sr -  Vertical distribution of total tracer sources 
%               sr(1;:)   - temperature
%               sr(2,:)   - salinity
%               sr(3,:)   - phosphate [mol P/s]   
%               sr(4,:)   - DIC [mol DIC/s]   
%               sr(5,:)   - alkalinity [eq/s]   
%               sr(6,:)   - oxygen [mol O_2/s]   


% Activate global paramter values
ParVal_R
global d dm n sy rcp rcop rno rcd rda rca lmdcar lmdorg lmdcorg  

%-------

% Nondimensional flux profiles of carbonate and organic POM 
% at the lower level of model layers
%-------
RMcar  =  exp(-lmdcar* ( ( dm:d:n*d )-dm));
RMorg  =  exp(-lmdorg* ( ( dm:d:n*d )-dm));   
RMcorg =  exp(-lmdcorg*( ( dm:d:n*d )-dm)); 

%-------


% New production of organic matter (euphotic zone phosphate uptake)
%-------
bpe   = 1/sy;                                       % Bio-Production Efficiency [s-1]
Phlf  = 1e-6;                                       % Half-saturation constant [molP/m3] 
NP   = bpe*Lf*dm*LH(3,1)^2/(Phlf+LH(3,1));          % [mol P/m2 s]

%-------

% Production ratio 'rp' ("Rain ratio"),see Maier-Reimer (1993), GBC
%-------
rpm = 0.36;                                        
Tr  = 10;                                           % [oC] Reference temperatur
p1  = 1;                                            
p2  = 0.18;                                         
rp1  = rpm* p1*exp(p2*(LH(1,1)-Tr))/(1+p1*exp(p2*(LH(1,1)-Tr)));  % [-]
rp  = max(rp1,0.001);

% Set RM to the divergence of the flux profile for each layer
% Account for bathymetri (GA [0-1]) and apply 
% dissolution/remineralization percentages from the 
% sediment model
%-------
% [mol P/s]

RMorg  = Ao*NP*       ...
     [-RMcorg(1) (RMorg(1:n-2)-RMorg(2:n-1)).*GA(2:n-1)+...
               RMorg(1:n-2).*(GA(1:n-2)-GA(2:n-1)).*pOrg(1:n-2) ...
               (RMorg(n-1)-RMorg(n)).*GA(n)+...
               RMorg(n-1)*(GA(n-1)-GA(n))*pOrg(n-1)+...
               RMorg(n)*GA(n)*pOrg(n)];   % [mol P/s]
           
RMcorg  = Ao*NP*       ...
  [-RMcorg(1) (RMcorg(1:n-2)-RMcorg(2:n-1)).*GA(2:n-1)+...
               RMcorg(1:n-2).*(GA(1:n-2)-GA(2:n-1)).*pOrg(1:n-2) ...
               (RMcorg(n-1)-RMcorg(n)).*GA(n)+...
               RMcorg(n-1)*(GA(n-1)-GA(n))*pOrg(n-1)+...
               RMcorg(n)*GA(n)*pOrg(n)];
  
% [mol Carbonate/s]

RMcar  = Ao*NP*rcp*rp*...
    [-RMcar(1) (RMcar(1:n-2)-RMcar(2:n-1)).*GA(2:n-1)+...
               RMcar(1:n-2).*(GA(1:n-2)-GA(2:n-1)).*pCal(1:n-2) ...
               (RMcar(n-1)-RMcar(n)).*GA(n)+...
               RMcar(n-1)*(GA(n-1)-GA(n))*pCal(n-1)+...
               RMcar(n)*GA(n)*pCal(n)];
%-------


% Calculate/combine interior source terms
%-------
sr(3,:) = RMorg;                                        % [mol P/s]
sr(3,1) = sr(3,1) + Rorg;                               % [mol P/s]

sr(4,:) = (RMcorg*rcp + RMcar*rcd);                     % [mol C/s]
sr(4,1) = sr(4,1) + 2*Rcar;                             % [mol C/s]


sr(5,:) = RMorg*rda + RMcar*rca;                        % [eq/s]
sr(5,1) = sr(5,1) + 2*Rcar + Rorg*rda;                  % [eq/s]


sr(6,:) = (RMorg*rno+RMcorg*rcop);                      % [mol O2/s]
sr(6,1) = RMorg(1)*(rno+rcop);                          % [mol O2/s]

%-------

return

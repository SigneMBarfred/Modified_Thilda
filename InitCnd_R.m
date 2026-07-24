function [LL,HL,AT,LB,GS,LLCO3,HLCO3,LLCO3s,HLCO3s,pCalLL,pCalHL,pOrgLL,pOrgHL dwpCalLL dwpCalHL...
    fimLL fimHL dwpCalssLL dwpCalssHL dwpOrgLL dwpOrgssLL dwpOrgHL dwpOrgssHL wsedLL wsedHL ]=InitCnd_R

ParVal_R; % Activate and define global parameters

global nto sim n So R13pdb R14oas aHL aLL NCFLL NCFHL CAFLL CAFHL Pint
global DICint ALKint pCO2int pCH4int pN2Oint

% Set initial ocean tracer values for low- (LL.*) and high-latitude (HL.*)
%modified 1/12/2006
%----- 

LL(1,:)  = ones(n,1)'*16;                       % Temperature [oC]
HL(1,:)  = ones(n,1)'*2; 
LL(2,:)  = ones(n,1)'*So;                       % Salinity []
HL(2,:)  = ones(n,1)'*So; 
LL(3,:)  = ones(n,1)'*Pint;                  % P [mol/m3], st. val 2.11e-3
HL(3,:)  = ones(n,1)'*Pint; 
LL(4,:)  = ones(n,1)'*DICint;                   % DIC [mol/m3], s.v. 2.327 
HL(4,:)  = ones(n,1)'*DICint; 
LL(5,:)  = ones(n,1)'*ALKint;                   % Alkalinity [eq/m3], s.v 2.443
HL(5,:)  = ones(n,1)'*ALKint;                  
LL(6,:)  = ones(n,1)'*0.20;                    % Oxygen [mol/m3]
HL(6,:)  = ones(n,1)'*0.30;                 


% Set initial atmospheric partial pressures of carbon dioxide and oxygen  
%-----
AT(1,:)  = [18.3 0];                               % Atmopsheric temperatures                        
AT(2,:)  = pCH4int;                                % Atmospheric pCH4 [atm], st. val. 0.7e-6
AT(3,:)  = pN2Oint;                                % Atmospheric pN2O [ppbv], st. val. 0.27e-6 
AT(4,:)  = pCO2int;                                % Atmospheric pCO_2 [atm], St val 280e-6
AT(5,:)  = 0.21;                                   % Atmospheric pO_2 [atm]           
%-----

% Set initial Land Biomasses  
%-----
LB(1,:)  = 50;                                % Leafy Biomass 12C (GtC)
LB(2,:)  = 250;                               % Woody Biomass 12C (GtC)
LB(3,:)  = 60;                                % Litter Biomass 12C (GtC)
LB(4,:)  = 750;                               % Soil Biomass 12C,  (GtC)                         

GS(1,:) = 0;

% Get ocean area at depth used in OrgFlx
%-----
global GAw GAc dm d n

load Globalarea.txt
GAw=interp1(Globalarea(1:23,1),Globalarea(1:23,14),[dm dm+d*(1:n-1)]);
GAc=interp1(Globalarea(24:46,1),Globalarea(24:46,14),[dm dm+d*(1:n-1)]);
GAw=GAw./GAw(1);                        
GAc=GAc./GAc(1);


[LLCO3,LLCO3s,HpLL]=CarSysPres_R(LL);
[HLCO3,HLCO3s,HpLL]=CarSysPres_R(HL);

pCalLL=0;pCalHL=0;pOrgLL=0;pOrgHL=0;

%Optional, load restart file
%-----
load ResThilda_R
%load ResThildaH3CStandNew
%----

return

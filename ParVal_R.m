function ParVal_R
global qmax %added july 2026
global nto
nto     = 6;                         %number of ocean tracers

% Useful constants
global  sy rc mgt
%-----
sy      =  31536000;	              % Seconds per year [s/yr] 
rc      =  4.186e6;	                  % Scaled heat capacity [J/m3/K]  
mgt     =  8.326e13;                  % Moles C per GtC
%-----

% Geometry
global  dm d n dv olf r aH fdiv fland aHL aLL Lxf Lyf
%-----
dm      =  100;                           % Surface  layer thickness [m]
d       =  100;                           % Interior layer thickness [m]
n       =  55;                            % Total number of layers [-]
dv      =  [dm d*ones(1,n-1)];            % Vector of layer thichnesses [m]
olf     =  270/360;                       % Ocean to land fraction [-]
r       =  6.371e6;	                      % Earth Radius [m]
aH      =  2*pi*r^2;                      % Hemispheric area [m2]
fdiv    =  52*pi/180;                     % High - low latitude division [rad], st. val 52
fland   =  70*pi/180;                     % High latitude poleward ocean limit  
aHL     =  olf*aH*(sin(fland)-sin(fdiv)); % High latitude ocean area [m2]
aLL     =  olf*aH*sin(fdiv);	          % Low latutude ocean area [m2]
                                          % Note: olf, fdiv and HL and LL ocean surface areas
                                          % adjusted slightly to give internal agreement. 
Lxf     =  2*pi*r*olf*cos(fdiv);          % Zonal ocean length scale at fdiv [m]
Lyf     =  0.5*r;                         % Meridional ocean length scale at fdiv [m]
%-----


% pCO2 parameters
global rVa Avg kwo 
%-----
rVa     =  1/(1.733e20/2);            % Inverse atmospheric volume (one hemisphere) meassure [atm/mol]  
Avg     =  6.024e23;                  % Avogadro number [atoms/mol]
kwo     =  4.72e-5;                   % piston velocity for gas exchange [m/s],equivalent to 16.99 cm/hr.
                                      % Calculated as in Wanninkhof(1992)with mean wind speed of 6.6 m/s,
                                      % See Shaffer et al (2008)
%-----


% Redfield atomic ratios, remineralization scales and new production 
global rcp rno rcop rnp rcd rda rca LfLL LfHL lmdcar lmdorg lmdcorg 
%-----
rcp     =  106;                       % Carbon to phosphate, organic matter [-]
rno     =  -32;                       % Oxygen to nitrogen, organic matter [-],    
rcop    = -118;                       % C+H to phosphate, organic matter [-], 
rnp     =  16;                        % Nitrate to phosphate, organic matter [-]
rcd     =  1;                         % Carbonate to DIC [-]
rca     =  2;                         % Carbonate to ALK [-]
rda     = -16;                        % DIC to ALK [-]
lmdcar  = 1/3000;                     %water column dissolution scale for CaCO3 , st. val. 2000 [m^-1]
lmdorg  = 1/750;                      %water column remineralization scale for P, st. val 780 [m-1]
lmdcorg = 1/1050;                     %water column remineralization scale for Org C, st. val 1000 [m-1]
LfLL    =  1;                         % Limitation factor for new production, low lat. [-], st. val 1
LfHL    =  0.36;                      % Limitation factor for new production, high lat. [-]

% Atmosphere   
global Tseaice Tsnow weLL weHL pCO2int pCH4int pN2Oint Htem mdts
%-----
Tseaice = -5;                         % Fixed ice line temperature,  st. val. -5
Tsnow   = 0;                          % Fixed snow line temperature, st. val.  0 
weLL    =  5;                         % Atmospheric heat capacity (water equivalent) [m]
weHL    =  20;                        % Atmospheric heat capacity (water equivalent) [m]
pCO2int = 278e-6;                     % Inital mean atmposhere pCO2
pCH4int = 0.72e-6;                    % Initial mean atmospheric CH4
pN2Oint = 0.27e-6;                    % Initial mean atmospheric N2O
Htem = 15.0;                          % Initial atmosphere temperature
mdts  = 6.9;                          % Initial methane decay time scale (yr) 

% Ocean
global So Cao 
%-----
So      =  34.7;                      % Mean reference salinity []
Cao     =  0.01028;                   % Ocean mean calcium concentration 

% Land Biosphere
global Q10 CO2fer Q10met 

Q10      = 2;                       % Q10 for soil = litter respiration rate, st. val 2.0
Q10met   = 2;                       % Q10 for terrestrial methane release, st. val 2.0  
CO2fer   = 0.65;                    % Value based on C4MIP results, Friedlingstein et al 2006, JC)

%Sediment model
global kcalcite NCFLL NCFHL CAFLL CAFHL Mca rhom rhoc Moc compc

Mca   = 100;               % Molar weight of CaCO3 (40+12+16x3) [g/mol]
rhom  = 2.7;               % Density of mineral fraction in sediments [g/cm3]

rhoc  = 1.1;               %density if organic fraction in sediments [g/cm3]
Moc   = 12;                %Molar weight of C
compc = 2.7;               %total organic to org C ration in organic matter [g/g]

kcalcite   = 0.0015;       % CaCO3 dissolution rate coefficient,
NCFLL  = 0.3;              % Open ocean, non-Calcite flux to sediment,Low Lat.
NCFHL  = 0.3;              % Open ocean, non-Calcite flux to sediment,High Lat.

CAFLL  = 20;               %Amplification factor for NCF at the "coast", Low Lat.
CAFHL  = 20;               %Amplification factor for NCF at the "coast", High Lat.

% External inputs
global BCarbPA BCorgPA RCarbC13 RCorgC13 RVolC13 RPPA swf Volo 

swf      =   0.85;             %Silicate weathering fraction, st. val 0.15
RPPA     =   0.83168e3;        % Pre-Anthropogenic river input of P, based on -sum(RMorg), see Orgfix_R
BCarbPA  =   2.6522e5;         %PI burial of carbonate C, based on -sum(RMcar),see OrgFlx, mol/s
BCorgPA  =   0.95988e5;        % PI burial of organic C, based on -sum(RMorg)
RCarbC13 =   0.0011522;        % assumed delta C13 of carbonate C, calculated from burial 
RCorgC13 =  -0.023168;         % "    "     "    "   of organic C, calculated from burial  
RVolC13  =  -0.005;            % "     "    "    "   volcanic CO2 entering the atmosphere, st.val.-5 per mil 
Volo     =  swf*BCarbPA/(1+swf)*(RCarbC13-RCorgC13)/(RVolC13-RCorgC13);
                               %initial volcanic input of CO2, calculated from mass and 13C conservation
return

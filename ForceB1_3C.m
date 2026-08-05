function [daint,MHC,MHA,MHM,LWR,co2emfos,co2emland,ch4em,co2seq1,co2seq2]=ForceB1_3C(h)

load NonGHG_B1img.txt
load CO2fosem_B1img_GCB2024.txt
load CO2landem_B1img_GCB2024.txt
load CH4em_B1img_GMB2021.txt

daint = interp1(NonGHG_B1img,1:h:336); 
co2emfos=interp1(CO2fosem_B1img_GCB2024,1:h:336); 
co2emland = interp1(CO2landem_B1img_GCB2024, 1:h:336);
ch4em = interp1(CH4em_B1img_GMB2021, 1:h:336); 
co2seq1 = zeros(1,336/h);  
co2seq2 = zeros(1,336/h); 

% Control parameters for setting long wave outgoing radiation

LWR = [211.13 1.93];         %Clim. Sens. = 3C with LWR = [211.83 1.93]

% Control parameters for calculating CO2 release after 2100 AD
% and sequestration characteristics, if applicable
%--------------------------------------------

CO2totB1 = 147.3; 
geofrac = 1;      
frac   = 0.9;  
tCO2B1   = 275;
tfrac  = 100;  
[A,B]  = InitRel_R(CO2totB1,frac,tfrac);
[C,D] =  InitRel_R(CO2totB1,frac,tfrac);
fgeo=0;               %fractional escape factor for geological stored CO2,
                       % 1e-4 means 1% escape over 100 years
fact=0;              %fact = 1 for leakage to the ocean of CO2 sequestered
                     %in the ocean bed, otherwise fact = 0
MHC     = [geofrac tCO2B1 tCO2B1 A B C D fgeo fact];

%--------------------------------------------
% Control parameters for calculating aerosol forcing after 2100
%--------------------------------------------

Aerotot = -1.976;  
frac   = 0.9;  
tAero   = 280;              
tfrac  = 100;  
[A,B]  = InitRel_R(Aerotot,frac,tfrac);
MHA     = [tAero A B];
%--------------------------------------------

% Control parameters for calculating methane release after 2100
%--------------------------------------------
CH4tot = 4.83;  % Total methane forcing [GtC]
frac   = 0.9;  % Fraction of CH4tot that occurs by an amount of time 
                % (tfrac) after initial release (at time tCH4)
tCH4   = 280;   % see above  [yr], st. val. 500             
tfrac  = 100;  % see above  [yr], st. val. 3500
[A,B]  = InitRel_R(CH4tot,frac,tfrac);
MHM     = [tCH4 A B];
%--------------------------------------------


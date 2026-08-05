function [daint,MHC,MHA,MHM,LWR,co2emfos,co2emland,ch4em,co2seq1,co2seq2]=ForceA2_5C(h)

load NonGHG_A2asf_HA.txt
load CO2fosem_A2asf_GCB2024.txt
load CO2landem_A2asf_GCB2024.txt
load CH4em_A2asf_GMB2021.txt

daint = interp1(NonGHG_A2asf_HA,1:h:336); 
co2emfos=interp1(CO2fosem_A2asf_GCB2024,1:h:336); 
co2emland = interp1(CO2landem_A2asf_GCB2024, 1:h:336);
ch4em = interp1(CH4em_A2asf_GMB2021, 1:h:336); 
co2seq1 = zeros(1,336/h);  
co2seq2 = zeros(1,336/h); 

% Control parameters for setting long wave outgoing radiation

LWR = [218.91 1.37];         %Clim. Sens. = 4.8C with LWR = [218.91 1.37]

% Control parameters for calculating CO2 release after 2100 AD
% and sequestration characteristics, if applicable
%--------------------------------------------

CO2totA2 = 962.7; 
geofrac = 1;      %fraction sequested to geological formations
frac   = 0.9;  
tCO2   = 280;   
tCO2A2   = 292;
tfrac  = 100;  
[A,B]  = InitRel_R(CO2totA2,frac,tfrac);
[C,D] =  InitRel_R(CO2totA2,frac,tfrac);
fgeo=0;               %fractional escape factor for geological stored CO2,
                       % 1e-4 means 1% escape over 100 years
fact=0;              %fact = 1 for leakage to the ocean of CO2 sequestered
                     %in the ocean bed, otherwise fact = 0
MHC     = [geofrac tCO2A2 tCO2A2 A B C D fgeo fact];

%--------------------------------------------

% Control parameters for modified aerosol forcing after 2100, modified to give 
% observed global warming for enhanced climate sensitivity
%--------------------------------------------

Aerotot = -17.92;  
frac   = 0.9;  
tAero   = 265;           
tfrac  = 100;  
[A,B]  = InitRel_R(Aerotot,frac,tfrac);
MHA     = [tAero A B];

%--------------------------------------------
% Control parameters for calculating anthropogenic methane release after 2100
%--------------------------------------------
CH4tot = 20.692;  
frac   = 0.9;  
tCH4   = 290;           
tfrac  = 100;  
[A,B]  = InitRel_R(CH4tot,frac,tfrac);
MHM     = [tCH4 A B];
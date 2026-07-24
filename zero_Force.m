%zero forcing file
%created june 2026
%purpose: to be used to show how circulation affects model output when
%disregarding anthropogenic forcings.

function [daint,MHC,MHA,MHM,LWR,co2emfos,co2emland,ch4em,co2seq1,co2seq2]=zero_Force(h)

daint = zeros(1,336/h); %time series of external, radiative forcing(mainly areosols)
co2emfos = zeros(1,336/h);
co2emland = zeros(1,336/h);
ch4em = zeros(1,336/h);
co2seq1 = zeros(1,336/h);  
co2seq2 = zeros(1,336/h); 

% Control parameters for setting long wave outgoing radiation

LWR = [218.91 1.37];         %Clim. Sens. = 4.8C with LWR = [218.91 1.37]

% Control parameters for calculating CO2 release after 2100 AD
% and sequestration characteristics, if applicable
%--------------------------------------------

CO2totZero = 0; 
geofrac = 1;      %fraction sequested to geological formations
frac   = 0.9;  
tCO2   = 280;   
tCO2Zero   = 292; %timesale for release - as 0 is released, this should just be non-zero
tfrac  = 100;  
[A,B]  = InitRel_R(CO2totZero,frac,tfrac);
fprintf('A = %g, B = %g\n', A, B) %sanity check
[C,D] =  InitRel_R(CO2totZero,frac,tfrac);
fgeo=0;               %fractional escape factor for geological stored CO2,
                       % 1e-4 means 1% escape over 100 years
fact=0;              %fact = 1 for leakage to the ocean of CO2 sequestered
                     %in the ocean bed, otherwise fact = 0
MHC     = [geofrac tCO2Zero tCO2Zero A B C D fgeo fact];

%--------------------------------------------

% Control parameters for modified aerosol forcing after 2100, modified to give 
% observed global warming for enhanced climate sensitivity
%--------------------------------------------

Aerotot = 0;  
frac   = 0.9;  
tAero   = 265;           
tfrac  = 100;  
[A,B]  = InitRel_R(Aerotot,frac,tfrac);
MHA     = [tAero A B];

%--------------------------------------------
% Control parameters for calculating anthropogenic methane release after 2100
%--------------------------------------------
CH4tot = 0;  
frac   = 0.9;  
tCH4   = 290;           
tfrac  = 100;  
[A,B]  = InitRel_R(CH4tot,frac,tfrac);
MHM     = [tCH4 A B];
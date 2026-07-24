function [as,CO2]=GasExc_R(LH,AT,Ao)

% Calculates the air-sea gas exchange of CO_2 and O_2 for a single zone
% Input : LH    -  Low or High latitude vertical tracer distribution
%                  see ODE.m for the data structure.
%         AT    -  Atmospheric tracers, see ODE.m for the data structure.
%         Ao    - ocean surface area [m2]
%
% Output: as(4) - air sea exchange of DIC [mol/s]  
%         as(5) - air sea exchange of O2 [mol/s] 
%         CO2   - surface ocean CO2 concentration  [mol/m3] 

% Activate global parameters
global kwo 

%-------
% Iterate Carbonate system for pCO2 - partial pressure of surface CO2, 
% and K0 - solubility of CO2 
[pCO2w,K0,CO2,CO3,HCO3]=CarSys_R(LH(1,1),LH(2,1),LH(4,1),LH(5,1));
%-------

%-------------
% Gas exchange coefficient kw (m/s), formulated as in Wanninkhof (1992) from with
%the square of the mean wind speed and a temperature dependent Schmidt number for CO2. 
%The value for kwo includes the wind dependence for a mean wind speed of 6.6 m/s,
%see Shaffer et al (2008).
Sc   = 2073.1-125.62*LH(1,1)+3.6276*LH(1,1)^2-0.043219*LH(1,1)^3; % T in oC
Kw   = kwo*(Sc/660)^.5;

% Air sea C02 exchange
as(4) = Ao*Kw*K0*(AT(4,1) - pCO2w ); % [mol/s]

%-------------
% Gas exchange coefficient kw (m/s), formulated as in Wanninkhof (1992) from with
%the square of the mean wind speed and a temperature dependent Schmidt number for O2 
%(Keeling et al 1998)The value for kwo includes the wind dependence for a 
%mean wind speed of 6.6 m/s,see Shaffer et al (2008).

Sc   = 1638-81.83*LH(1,1)+1.483*LH(1,1)^2-0.008004*LH(1,1)^3; % T in oC
Kw   = kwo*(Sc/660)^.5;

% Bunsen solubility coefficient for oxygen (Weiss 1970)
Tk   = LH(1,1)+273.15; % Kelvin temperature
beta = exp( -58.3877+85.8079*(100/Tk)+23.8439*log(Tk/100)+ ...
	    LH(2,1)*(-0.034892+0.015568*(Tk/100)-0.0019387*(Tk/100)^2) );
    
% Convertsion of Bunsen coefficient [atm-1] to solubility K0 [mol/m3/atm]. 
% The conversion ignores the the correction for non-ideality, ok for oxygen.
MVi  = 22.41361;         % Molar volume for an ideal gas [liter/mol]
K0   = beta/MVi*1e3;     % [mol/m3/atm]
 
% Air sea 02 exchange
as(5)= Ao*Kw*(K0*AT(5,1)-LH(6,1));  % [mol/s]
%-------------

return

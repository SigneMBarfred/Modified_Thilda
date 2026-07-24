function [QEBLL,QEBHL,QLL,QHL,aHLNI,Fw] = AtmEnerBal_R(t,ToLL,ToHL,LWR,AT,daint,mpra,k)

%Atmospheric energy balance and sea ice/snow coverage calculations

% Inputs:   time                                             - t
%           Ocean surface layer temperatures                 - ToLL,ToHL 
%           Long wave radiation parameters                   - LWR
%           Atmospheric variables                            - AT 
%           (includes temp,pCO2, pCH4 and pN2O)
%           Reconstructed and projected anthropogenic forcing
%           from aerosols and minorgreenhouse gases          - daint,mpra 

% Outputs:  Heat convergence/divergence in atmosphere boxes  - QEBLL,QEBHL
%           Air-sea heat exchange                            - QLL,QHL
%           Ice free ocean area                              - aHLNI


% Redefine

Ta=AT(1,:); 
pCO2=AT(4,1); 
pCH4=AT(2,1)*10^9;
pN2O=AT(3,1)*10^9;

% Activate global parameters
global olf aH aLL fdiv fland sy pCO2int pCH4int pN2Oint Tseaice Tsnow 

%    if t>=750*sy
%         daint(k)=0;
%    end
% if t<750*sy
%        mpra=0;
% end
%above: original

%below: july 2026 edit:
if t < 750*sy
    forcing = daint(k);
else
    forcing = 0;
end

% Local parameter values

%----------------
% Albedo, function of latitude (Hartmann 1994)
al0   =  0.7;
al2   = -0.175;
ali   =  .62;         % Albedo of ice covered area,  st. val.  0.62

% Solar radiation, function of latitude, Nakamura, J Clim 1994
Qo    =  1365;                 %[W/m2]
Q2    = -0.482;   

% Zero degree background radiation for pCO2 = 278,
% pCH4 = 720, pN2O = 270 as of 1765; 


Ao    =  LWR(1);                %[W/m2]  Clim. Sens. = 3C with Ao = 211.83

% Calculation of greenhouse forcing from changes in CO2, CH4,and N2O

ACO2  = 5.35*log(pCO2/pCO2int);      

pCH4int = pCH4int*10^9;
pN2Oint = pN2Oint*10^9;

ACH4  = 0.036*(pCH4^(.5)-pCH4int^(.5))-...
    [0.47*log(1+2.01e-5*(pCH4*pN2Oint)^(.75)+5.31e-15*pCH4*(pCH4*pN2Oint)^(1.52))...
    - 0.47*log(1+2.01e-5*( pCH4int*pN2Oint)^(.75)+5.31e-15* pCH4int*( pCH4int*pN2Oint)^(1.52))];  

AN2O  = 0.14*(pN2O^(.5)- pN2Oint^(.5))-...
     [0.47*log(1+2.01e-5*(pCH4int*pN2O)^(.75)+5.31e-15* pCH4int*(pCH4int*pN2O)^(1.52))...
      - 0.47*log(1+2.01e-5*(pCH4int* pN2Oint)^(.75)+5.31e-15* pCH4int*(pCH4int* pN2Oint)^(1.52))];  

pCH4int = pCH4int*10^-9;
pN2Oint = pN2Oint*10^-9;

% Zero degree background radiation for variable pCO2, pCH4, pN2O, aerosols and minor greenhouse gases 
Atot  =  Ao -ACO2 - ACH4 - AN2O - forcing - mpra;        %  [W/m2]

% Sensitivity of LW radiation to temperature

B     =  LWR(2);         % [W/m2/K], Clim. Sens. = 3C with B = 1.93

% Atmospheric transport calculations

Lv    =  2.25e6*1e3;  % Latent heat of vaporization [J/1000kg] = [J/m^3]   
Cfw   =  1.1*10e9;        % Atmospheric exchange coefficient for water, st. val 10e9    
Cs    =  1.237*2.5e11;      % Atmospheric exchange coefficient for sensible heat, st.val2.5e11     
N     =  2.5;         % Gradient exponent

% Haney coefficient
lambda= 30;           % [W/m2/oC] 

% Direct solar heating of ocean surface, LL only 
Dheat = 30;           % [W/m2] 
%----------------

%Establish the atmospheric temperature profile, 2.order legendre pol. in 
% sine of lat, Ta(lat) = PTa(1) + .5*PTa(2) * ( 3*sin(lat)^2 -1 )
% Coefficients are calculated so that the area weighted mean of the profile
% matches the surface mean temperatures in each sector.
%----------------

CTa(1,:) = [ 1 .5*(sin(fdiv)^2-1)                   ];
CTa(2,:) = [ 1 .5*(sin(fdiv)-sin(fdiv)^3)/(1-sin(fdiv)) ];
RTa      = [ Ta(1) Ta(2)]';
PTa      = CTa\RTa;

%----------------
% Sea-Ice
%----------------

% Calculate the latitude fi where Ta(fseaice) =Tseaice & Ta(fsnow)   =Tsnow 
  fseaice  = min(fland , asin((2/(3*PTa(2))*(Tseaice -PTa(1)+PTa(2)/2))^(.5)) );
  fsnow    = min(pi/2-.001 , asin((2/(3*PTa(2))*(Tsnow-PTa(1)+PTa(2)/2))^(.5)) );
  fmax     = max(fsnow , fseaice); % Used for albedo calculations
  
%----------------

% Calculate mean temperature of the high latitude atmosphere over ice free ocean
%----------------
THNI  =  1/(sin(fseaice)-sin(fdiv))*...
         [(PTa(1)-PTa(2)*.5)*(sin(fseaice)-sin(fdiv))+...
         0.5*PTa(2)*(sin(fseaice)^3-sin(fdiv)^3 )];

% Calculate ice free ocean area 
%----------------
aHLNI = olf*aH*(sin(fseaice)-sin(fdiv)); 

% Air sea heat exchange, positive upwards
%----------------
QLL   = (lambda*(ToLL-Ta(1))-Dheat); % [W/m2]
QHL   =  lambda*(ToHL-THNI);         % [W/m2]

% Meridional temperature gradient at latitude = fdiv
%----------------
PTay  = 3*PTa(2)*sin(fdiv)*cos(fdiv);

% Temperature at latitude = fdiv
%----------------
PTad  = PTa(1) + PTa(2)*.5*(3*sin(fdiv).^2-1);

% Integrated mean incomming shortwave radiation for the low latitude sector 
%----------------
Aw    = 1/sin(fdiv)*Qo/4 * [ ...
         (al0-.5*al2)*(1-.5*Q2)*sin(fdiv) + ...
         .5*(Q2*(al0-.5*al2)+al2*(1-.5*Q2))*sin(fdiv)^3 + ...
         9/20*al2*Q2*sin(fdiv)^5 ];      %[W/m2]
% Subtract zero degree outgoing longwave radiation 
Aw    = Aw-Atot;                         %[W/m2]   

% Integrated mean incomming radiation for the high latitude sector, north of fd, 
% including icecover north of fseaice of fixed albedo ali. 
%----------------
Ac1 = (al0-.5*al2)*(1-.5*Q2) - (1-ali)*(1-.5*Q2);
Ac2 = .5*(Q2*(al0-.5*al2)+al2*(1-.5*Q2)) - (1-ali)*Q2*.5;
Ac3 = 9/20*al2*Q2;
Ac4 = -(al0-.5*al2)*(1-.5*Q2)*sin(fdiv) ...
      -.5*(Q2*(al0-.5*al2)+al2*(1-.5*Q2))*sin(fdiv)^3 ...
      - 9/20*al2*Q2*sin(fdiv)^5 ...
      +(1-ali)*(1-.5*Q2) + (1-ali)*Q2*.5;
% 'Ocean zone' (to pole): albedo changes at fmax
Aco = 1/(1-sin(fdiv))*Qo/4*...
      ( sin(fmax )*Ac1 + sin(fmax )^3*Ac2 + sin(fmax )^5*Ac3 + Ac4 );
% Land zone (to pole): albedo changes at fsnow
Acl = 1/(1-sin(fdiv))*Qo/4*...
      ( sin(fsnow)*Ac1 + sin(fsnow)^3*Ac2 + sin(fsnow)^5*Ac3 + Ac4 );
% Combine the two estimates
Ac  = Aco*olf+Acl*(1-olf) - Atot;

% Atmospheric freshwater flux into the cold sector
%----------------
Fw    = Cfw * exp(-5420/(PTad+273))*abs(PTay)^N;    %[m3/s]

% Atmospheric energy transport
%----------------
Hash  = Cs * abs(PTay)^N;         % sensible heat [W]
Halh  = Lv*Fw;                    % latent heat [W]
Ha    = Hash + Halh;              % sensible + latent [W]

%----------------
% Heat convergence/divergence
%----------------
QEBLL = -Ha + QLL*aLL   + (Aw - B*Ta(1))*aH*sin(fdiv)     ; %[W]
QEBHL =  Ha + QHL*aHLNI + (Ac - B*Ta(2))*aH*(1-sin(fdiv)) ; %[W]
%----------------

return

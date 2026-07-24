% function [q,wLL,wHL,kvLL,kvHL,kh] = OceExc_R(HL);
% %july 2026: code changed to account for feedback in between
% %salinity/temperatur and overturning
% 
% 
% % Output
% %          q         - Horizontal exchange between layers, posetive poleward [m3/s]
% %          wLL/wHL   - Vertical exchange between layers, posetive upwards [m3/s] 
% %          kvLL/kvHL - Vertical diffusion [m2/s]
% %          kh        - Horizontal diffusion [m2/s]
% 
% % Activate global parameters
% global n aLL T0 S0 qmax
% 
% %equation of state coefficients
% alpha = 2e-4;    % Thermal expansion coefficient (1/deg C)
% beta  = 8e-4;    % Haline contraction coefficient (1/psu)
% lambda  = 100; %tuning parameter, ie how strongly qmax repsonds to changes
% 
% % Ocean overturning, poleward in the surface layers 
% % and equatorward at the ocean bottom - zero in between.
% %qmax  =  aLL*1.8e-8; %original input: aLL*1.8e-8; but now assigned as global   
% 
% T = HL(1,1); %surface temp
% S = HL(2,1); %surface salinity
% 
% 
% DeltaT = T - T0; 
% DeltaS = S - S0;
% 
% q0 = aLL*1.8e-8; %baseline circulation of 18 Sv 
% qmax = q0*(1 + lambda*(-alpha*DeltaT + beta*DeltaS)); %letting circulation be function of both temp and salinity
% qmax = max(0,qmax); %prevent negative ie a reversed circulation
% %disp(qmax/q0) %sanity check, should be 1 in beginning
% 
% q(1)  =  qmax;      
% q(n)  = -qmax;
% 
% % Upwelling/downwelling given by continuity, zero at the ocean bottom
% wLL(n:-1:1) =  [0 -cumsum(q(n:-1:2))]; 
% wHL(n:-1:1) =  [0  cumsum(q(n:-1:2))]; 
% 
% % kv given at layer interfaces 
% kvLL(1:n-1) = 2e-5.*(1+5.5*(1-exp(-100*(1:n-1)/4000)));    
% kvHL(1:n-1) = 230e-5;                                     
% 
% % Horizontal diffusion
% kh   =  1.65e3;                         
% 
% end



%% Code where circulation is a factor (original)

function [q,wLL,wHL,kvLL,kvHL,kh] = OceExc_R;

% Output
%          q         - Horizontal exchange between layers, posetive poleward [m3/s]
%          wLL/wHL   - Vertical exchange between layers, posetive upwards [m3/s] 
%          kvLL/kvHL - Vertical diffusion [m2/s]
%          kh        - Horizontal diffusion [m2/s]

% Activate global parameters
global n aLL qmax

% Ocean overturning, poleward in the surface layers 
% and equatorward at the ocean bottom - zero in between.
%qmax  =  aLL*1.8e-8; %original input: aLL*1.8e-8; but now assigned as global                   
q(1)  =  qmax;      
q(n)  = -qmax;

% Upwelling/downwelling given by continuity, zero at the ocean bottom
wLL(n:-1:1) =  [0 -cumsum(q(n:-1:2))]; 
wHL(n:-1:1) =  [0  cumsum(q(n:-1:2))]; 

% kv given at layer interfaces 
kvLL(1:n-1) = 2e-5.*(1+5.5*(1-exp(-100*(1:n-1)/4000)));    
kvHL(1:n-1) = 230e-5;                                     

% Horizontal diffusion
kh   =  1.65e3;                         

return

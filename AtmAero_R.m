% function [mpra] = AtmAero_R(t,MH)
% 
% % Input : t - time
% %         
% % Output: mpra -  atmosphere aerosol forcing,W/m2 
% 
% global sy  
% 
% if (t/sy>=MH(1))
%     mpra  =  (MH(2)*(t/sy-MH(1))^4*exp(-MH(3)*(t/sy-MH(1)))); 
% 
% else
%     mpra =0;
% end
% 
% return
% above: original function

%below: edit from july 2026


function [mpra] = AtmAero_R(t,MH)

% Aerosol forcing is only directly through the SSP forcing file.
% No additional idealized aerosol forcing is applied after

mpra = 0;

return

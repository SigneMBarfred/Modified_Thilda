% function [mpr] = AtmCO2_R(t,MH)
% 
% % Input : t - time
% %         
% % Output: mpr(1) - CO2 release to atmosphere, mol/sec, AG 
% %         mpr(2) - CO2 storage to one ocean layer, mol/sec 
% %         mpr(3) - CO2 storage in geological formations
% %         mpr(4) - CO2 release to atmosphere, mol/sec, A2
% 
% global sy rVa mgt 
% 
% nlay  = 10;               % number of ocean layers receiving CO2 
% 
% if (t/sy>=MH(2))
%     MRR  =  (mgt*MH(4)*(t/sy-MH(2))^4*exp(-MH(5)*(t/sy-MH(2))))/sy; 
% 
% else
%     MRR =0;
% end
% 
%  if (t/sy>=MH(3))
%     MRRA2  =  (mgt*MH(6)*(t/sy-MH(3))^4*exp(-MH(7)*(t/sy-MH(3))))/sy; 
% 
% else
%     MRRA2 =0;
% end
% 
% delMRR = MRRA2 - MRR;
% 
% mpr(1) =  MRR;
% mpr(2) =  (1-MH(1))/nlay*delMRR;
% mpr(3) = MH(1)*delMRR;
% mpr(4) = MRRA2;
% 
% return
% 
% above is original AtmCO2

%below is the edited july 2026 :
function [mpr] = AtmCO2_R(t,MH)

% Anthropogenic CO2 emissions are now prescribed directly by SSP forcing
% files. No additional idealized post-forcing CO2 release or sequestration
% applied.

mpr = zeros(4,1);

return

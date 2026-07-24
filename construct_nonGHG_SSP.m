%extend nonGHG txt files from original DCESS model to be applicably to the
%CMIP7 SSP scenarios
%created july 2026

%need to add 15 yrs before industrialisation, ie replicate matrix x15
%need to add 400 yrs after 2100, also just extending with 2100 value


%low and medium  em SSP
load NonGHG_B1img_HA.txt

NonGHG_SSP1 = [ ...
    repmat(NonGHG_B1img_HA(1),15,1);      % 1750-1764
    NonGHG_B1img_HA;                      % 1765-2100
    repmat(NonGHG_B1img_HA(end),400,1)];  % 2101-2500

save NonGHG_SSP1.txt NonGHG_SSP1 -ascii


%high em. SSP
load NonGHG_A2asf_HA.txt

NonGHG_SSP3 = [ ...
    repmat(NonGHG_A2asf_HA(1),15,1);      % 1750-1764
    NonGHG_A2asf_HA;                      % 1765-2100
    repmat(NonGHG_A2asf_HA(end),400,1)];  % 2101-2500

save NonGHG_SSP3.txt NonGHG_SSP3 -ascii
%Code structure has been aided by GenAI (ChatGPT 4.0)
function [CorgBurial,CcarbBurial,TotalBurial] = ...
    GetSedimentCarbonBurial(filename)

% Script that calculates sediment carbon burial from OutThilda file
%Meaning of variables:
% CorgBurial: organic carbon burial (GtC/yr)
% CcarbBurial: CaCO3-carbon burial (GtC/yr)
% TotalBurial: total carbon burial (GtC/yr)
%negative values mean BURIAL (removal from ocean) 
%positive signify release from sediment and into ocean

%get relevant data and values: 
load(filename)
ParVal_R
load Globalarea.txt

global dm d n sy rcp lmdcar lmdcorg aLL aHL LfLL LfHL

%Ocean characteristics
depth = [dm dm+d*(1:n-1)]; %remember: dm is surface layer thickness

%Conical water column: area is a function of depth
%for LL (warm ocean)
GAw = interp1(Globalarea(1:23,1), ...
              Globalarea(1:23,14),depth);
%for HL 
GAc = interp1(Globalarea(24:46,1), ...
              Globalarea(24:46,14),depth);

%normalise ie express relative to surf. area
GAw = GAw./GAw(1);
GAc = GAc./GAc(1);


%% Sediment
%tryin to reconstruct as per Shaffer 2008s def. of area
%diff. between levels is a measurement of: fraction of ocean area that each
%sediemnt depth segment represents

%mult. by 2 bc: 2 hemispheres
SedAreaLL = 2*aLL * ...
    [GAw(1:end-1) - GAw(2:end), GAw(end)];

SedAreaHL = 2*aHL * ...
    [GAc(1:end-1) - GAc(2:end), GAc(end)];

%Convert m^2 -> cm^2 because sediment fluxes are pr cm^2
SedAreaLL = SedAreaLL * 1e4;
SedAreaHL = SedAreaHL * 1e4;


%%troubleshooting: should be =1 if everything works
%fprintf('LL: sediment area/ocean area = %.6f\n', ...
    %sum(SedAreaLL)/(2*aLL*1e4));

%fprintf('HL: sediment area/ocean area = %.6f\n', ...
    %sum(SedAreaHL)/(2*aHL*1e4));

%constants (taken from OrgFlx_R re: new production)
bpe  = 1/sy;
Phlf = 1e-6;

M_C = 12.011;  %mass of carbon (g/mol)

%Rain ratio depends on surface temperature
%From OrgFlx_R: "Production ratio 'rp' ("Rain ratio"),see Maier-Reimer (1993), GBC"
rpm = 0.36; %CaCO3:orgC ratio
Tr  = 10; %ref temp, celcius
p1  = 1;
p2  = 0.18; %temp dependence

%what gets stored: (org and carbonate)
nt = length(st);
CorgBurial  = zeros(1,nt);
CcarbBurial = zeros(1,nt);


%%Looping through time
for it = 1:nt

    %% LL
    %Surface phosphate
    PLL = sLL(3,1,it); %controls bio prod ie orgC

    %New production (see also OrgFlx_R)
    NPLL = bpe*LfLL*dm*PLL^2/(Phlf + PLL);

    %preallocation: create arrays for flux at one of n levels
    FC_LL = zeros(1,n);
    Fcal_LL = zeros(1,n);

    %the CaCO3:orgC ratio is temp dependent, so tracer 1 (surf. temp) is
    %called and constants from OrgFlx are used
    rpLL = rpm*p1*exp(p2*(sLL(1,1,it)-Tr)) / ...
          (1+p1*exp(p2*(sLL(1,1,it)-Tr)));

    rpLL = max(rpLL,0.001); %min. ratio: in case rpLL produce very small numbers
    %just use 0.001

    RMorgc_LL = -NPLL*rcp/1e4; %NPLL is in phosphorous:
    % use redfield (rcp) ratio to convert to carbon. 1e4 is bc m2 to cm2
    RMcar_LL  = -NPLL*rcp*rpLL/1e4; %same as above but also timed rain ratio

    for k = 1:n

        FC_LL(k) = RMorgc_LL * ...
            exp(-lmdcorg*(k*d-dm));

        Fcal_LL(k) = RMcar_LL * ...
            exp(-lmdcar*(k*d-dm));

    end


    %% HL

    PHL = sHL(3,1,it);

    NPHL = bpe*LfHL*dm*PHL^2/(Phlf + PHL);

    rpHL = rpm*p1*exp(p2*(sHL(1,1,it)-Tr)) / ...
          (1+p1*exp(p2*(sHL(1,1,it)-Tr)));

    rpHL = max(rpHL,0.001);

    RMorgc_HL = -NPHL*rcp/1e4;
    RMcar_HL  = -NPHL*rcp*rpHL/1e4;

    FC_HL   = zeros(1,n);
    Fcal_HL = zeros(1,n);

    for k = 1:n

        FC_HL(k) = RMorgc_HL * ...
            exp(-lmdcorg*(k*d-dm));

        Fcal_HL(k) = RMcar_HL * ...
            exp(-lmdcar*(k*d-dm));

    end


   %what fraction gets buried 

OrgBur_LL = FC_LL .* (1 - pOrgCLL(:,it)');
OrgBur_HL = FC_HL .* (1 - pOrgCHL(:,it)');

CarbBur_LL = Fcal_LL .* (1 - pCalCLL(:,it)');
CarbBur_HL = Fcal_HL .* (1 - pCalCHL(:,it)');


%to get the total, integrate over segment areas: 

%mol C/s
Org_global = ...
    sum(OrgBur_LL .* SedAreaLL) + ...
    sum(OrgBur_HL .* SedAreaHL);

Carb_global = ...
    sum(CarbBur_LL .* SedAreaLL) + ...
    sum(CarbBur_HL .* SedAreaHL);


%go from mol pr sec. to GtC pr yr
M_C = 12.011; % grams C / mol C
conv = M_C * sy / 1e15;

CorgBurial(it)  = Org_global  * conv;
CcarbBurial(it) = Carb_global * conv;

end


%% sum org and carbonate for total GtC C buried

TotalBurial = CorgBurial + CcarbBurial;

end
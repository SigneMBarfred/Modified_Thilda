%GET OCEANIC CARBON BY LAYER
%created july 2026
%used for finding out how much additional carbon gets stored in each layer
% in the vertical ocean profile relative to the initial (1765) carbon
% amount (GtC)
%takes a filename as input and output how much additional carbon per layer in high lat
%and low lat

function [CarbonLL, CarbonHL] = GetOceanCarbonByLayer(filename)

    %get the relevant files loaded: 
    load(filename)
    ParVal_R
    load Globalarea.txt
    
    global dm d n aLL aHL
    %ocean area vs depth so each layer is weighted by volume(?)
    %low latitude basin
    GAw=interp1(Globalarea(1:23,1),Globalarea(1:23,14),[dm dm+d*(1:n-1)]);
    GAw=GAw./GAw(1);                        

    %high latitude basin
    GAc=interp1(Globalarea(24:46,1),Globalarea(24:46,14),[dm dm+d*(1:n-1)]);
    GAc=GAc./GAc(1);

    dv      =  [dm d*ones(1,n-1)];            % vector of layer thichnesses [m] (from ParVal_R)

    %create empty matrices
    CarbonLL = zeros(n,length(st));
    CarbonHL = zeros(n,length(st));

    %%%
    % sLL(tracer, depth,time)
    for ii=1:length(st); %st is global time (yr) var from OutThildafile 
        DICLL = squeeze(sLL(4,:,ii)); %dissolved inorganic carbon from low latitudes (DI carbon is tracer 4)

        DICHL = squeeze(sHL(4,:,ii)); %DIC for high latitudes


        for k = 1:n %loop over n layers for the time ii
            CarbonLL(k,ii) = 2*12.011*aLL*DICLL(k)*GAw(k)*dv(k)/1e15; %converting 
            % DIC molar to GtC

            CarbonHL(k,ii) = 2*12.011*aHL*DICHL(k)*GAc(k)*dv(k)/1e15;  %converting 
            % DIC molar to GtC

        end
 
        % 2*12.011 comes from 1 hemisphere (so double it) and molar mass of
        % carbon (12.011g/mol)
        %convert to Gigatons from grams via /10^15
    end

    %calculating change rel. to 1765
    CarbonLL = CarbonLL - CarbonLL(:,1);
    CarbonHL = CarbonHL - CarbonHL(:,1);
end
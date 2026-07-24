%created june 2026

function OceanCarbonUptake = GetOceanCarbonUptake(filename)
% function that takes an OutThilda file as input and outputs Ocean Carbon
% Uptake  after zero correction with ocean carbon uptake in 1765
%units: GtC (ie cumulative carbon uptake)

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

    %%%
    % sLL(tracer, depth,time)
    for ii=1:length(st); %st is global time (yr) var from OutThildafile 
        DICLL = squeeze(sLL(4,:,ii)); %dissolved inorganic carbon from low latitudes (DI carbon is tracer 4)

        DICHL = squeeze(sHL(4,:,ii)); %DIC for high latitudes

        OceanC(ii) = 2*12.011* (aLL*sum(DICLL.*GAw)*dm + ...
            aHL*sum(DICHL.*GAc)*dm) / (10^15); %carbon in ocean in this year. 
        % 2*12.011 comes from 1 hemisphere (so double it) and molar mass of
        % carbon (12.011g/mol)
        %convert to Gigatons from grams via /10^15
    end

    OceanCarbonUptake = OceanC - OceanC(1); %subtracting ocean carbon from 1765 from entire vector ie
    % OceanCarbonUptake = 0 happens at 1765

end





% carbon overview
close all
%are the changes in carbon in the system correpsonding to the changing
%emissions or is the model doing stuff it should not

filename = 'OutThilda_A25C_incr_circ_10000yr_q1.50.mat';

load(filename)
time = st + 1765;
ParVal_R

%how much carbon is in oceans through time for this simulation
OceanC = GetOceanCarbonInventory(filename);
OceanC = OceanC(:); %as column vector
%atmospheric C
global rVa mgt %inverse atmospheric volume for one hemisphere (rVa) and conversion btw moles anf gigatonees of carbon (mgt)

Catm = 2*squeeze(sAT(4,1,:))/rVa/mgt;
%factor 2 bc both hemispheres (equal mixing is assummed and seems to bee
%the case)
%convert from partial pressure to gigatonnes 

%land carbon (there are 4 reservoirs in this, that we will simply add
%together)
LandC = squeeze(sum(sLB,1));


%adding it all up, we expect this then somewhat matches the development of
%anthropogenic emissions

TotalC = OceanC + Catm + LandC;

%plotting time
figure
plot(time,OceanC,'LineWidth',2)
hold on
plot(time,Catm,'LineWidth',2)
plot(time,LandC,'LineWidth',2)
plot(time,TotalC,'k','LineWidth',2)

legend('Ocean','Atm','Land','Total')
xlabel('year')
ylabel('Carbon (GtC)')
title('Where is the carbon going? A25C, qscale = 1.5')

%% TWO CIRCULATIONS STRENGTHS TOGETHER: 
%% Carbon overview: compare q = 0.50 and q = 1.50

ParVal_R
global rVa mgt

%% q = 0.50 ----------
file050 = 'OutThilda_A25C_incr_circ_10000yr_q0.50.mat';

load(file050)

time = st + 1765;

Ocean050 = GetOceanCarbonInventory(file050);
Ocean050 = Ocean050(:);

Catm050 = 2*squeeze(sAT(4,1,:))/rVa/mgt;

Land050 = squeeze(sum(sLB,1));

Total050 = Ocean050 + Catm050 + Land050;


%% q = 1.50 ----------
file150 = 'OutThilda_A25C_incr_circ_10000yr_q1.50.mat';

load(file150)

Ocean150 = GetOceanCarbonInventory(file150);
Ocean150 = Ocean150(:);

Catm150 = 2*squeeze(sAT(4,1,:))/rVa/mgt;

Land150 = squeeze(sum(sLB,1));



Total150 = Ocean150 + Catm150 + Land150;


%% Plot
figure
% Ocean
plot(time,Ocean050,'b:','LineWidth',2)
hold on
plot(time,Ocean150,'b','LineWidth',2)

% Atmosphere
plot(time,Catm050,'r:','LineWidth',2)
plot(time,Catm150,'r','LineWidth',2)

% Land
plot(time,Land050,'g:','LineWidth',2)
plot(time,Land150,'g','LineWidth',2)

% Total
plot(time,Total050,'k:','LineWidth',2)
plot(time,Total150,'k','LineWidth',2)

xlabel('Year')
ylabel('Carbon (GtC)')

legend( ...
    'Ocean q=0.50','Ocean q=1.50', ...
    'Atmosphere q=0.50','Atmosphere q=1.50', ...
    'Land q=0.50','Land q=1.50', ...
    'Total q=0.50','Total q=1.50', ...
    'Location','best')

title('Carbon inventory: A25C')
grid on



%% PLOT THEIR DIFFERENCES TO INITIAL TIME : 
Ocean050 = Ocean050 - Ocean050(1);
Ocean150 = Ocean150 - Ocean150(1);

Catm050 = Catm050 - Catm050(1);
Catm150 = Catm150 - Catm150(1);

Land050 = Land050 - Land050(1);
Land150 = Land150 - Land150(1);

Total050 = Total050 - Total050(1);
Total150 = Total150 - Total150(1);


figure

% Ocean
plot(time,Ocean050,'b:','LineWidth',2)
hold on
plot(time,Ocean150,'b','LineWidth',2)

% Atmosphere
plot(time,Catm050,'r:','LineWidth',2)
plot(time,Catm150,'r','LineWidth',2)

% Land
plot(time,Land050,'g:','LineWidth',2)
plot(time,Land150,'g','LineWidth',2)

% Total
plot(time,Total050,'k:','LineWidth',2)
plot(time,Total150,'k','LineWidth',2)

xlabel('Year')
ylabel('Carbon (GtC)')

legend( ...
    'Ocean q=0.50','Ocean q=1.50', ...
    'Atmosphere q=0.50','Atmosphere q=1.50', ...
    'Land q=0.50','Land q=1.50', ...
    'Total q=0.50','Total q=1.50', ...
    'Location','best')

title('DIFFERENCES compared to 1765 Carbon inventory: A25C')
grid on


%%
plot(time,2*sGS)
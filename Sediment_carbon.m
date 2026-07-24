%sediment plotting script
%checking how sediment module evolves through time
%expect sedimentation rate to be low or dissolution to rise bc ocean carbon
%uptake rises significantly when weakened circulation

filename = 'OutThilda_A25C_incr_circ_10000yr_q0.50.mat';

load(filename)

time = st + 1765;


%deepest ocean layers change in organic carbon in the sediments: 
figure

plot(time,dworgCLL(55,:),'LineWidth',2)
hold on
plot(time,dworgCHL(55,:),'LineWidth',2)

xlabel('Year')
ylabel('Organic matter fraction')
legend('Low latitude','High latitude')

title('q = 0.5, Organic matter, sediments deepest layer, A25C qscale 0.5')
grid on

% how composition of sediment varies through depths for end time: 
figure

plot(dworgCLL(:,end),1:55,'LineWidth',2)
hold on

plot(dworgCHL(:,end),1:55,'LineWidth',2)

set(gca,'YDir','reverse')

xlabel('Organic matter fraction')
ylabel('Depth layer')

legend('Low latitude','High latitude')

title('q=0.5, T = 11765 AD Sediment profile A25C qscale = 0.5')
grid on
%shows more and more organic matter as we go up thorugh the water column 


%how composition of sediment looks at start :
figure

plot(dworgCLL(:,1),1:55,'LineWidth',2)
hold on

plot(dworgCHL(:,1),1:55,'LineWidth',2)

set(gca,'YDir','reverse')

xlabel('Organic matter fraction')
ylabel('Depth layer')

legend('Low latitude','High latitude')

title('q= 0.5, T= 1765 AD Sediment profile A25C qscale = 0.5')
grid on



%plot those two together: 

figure

plot(dworgCLL(:,1),1:55,'k--','LineWidth',2)
hold on
plot(dworgCLL(:,end),1:55,'b','LineWidth',2)
plot(dworgCHL(:,1),1:55,'k--','LineWidth',2)
plot(dworgCHL(:,end),1:55,'b','LineWidth',2)

set(gca,'YDir','reverse')

xlabel('Organic matter fraction')
ylabel('Sediment layer')

legend('1765 LL','11765LL', '1765 HL','11765HL')

title('q= 0.5, Evolution, start/finish - sediment organic matter, A25C, qscale=0.5')
grid on


%% CARBONATE

%carbonate through time for layer 55
figure

plot(time,dwcLL(55,:),'LineWidth',2)
hold on
plot(time,dwcHL(55,:),'LineWidth',2)

xlabel('Year')
ylabel('Carbonate fraction')
legend('Low latitude','High latitude')

title('q=0.5 , Carbonate content of sediments for bottom layer (55)')
grid on


%dissoltion of the carbonate through time as well for layer 55: 
figure

plot(time,pCalCLL(55,:),'LineWidth',2)
hold on
plot(time,pCalCHL(55,:),'LineWidth',2)

xlabel('Year')
ylabel('Fraction dissolved')

legend('Low latitude','High latitude')

title('q=0.5, Carbonate dissolution in sediments for bottom layer (55)')
grid on


%evolution when averaging layers ?
MeanCarbonateLL = mean(dwcLL,1);
MeanCarbonateHL = mean(dwcHL,1);

figure

plot(time,MeanCarbonateLL,'LineWidth',2)
hold on
plot(time,MeanCarbonateHL,'LineWidth',2)

xlabel('Year')
ylabel('Mean carbonate fraction')

legend('Low latitude','High latitude')

title('qscale  =0.5 - Mean sediment carbonate for all layers ')
grid on


MeanDissLL = mean(pCalCLL,1);
MeanDissHL = mean(pCalCHL,1);

figure

plot(time,MeanDissLL,'LineWidth',2)
hold on
plot(time,MeanDissHL,'LineWidth',2)

xlabel('Year')
ylabel('Mean dissolution fraction')

legend('Low latitude','High latitude')

title('q=0.5, Mean carbonate dissolution')
grid on
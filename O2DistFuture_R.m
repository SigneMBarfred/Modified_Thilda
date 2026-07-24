function [Afrac, Vfrac] = O2DistFuture_R(sLL,sHL,GAw,GAc)

%Calculation of future ocean "dead zone" area and volumes

%Load present day distribution of ocean area percentages for dissolved
%oxygen classes

load AreaOxygenStandard              
%-----

% Read in parameter values
%-----
ParVal_R
global d n aHL aLL 

if length(sLL(6,1,:))>=24
    a=23;
else
    a=1;
end

for i=1:n
      for j=10                              %original range 2:350
           for ii=a:length(sLL(6,1,:))
            O2M(i,ii) = (sLL(6,i,ii)*GAw(i)*aLL+sHL(6,i,ii)*GAc(i)*aHL)./...
           (GAw(i)*aLL+GAc(i)*aHL);
            d(i,ii)=(O2M(i,ii)-O2M(i,a))*1e3/1.028;
            AF(i,j,ii)=AreaO2st(i,max(1,j-floor(d(i,ii))))*...
           (ceil(d(i,ii))-d(i,ii))+AreaO2st(i,max(1,j-ceil(d(i,ii))))*(d(i,ii)-floor(d(i,ii)));
           end
     end
end
 
for k=1:1:length(sLL(6,1,:))
Afrac(k) =  AF(5,10,k)/3.4168e14;                         %area at 500 m depth
Vfrac(k) = sum(AF(:,10,k))*100/1.3328e18;
end

return 


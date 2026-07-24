function [kLL,kHL,kAT,kLB,kGS,srLL,srHL]= ODE_R(t,LL,HL,MHC,MHA,MHM,LWR,AT,LB,GS,GAw,GAc,...
    pCalLL,pCalHL,pOrgLL,pOrgHL,daint,co2emfos,co2emland,ch4em,co2seq1,co2seq2,k)

% Ordinary Differential Equations for Thilda_R
%
% Input :  t        - time
%          LL/HL    - ocean tracers
%          AT       - atmospheric tracers
% Data ordered accordingly:

% LL(tracer,level) contains low latiude ocean data
% HL(tracer,level) contains high latitude ocean data
% AT(tracer,zone) contains atmospheric data
% LB(tracer) contain land biosphere data

% Ocean tracers are: 
%                     1:   - temperature [oC]
%                     2:   - salinity []
%                     3:   - phosphate [mol/m3
%                     4:   - DIC [mol/m3] 
%                     5:   - alkalinity [eq/m3] 
%                     6:   - oxygen  [mol/m3] 

%Atmospheric tracers are:
%                     1:   - temperature [oC]
%                     2:   - pCH_4 [atm]
%                     3.   - pN_2O [atm] 
%                     4:   - pCO_2 [atm]
%                     5:   - pO_2 [atm]  

% Zones are (only temperature is not well mixed):    
%                     1:   - low latitude 
%                     2:   - high latitude 

% Land Biosphere tracers are:
%                     1: Leafy biomass carbon
%                     2: Woody biomass carbon
%                     3: Litter biomass carbon
%                     4: Soil biomass carbon
%
%
% Output: kLL/kHL   - Rate of change (per sec) of low (kLL) and 
%                     high (kHL) oceanic tracers. Used for time-stepping.
%                     Dimensions are as input ocean data.
%         kAT       - Rate of change (per sec) of atmospheric tracers
%                     Dimensions are as input atmospheric data.  
%         kLB       - Rate of change (per sec) of Land Biosphere tracers
%                     dimensions are as input land biosphere data   
%         kGS       - Rate of change (per sec) of geo-sequestered carbon
%
%         srLL/srHL - ocean source and sink terms. Used for diagnostics.


% Activate global Parameters

ParVal_R;
global nto RVolC13 RCorgC13 RCarbC13 Volo d dm aLL aHL n dv aH  
global ULL UHL LfLL LfHL Lxf Lyf rc fdiv sy mgt weLL weHL rVa rno rcp rcop


% Ocean and atmospheric exchanges (see functions) 
%-------------
[q wLL wHL kvLL kvHL kh]          = OceExc_R(HL); %changed to accept HL in july 2026
%[q wLL wHL kvLL kvHL kh]          = OceExc_R; %original
%-------------
[mpra] = AtmAero_R(t,MHA);
[QEBLL,QEBHL,QLL,QHL,aHLNI,Fw] = AtmEnerBal_R(t,LL(1,1),HL(1,1),LWR,AT,daint,mpra,k);

%-------------
% External inputs
[RcarLL,RcarHL,RorgLL,RorgHL,Wcarb,Wsil,Worg]=ExtForce_R(AT);

% Air-sea exchange of DIC/pCO_2 and O_2 
%-------------

[asLL,CO2LL] = GasExc_R(LL,AT,aLL);
[asHL,CO2HL] = GasExc_R(HL,AT,aHLNI);
%-------------

% Land biosphere component and land-air exchanges
%----------------
[al]=LandExc_R(AT,LB);

% Atmospheric CH4 sink and anthropogenic CH4 and CO2 sources
%----------------
[mprm,mdr] = AtmMet_R(t,MHM,AT);
[mprc] = AtmCO2_R(t,MHC);

     % outcommented: 
     % if t>=750*sy
     %    ch4em(k)=0;
     %    co2emland(k)=0;
     %    co2emfos(k)=0;
     %    co2seq1(k)=0;
     %    co2seq2(k)=0;
     % end
     %  if t<246*sy
     %    co2seq1(k)=0;
     %    co2seq2(k)=0;
     % 
     %  end   
     %  if t<750*sy
     %     mprm(:)=0;
     %     mprc(:)=0;
     %  end

     if t < 750*sy
        ch4 = ch4em(k);
        co2fos = co2emfos(k);
        co2land = co2emland(k);
        seq1 = co2seq1(k);
        seq2 = co2seq2(k);
     else
        ch4 = 0;
        co2fos = 0;
        co2land = 0;
        seq1 = 0;
        seq2 = 0;
     end
      
%CO2 injection in rocks and subsequent release 

co2seq(k)=seq1+seq2;
kGS =0.5*MHC(1)*co2seq(k)*1e-3/sy + mprc(3)/mgt- MHC(8)*GS/sy;
 
% Ocean tracer sources and sinks  
%-------------

[srLL] = OrgFlx_R(LL,AT,aLL  ,LfLL,CO2LL,GAw,pCalLL,pOrgLL,RcarLL,RorgLL);
[srHL] = OrgFlx_R(HL,AT,aHLNI,LfHL,CO2HL,GAc,pCalHL,pOrgHL,RcarHL,RorgHL);

%-------------

% CO2 injection in the ocean betweem 2500 and 3500 m, note that only
% injection to the low-mid latitude ocean is considered

for m=26:35
    
    srLL(4,m)=srLL(4,m)+1*(mprc(2)+0.5*mgt/10*(1-MHC(1))*co2seq(k)*1e-3/sy)+...
        MHC(9)*MHC(8)*GS*mgt/sy/10;           %release from rock to deep ocean
    srHL(4,m)=srHL(4,m)+0*mprc(2) ;
        
 end

% Establish source terms for all tracers
%-------------
% Temperature and salinity only have surface sources/sinks
srLL(1,:)    = zeros(1,n); srLL(1,1) = -QLL*aLL/rc;
srHL(1,:)    = zeros(1,n); srHL(1,1) = -QHL*aHLNI/rc;
srLL(2,:)    = zeros(1,n); srLL(2,1) = 0;    
srHL(2,:)    = zeros(1,n); srHL(2,1) = 0;     

% Combine surface fluxes and interior sources for DIC
srLL(4,1) = srLL(4,1)+asLL(4);
srHL(4,1) = srHL(4,1)+asHL(4);

% Combine surface fluxes and interior sources for oxygen
srLL(6,1) = srLL(6,1)+asLL(5);
srHL(6,1) = srHL(6,1)+asHL(5);

%-------------

% Calculate time derivative of ocean tracers
%-------------
kvLL(1:n-1)=kvLL(1:n-1).*GAw(1:n-1);
kvHL(1:n-1)=kvHL(1:n-1).*GAc(1:n-1);
kh(1:n)=kh.*GAw(1:n);

    kLL     = 1./repmat((aLL*[dm d*GAw(2:n)]),nto,1).*( ...
             + [-kvLL(1)*aLL/(3*d)*(8*LL(:,1)-9*LL(:,2)+LL(:,3)) ...
                 repmat(kvLL(:,2:n-1),nto,1)*aLL/d.*(LL(:,3:n)-LL(:,2:n-1)) zeros(nto,1)] ...
	     - [zeros(nto,1) -kvLL(1)*aLL/(3*d)*(8*LL(:,1)-9*LL(:,2)+LL(:,3)) ...
                 repmat(kvLL(:,2:n-1),nto,1)*aLL/d.*(LL(:,3:n)-LL(:,2:n-1))]...
             - repmat(kh.*Lxf/Lyf.*dv,nto,1).*(LL-HL) ...
	     + [wLL(1)*LL(:,1) repmat(wLL(2:n-1),nto,1).*( LL(:,2:n-1)+LL(:,3:n) )*.5 zeros(nto,1)] ...
             - [zeros(nto,1) wLL(1)*LL(:,1) repmat(wLL(2:n-1),nto,1).*( LL(:,2:n-1) + LL(:,3:n) )*.5] ...
             - repmat((q>0).*(q-Fw),nto,1).*LL ...
             - repmat((q<0).*q,nto,1).*HL ...
             + srLL );

    kHL     = 1./repmat((aHL*[dm d*GAc(2:n)]),nto,1).*( ...         
             + [-kvHL(1)*aHL/(3*d)*(8*HL(:,1)-9*HL(:,2)+HL(:,3)) ...
                 repmat(kvHL(:,2:n-1),nto,1)*aHL/d.*(HL(:,3:n)-HL(:,2:n-1)) zeros(nto,1)] ...
	     - [zeros(nto,1) -kvHL(1)*aHL/(3*d)*(8*HL(:,1)-9*HL(:,2)+HL(:,3)) ...
                 repmat(kvHL(:,2:n-1),nto,1)*aHL/d.*(HL(:,3:n)-HL(:,2:n-1))]...
             + repmat(kh.*Lxf/Lyf.*dv,nto,1).*(LL-HL) ...
	     + [wHL(1)*HL(:,1) repmat(wHL(2:n-1),nto,1).*( HL(:,2:n-1)+HL(:,3:n) )*.5 zeros(nto,1)] ...
             - [zeros(nto,1) wHL(1)*HL(:,1) repmat(wHL(2:n-1),nto,1).*( HL(:,2:n-1) + HL(:,3:n) )*.5] ...
             + repmat((q>0).*(q-Fw),nto,1).*LL ...
             + repmat((q<0).*q,nto,1).*HL ...
             + srHL );
         
% Calculate time derivative of atmospheric tracers

nta = 5; 
for i=1:nta
% Atmospheric temperature, gasses and tracers
if i==1
      kAT(i,:)  = [QEBLL QEBHL]./(rc*aH*[weLL*sin(fdiv) weHL*(1-sin(fdiv)) ]); 
  elseif i==2
      kAT(i,:)  = -rVa*(-al(6) + mdr(1)- mprm(1)-0.5*0.75*ch4*1e-3*mgt/sy);        
  elseif i==3
      kAT(i,:)  = -rVa*(-al(7) + AT(3,1)*1/(rVa*150*sy)- 0.007*mprm(1)...     % N2O lifetime 150 yrs; 
          -0.007*0.5*0.75*ch4*1e-3*mgt/sy);     
  elseif i==4
      kAT(i,:)  =-rVa*(asLL(4) + asHL(4) - al(5) - mdr(1)- mprc(1)- (1-MHC(9))*MHC(8)*GS*mgt/sy ...
          +Wcarb + 2*Wsil -Worg - Volo-0.5*(co2fos+co2land)*1e-3*mgt/sy );                        
   elseif i==5 
     kAT(i,:)  = -rVa*(asLL(5) + asHL(5)+1.391*mprc(4)...
        - (Worg+Volo*(RCarbC13-RVolC13)/(RCarbC13-RCorgC13))*rcop/rcp-rno*(RorgLL+RorgHL)...   
        - 1.1*mgt*(al(1)+al(2)+al(3)+al(4))...
        +0.5*(1.391*(co2fos+seq1)+1.1*(co2land+seq2))*1e-3*mgt/sy);
    end 
end 
%---------
% Calculate time derivative of C12 of land biomasses
for i=1:4
  if i==1
     kLB(i,:)  = al(1); 
 elseif i==2
     kLB(i,:)  = al(2); 
 elseif i==3
     kLB(i,:)  = al(3);   
 elseif i==4
     kLB(i,:)  = al(4); 
end 
end 

return


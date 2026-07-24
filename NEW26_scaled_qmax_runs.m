%script that produces OutThilda files for scaled strengths of overturning
%circulation qmax
%added june 2026
%adjust time duration in Thilda_R

global qmax aLL

ParVal_R

%qmult = [1];
qmult = [0.25 0.5 0.75 1 1.25 1.5];
for i = 1:length(qmult)

    qmax = qmult(i)*aLL*1.8e-8;

    fprintf('Running qmult = %.2f\n',qmult(i))

    Thilda_R

    movefile('OutThilda_R.mat', ...
        sprintf('OutThilda_Zero_incr_circ_10000yr_q%.2f.mat',qmult(i))) %Thilda_R saves as OutThilda_R always so we move to avoid overriding
%notice: named for 10000 yr runs
end
 
%%
% %script that produces OutThilda files for scaled strengths of overturning
% %circulation qmax
% %added june 2026
% %adjust time duration in Thilda_R
% 
% global qmax aLL
% 
% ParVal_R
% 
% %qmult = [1];
% qmult = [0.25 0.5 0.75 1 1.25 1.5];
% for i = 1:length(qmult)
% 
%     qmax = qmult(i)*aLL*1.8e-8;
% 
%     fprintf('Running qmult = %.2f\n',qmult(i))
% 
%     Thilda_R
% 
%     movefile('OutThilda_R.mat', ...
%         sprintf('OutThilda_Zero_incr_circ_10000yr_q%.2f.mat',qmult(i))) %Thilda_R saves as OutThilda_R always so we move to avoid overriding
% %notice: named for 10000 yr runs
% end
 

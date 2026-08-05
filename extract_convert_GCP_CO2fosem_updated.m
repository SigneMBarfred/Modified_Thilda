%convert from MtCO2 to MtC for updated emission files: 


T = readtable('GCB2025v15_MtCO2_flat.csv');

%look for 'Global' and after 2000 + sector = total:

idx = strcmp(T.Country,'Global');
%should return rows for global, column for total

%get index for correct years (2000-2024)
yr = T.Year(idx);
MtCO2 = T.Total(idx);
idx2 = yr >=2000 & yr <=2024; 

MtC = MtCO2(idx2) * (12/44); %convert to MtC


for i = 1:length(MtC)
    fprintf('%.0f\n', MtC(i));
end
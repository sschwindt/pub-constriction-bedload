% February 2016, Sebastian Schwindt
% EPF Lausanne, LCH

% Script analyzes chezy coefficient of laboratory flume (whole channel)
% requires fIE, fEvaldhk, fGetChezy
%--------------------------------------------------------------------------
clear all;
close all;

Qb = 1;                 %[0/1] bedload off=0 / on=1

% GET DATA (from Excel) ---------------------------------------------------
Q = (5.:0.1:10).*10^(-3);          %[m³/s] pump discharge
sourceName = '20160203_chezy_channel.xlsx';
sourceRange = 'D4:H9';% contains geometry data of each cross-section
switch Qb
    case 0
        hRange = 'L4:P6';       % contains p1 amnd p2 values for linear interpolation
        targetRangeC = ['D16:D',num2str(15+numel(Q))];
        targetRangeK = ['C6:C',num2str(5+numel(Q))];
    case 1
        hRange = 'L7:P9';       % contains p1 amnd p2 values for linear interpolation
        targetRangeC = ['E16:E',num2str(15+numel(Q))];
        targetRangeK = ['D6:D',num2str(5+numel(Q))];
end


Data = xlsread(sourceName, 1, sourceRange);
hData = xlsread(sourceName, 1, hRange);

% DATA PREPARATION --------------------------------------------------------
w = (Data(3,:) + Data(4,:))./2;     %[m] section base width
alpha = (Data(5,:)+Data(6,:))/2;   %[deg] section bank slope
DX = Data(1,2:end)-Data(1,1:end-1); %[m] section lengths
DZ = Data(2,1:end-1)-Data(2,2:end); %[m] scetion geodetic change
% COMPUTE -----------------------------------------------------------------
Chezy = nan(numel(Q),1);            %[m¹'²/s] channel chezy coefficient
Kst = nan(numel(Q),1);              %[m¹'³/s] channel kst coefficient


for dq = 1:numel(Q)
    disp(' ')
    disp(['Simulation of Q = ', num2str(Q(dq)*10^3), ' l/s.'])
    
    h = hData(1,:).*Q(dq)+hData(2,:);   %[m] flow depth for Q(dq)
    
    [Chezy(dq), Kst(dq)] = fGetChezy(h, w, alpha, DX, DZ, Q(dq),...
        sourceName, dq, Qb);

end

% WRITE DATA --------------------------------------------------------------
if not(Qb)
    xlswrite(sourceName,Q', 1, ['C16:C',num2str(15+numel(Q))]);%for chezy
    xlswrite(sourceName,Q', 2, ['B6:B',num2str(5+numel(Q))]);%for kst
    xlswrite(sourceName,Q', 3, ['B5:B',num2str(4+numel(Q))]);%for accuracy rep.
end
xlswrite(sourceName,Chezy,1, targetRangeC);
xlswrite(sourceName,Kst,2, targetRangeK);
disp(['Finished, check accuracy report (written to: ', sourceName,').']);

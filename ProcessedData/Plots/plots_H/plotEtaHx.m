% February 2016, Sebastian Schwindt
% EPF Lausanne, LCH

% Script completes summary table for combined constrictions
%--------------------------------------------------------------------------
clear all;
close all;
sourceName = '20160224_statistics.xlsx';


% READ DATA ---------------------------------------------------------------
% from statistics summary file
cd ..
cd('Statistics')
% get opening size
mu = xlsread(sourceName, 1, 'F4:F274');
ax = xlsread(sourceName, 1, 'D4:D274');
bx = xlsread(sourceName, 1, 'E4:E274');
qbx_temp = xlsread(sourceName, 1,'G4:G274');
Fr = xlsread(sourceName, 1, 'H4:H274');
Hx = xlsread(sourceName, 1, 'I4:I274');
taux_temp = xlsread(sourceName, 1, 'J4:J274');
eta_temp = xlsread(sourceName, 1, 'K4:K274');
qbx = nan(size(mu));
qbx(1:numel(qbx_temp)) = qbx_temp;
coeffs = xlsread(sourceName, 2, 'D13:F15');

taux = nan(size(Fr));
taux(1:numel(taux_temp))=taux_temp;

eta = nan(size(Fr));
eta(1:numel(eta_temp))=eta_temp;

cd ..
cd('Plots')

pos1com = 1;
posXcom = 98;

pos1lat = 99;
posXlat = 204;

pos1top = 205;
posXtop = numel(mu);

% PREPARE DATA ------------------------------------------------------------
xInterp = nan(150,3);
yInterp = nan(150,3);
X = nan(150,3);
Xb = nan(150,3);
Y = nan(150,3);
Yb = nan(150,3);

for i = 1:3
    switch i
        case 1
            pos1 = pos1com;
            posX = posXcom;
            cX = ax(pos1:posX).*bx(pos1:posX)./Hx(pos1:posX).^2;
        case 2
            pos1 = pos1lat;
            posX = posXlat;
            cX = bx(pos1:posX)./Hx(pos1:posX);
        case 3
            pos1 = pos1top;
            posX = posXtop;
            cX = ax(pos1:posX)./Hx(pos1:posX);
    end
    
    interX1 = nanmin(cX./Hx(pos1:posX));
    interXX = nanmax(cX./Hx(pos1:posX));
    if interXX > 1;
        interXX = 0.95;
    end
    interX = 1*(interX1-0.01:(interXX-interX1)/100:interXX+0.01);
    xInterp(1:numel(interX),i)=interX;
    yInterp(1:numel(interX),i)=coeffs(i,1).*interX.^coeffs(i,2)+coeffs(i,3);
    
    % point without bedload
    X(1:posX-pos1+1,i) = cX;
    Y(1:posX-pos1+1,i) = eta(pos1:posX);
    
    % points with bedload
    posQb = find(not(isnan(qbx(pos1:posX)))); % positions
    for j = 1:numel(posQb)
        Xb(posQb(j),i) = X(posQb(j),i);
        Yb(posQb(j),i) = Y(posQb(j),i);
        % delete points from without-bedload-data
        X(posQb(j),i) = nan;
        Y(posQb(j),i) = nan;
    end
end
fPlotEtaHx(Xb,xInterp,Yb,yInterp, 1)
disp('Data processed.');

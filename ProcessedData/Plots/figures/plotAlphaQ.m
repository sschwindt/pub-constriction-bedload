% April 2016, Sebastian Schwindt
% EPF Lausanne, LCH

% Script completes summary table for combined constrictions
%--------------------------------------------------------------------------
clear all;
close all;
sourceName = '20160402_statistics_h.xlsx';


% READ DATA ---------------------------------------------------------------
% from statistics summary file
cd ..
cd('Statistics')
% get opening size
alphaQ_temp = xlsread(sourceName, 1, 'F4:F274');
mu = xlsread(sourceName, 1, 'O4:O274');
ax = xlsread(sourceName, 1, 'D4:D274');
bx = xlsread(sourceName, 1, 'E4:E274');
qbx_temp = xlsread(sourceName, 1,'G4:G274');
Fr = xlsread(sourceName, 1, 'H4:H274');
hx = xlsread(sourceName, 1, 'I4:I274');
taux = xlsread(sourceName, 1, 'J4:J274');
eta = xlsread(sourceName, 1, 'K4:K274');

qbx = nan(size(mu));
qbx(1:numel(qbx_temp)) = qbx_temp;
coeffs = xlsread(sourceName, 2, 'M27:O28');

cd ..
cd('Plots')

pos1com = 1;
posXcom = 98;

pos1lat = 99;
posXlat = 204;

alphaQ = nan(size(mu));
alphaQ(pos1lat:posXlat) = alphaQ_temp;

pos1top = 205;
posXtop = numel(alphaQ);

% PREPARE DATA ------------------------------------------------------------

X = nan(150,3);
Xb = nan(150,3);
Y = nan(150,3);
Yb = nan(150,3);

for i = 2
    switch i
        case 1
            pos1 = pos1com;
            posX = posXcom;
            cX = ax(pos1:posX).*bx(pos1:posX);
        case 2
            pos1 = pos1lat;
            posX = posXlat;
            cX = bx(pos1:posX);
        case 3
            pos1 = pos1top;
            posX = posXtop;
            cX = ax(pos1:posX);
    end
  
    % point without bedload
    X(1:posX-pos1+1,i) = cX;
    Y(1:posX-pos1+1,i) = alphaQ(pos1:posX);
    
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

interX1 = nanmin(cX);
interXX = nanmax(cX);
xInterp = interX1-0.02:(interXX-interX1)/100:interXX-0.0;
yInterp = coeffs(1,1).*exp(-((xInterp-coeffs(1,2))./coeffs(1,3)).^2)+...
            coeffs(2,1).*exp(-((xInterp-coeffs(2,2))./coeffs(2,3)).^2);


fPlotAlphaQ(X,Xb,xInterp, Y,Yb,yInterp, 1)
disp('Data processed.');

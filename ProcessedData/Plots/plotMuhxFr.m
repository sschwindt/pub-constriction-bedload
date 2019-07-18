% April 2016, Sebastian Schwindt
% EPF Lausanne, LCH

% Script completes summary table for combined constrictions
%--------------------------------------------------------------------------
clear global;
close all;
sourceName = '20160402_statistics_h.xlsx';


% READ DATA ---------------------------------------------------------------
% from statistics summary file
cd ..
cd('Statistics')
% get opening size
expNo = xlsread(sourceName, 1, 'B4:B274');
mu_temp = xlsread(sourceName, 1, 'P4:P274');
muh = xlsread(sourceName, 1, 'O4:O274');
ax_temp = xlsread(sourceName, 1, 'D4:D274');
bx_temp = xlsread(sourceName, 1, 'E4:E274');
qbx_temp = xlsread(sourceName, 1,'G4:G274');
Fr_temp = xlsread(sourceName, 1, 'H4:H274');
hx_temp = xlsread(sourceName, 1, 'I4:I274');
taux = xlsread(sourceName, 1, 'J4:J274');
eta = xlsread(sourceName, 1, 'K4:K274');
qbx = nan(size(expNo));
qbx(1:numel(qbx_temp)) = qbx_temp;

ax = nan(size(expNo));
ax(1:numel(ax_temp))=ax_temp;

bx = nan(size(expNo));
bx(1:numel(bx_temp))=bx_temp;

hx = nan(size(expNo));
hx(1:numel(hx_temp))=hx_temp;

Fr = nan(size(expNo));
Fr(1:numel(Fr_temp)) = Fr_temp;

mu = nan(size(expNo));
mu(1:numel(mu_temp)) = mu_temp;


coeffshx = xlsread(sourceName, 2, 'M15:O17');
coeffsFr = xlsread(sourceName, 2, 'D15:F17');
coeffshx07Fr05 = xlsread(sourceName, 2, 'M21:O23');
coeffshx07Fr05 = nan(3,3);

cd ..
cd('Plots')

pos1com = 1;
posXcom = 98;

pos1lat = 99;
posXlat = 204;

pos1top = 205;
posXtop = numel(expNo);

% PREPARE DATA ------------------------------------------------------------
interXhx = 0.31:0.01:0.7;
interXFr = 0.10:0.01:0.5;

interX = nan(150,2);
interX(1:numel(interXhx),1)= interXhx;
interX(1:numel(interXFr),2)= interXFr;


Y = nan(150,3);
Yb = nan(150,3);
Xhx = nan(150,3);
Xbhx = nan(150,3);
XFr = nan(150,3);
XbFr = nan(150,3);

for i = 1:3
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
    Y(1:posX-pos1+1,i) =  mu(pos1:posX);
    Xhx(1:posX-pos1+1,i) = hx(pos1:posX);
    XFr(1:posX-pos1+1,i) = Fr(pos1:posX);
    
    % points with bedload
    posQb = find(not(isnan(qbx(pos1:posX)))); % positions
    for j = 1:numel(posQb)
        Yb(posQb(j),i) = Y(posQb(j),i);
        Xbhx(posQb(j),i) = Xhx(posQb(j),i);
        XbFr(posQb(j),i) = XFr(posQb(j),i);
        % delete points from without-bedload-data
        Y(posQb(j),i) = nan;
        Xhx(posQb(j),i) = nan;
        XFr(posQb(j),i) = nan;
    end
end
lyInterphx=coeffshx(1,1).*interX(:,1).^coeffshx(1,2)+coeffshx(1,3);
lyInterpFr=coeffsFr(1,1).*interX(:,2).^coeffsFr(1,2)+coeffsFr(1,3);

yInterphx=coeffshx(2,1).*interX(:,1).^coeffshx(2,2)+coeffshx(2,3);
yInterpFr=coeffsFr(2,1).*interX(:,2).^coeffsFr(2,2)+coeffsFr(2,3);

uyInterphx=coeffshx(3,1).*interX(:,1).^coeffshx(3,2)+coeffshx(3,3);
uyInterpFr=coeffsFr(3,1).*interX(:,2).^coeffsFr(3,2)+coeffsFr(3,3);

xInterphx = interX(:,1);
xInterpFr = interX(:,2);

Yhx = Y;
Ybhx = Yb;
YFr = Y;
YbFr = Yb;
fPlotMuhxFr(Xhx,Xbhx,xInterphx,Yhx,Ybhx,yInterphx, ...
            lyInterphx, lyInterpFr, uyInterphx, uyInterpFr, ...
            coeffshx07Fr05, ...
            XFr,XbFr,xInterpFr,YFr,YbFr,yInterpFr, 1)
disp('Data processed.');

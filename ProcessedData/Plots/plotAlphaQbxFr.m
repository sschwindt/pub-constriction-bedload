% April 2016, Sebastian Schwindt
% EPF Lausanne, LCH

% Script completes summary table for combined constrictions
%--------------------------------------------------------------------------
clear all;
close all;
sourceName = '20160402_statistics_h.xlsx';
interpolationCurves = 1; % 0 = off // 1 = on
disp('Running plotAlphaQbxFr.m ...')
% READ DATA ---------------------------------------------------------------
% from statistics summary file
cd ..
cd('Statistics')
% get opening size
expNo = xlsread(sourceName, 1, 'B4:B274');
alphaQ_temp = xlsread(sourceName, 1, 'F4:F274');
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


coeffsbx = xlsread(sourceName, 2, 'M38:O40');
coeffsbxHigh = xlsread(sourceName, 2, 'M71:O73');
coeffsFr = xlsread(sourceName, 2, 'M74:O76');
coeffsFrLow = xlsread(sourceName, 2, 'M41:O43');
% deactivation if meaningless
if not(interpolationCurves)
    coeffsbx = nan(size(coeffsbx));
    coeffsbxHigh = nan(size(coeffsbxHigh));
    coeffsFr = nan(size(coeffsFr));
end

cd ..
cd('Plots')

pos1com = 1;
posXcom = 98;

pos1lat = 99;
posXlat = 204;

pos1top = 205;
posXtop = numel(expNo);

alphaQ = nan(size(mu));
alphaQ(pos1lat:posXlat) = alphaQ_temp;

% PREPARE DATA ------------------------------------------------------------
interXbx = 0.27:0.01:0.35;
interXbxHigh = 0.4:0.01:0.76;
interXFr = 0.45:0.01:1;
interXFrLow = 0.18:0.01:0.37;

interX = nan(150,4);
interX(1:numel(interXbx),1)= interXbx;
interX(1:numel(interXFr),2)= interXFr;
interX(1:numel(interXbxHigh),3)= interXbxHigh;
interX(1:numel(interXFrLow),4)= interXFrLow;

Y = nan(150,3);
Yb = nan(150,3);
Xbx = nan(150,3);
Xbbx = nan(150,3);
XFr = nan(150,3);
XbFr = nan(150,3);

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
    Y(1:posX-pos1+1,i) =  alphaQ(pos1:posX);
    Xbx(1:posX-pos1+1,i) = bx(pos1:posX);
    XFr(1:posX-pos1+1,i) = Fr(pos1:posX);
    
    % points with bedload
    posQb = find(not(isnan(qbx(pos1:posX)))); % positions
    for j = 1:numel(posQb)
        Yb(posQb(j),i) = Y(posQb(j),i);
        Xbbx(posQb(j),i) = Xbx(posQb(j),i);
        XbFr(posQb(j),i) = XFr(posQb(j),i);
        % delete points from without-bedload-data
        Y(posQb(j),i) = nan;
        Xbx(posQb(j),i) = nan;
        XFr(posQb(j),i) = nan;
    end
end

   
lyInterpbx=coeffsbx(1,1).*interX(:,1).^coeffsbx(1,2)+coeffsbx(1,3);
lyInterpFr=coeffsFr(1,1).*interX(:,2).^coeffsFr(1,2)+coeffsFr(1,3);
lyInterpbxHigh=coeffsbxHigh(1,1).*interX(:,3).^coeffsbxHigh(1,2)+coeffsbxHigh(1,3);

yInterpbx=coeffsbx(2,1).*interX(:,1).^coeffsbx(2,2)+coeffsbx(2,3);
yInterpFr=coeffsFr(2,1).*interX(:,2).^coeffsFr(2,2)+coeffsFr(2,3);
yInterpFrLow=coeffsFrLow(2,1).*interX(:,4).^coeffsFrLow(2,2)+coeffsFrLow(2,3);
yInterpbxHigh=coeffsbxHigh(2,1).*interX(:,3).^coeffsbxHigh(2,2)+coeffsbxHigh(2,3);

uyInterpbx=coeffsbx(3,1).*interX(:,1).^coeffsbx(3,2)+coeffsbx(3,3);
uyInterpFr=coeffsFr(3,1).*interX(:,2).^coeffsFr(3,2)+coeffsFr(3,3);
uyInterpbxHigh=coeffsbxHigh(3,1).*interX(:,3).^coeffsbxHigh(3,2)+coeffsbxHigh(3,3);

xInterpbx = interX(:,1);
xInterpFr = interX(:,2);
xInterpbxHigh = interX(:,3);
xInterpFrLow = interX(:,4);

Ybx = Y;
Ybbx = Yb;
YFr = Y;
YbFr = Yb;
fPlotAlphaQbxFr(Xbx,Xbbx,xInterpbx,Ybx,Ybbx,yInterpbx, ...
                lyInterpbx, lyInterpFr, uyInterpbx, uyInterpFr, ...
                lyInterpbxHigh, xInterpbxHigh, yInterpbxHigh, uyInterpbxHigh, ...
                XFr,XbFr,xInterpFr,YFr,YbFr,yInterpFr,...
                xInterpFrLow,yInterpFrLow,1)
disp('Data processed.');

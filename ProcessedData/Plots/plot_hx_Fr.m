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


coeffshx = xlsread(sourceName, 2, 'M47:O55');
coeffsFr = xlsread(sourceName, 2, 'M59:O67');


cd ..
cd('Plots')

pos1com = 1;
posXcom = 98;

pos1lat = 99;
posXlat = 204;

pos1top = 205;
posXtop = numel(expNo);

% PREPARE DATA ------------------------------------------------------------
xInterp = nan(150,3);
yInterphx = nan(150,3);
yInterpFr = nan(150,3);
lyInterphx = nan(150,3);
lyInterpFr = nan(150,3);
uyInterphx = nan(150,3);
uyInterpFr = nan(150,3);

interXa = 0.69:0.01:0.99;
interXb = 0.26:0.01:0.76;
interXab= 0.57:0.01:0.75;

interX = nan(150,3);
interX(1:numel(interXab),1)= interXab;
interX(1:numel(interXb),2)= interXb;
interX(1:numel(interXa),3)= interXa;

X = nan(150,3);
Xb = nan(150,3);
Yhx = nan(150,3);
Ybhx = nan(150,3);
YFr = nan(150,3);
YbFr = nan(150,3);

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
    X(1:posX-pos1+1,i) = cX;
    Yhx(1:posX-pos1+1,i) = hx(pos1:posX);
    YFr(1:posX-pos1+1,i) = Fr(pos1:posX);
    
    % points with bedload
    posQb = find(not(isnan(qbx(pos1:posX)))); % positions
    for j = 1:numel(posQb)
        Xb(posQb(j),i) = X(posQb(j),i);
        Ybhx(posQb(j),i) = Yhx(posQb(j),i);
        YbFr(posQb(j),i) = YFr(posQb(j),i);
        % delete points from without-bedload-data
        X(posQb(j),i) = nan;
        Yhx(posQb(j),i) = nan;
        YFr(posQb(j),i) = nan;
    end
    
    
    
    % regression data
    nRow = 3*(i-1);
    lyInterphx(:,i)=coeffshx(nRow+1,1).*interX(:,i).^coeffshx(nRow+1,2)+coeffshx(nRow+1,3);
    lyInterpFr(:,i)=coeffsFr(nRow+1,1).*interX(:,i).^coeffsFr(nRow+1,2)+coeffsFr(nRow+1,3);
    
    yInterphx(:,i)=coeffshx(nRow+2,1).*interX(:,i).^coeffshx(nRow+2,2)+coeffshx(nRow+2,3);
    yInterpFr(:,i)=coeffsFr(nRow+2,1).*interX(:,i).^coeffsFr(nRow+2,2)+coeffsFr(nRow+2,3);

    uyInterphx(:,i)=coeffshx(nRow+3,1).*interX(:,i).^coeffshx(nRow+3,2)+coeffshx(nRow+3,3);
    uyInterpFr(:,i)=coeffsFr(nRow+3,1).*interX(:,i).^coeffsFr(nRow+3,2)+coeffsFr(nRow+3,3);
    % with Qb
%     xInterpb(1:numel(interXb),i)=interXb;
%     yInterpb(1:numel(interXb),i)=coeffsQb(i,1).*interXb.^coeffsQb(i,2)+coeffsQb(i,3);
end
xInterphx = interX;
xInterpFr = interX;
Xhx = X;
Xbhx = Xb;
XFr = X;
XbFr = Xb;
fPlot_hx_Fr(Xhx,Xbhx,xInterphx,Yhx,Ybhx,yInterphx, ...
               lyInterphx, lyInterpFr, uyInterphx, uyInterpFr, ... 
               XFr,XbFr,xInterpFr,YFr,YbFr,yInterpFr, 1)
disp('Data processed.');

function[] = fPlotAlphaQbxFr(Xhx,Xbhx,xInterphx,Yhx,Ybhx,yInterpBx,...
                lyInterphx, lyInterpFr, uyInterphx, uyInterpFr, ...
                lyInterpbxHigh, xInterpbxHigh, yInterpbxHigh, uyInterpbxHigh, ...
                XFr,XbFr,xInterpFr,YFr,YbFr,yInterpFr,...
                xInterpFrLow,yInterpFrLow,write2disc)
% Y = matrix with 3 columns

scrsz = get(0,'ScreenSize');
% scrsz =   1 1 1920 1200
%scrsz(4) = scrsz(4)*4;
fontS = 28;
MarkerS = 15;
yPos = 0.82; % y position of the textbox
% create gray scale colormap
cmap = contrast(ones(1,10));
colors = colormap(cmap);
colors=zeros(size(colors));
limColor = [.65 .65 .65];
colors(7,:)=[0 0 0];
%other:{'+','o','diamond','v','square','pentagram','x','^','*','>','h','<'};
mStyles = {'o','square','v','none'};
lStyles = {'none','none','none','-','-.'};

figure1 = figure('Color',[1 1 1],'Position',[1 scrsz(4) scrsz(3) scrsz(4)/1.6]);



%% SUBPLOT a) -- bx
subplot1 = subplot(1,2,1,'Parent',figure1,'FontSize',fontS,...
    'FontName','Arial','GridLineStyle','-',...
    'XTickLabel',{'0.0','0.2','0.4','0.6','0.8','1.0'},...
    'XTick',0.0:0.2:1,...
    'YTickLabel',{'','0.5','1.0','1.5','2.0'},...
    'YTick',0.:0.5:2,...
    'LineWidth', 1.5);
hold(subplot1,'all');
box(subplot1,'on');
grid(subplot1,'off');

xlim(subplot1,[0. 1]);
ylim(subplot1,[0. 2]);


% create plot of b* without bedload
plot1(1) = plot(Xhx(:,2),Yhx(:,2),...
    'Color',colors(7,:),...
    'LineWidth',1,'LineStyle',lStyles{1,2},...
    'Marker',mStyles{1,2},'MarkerSize',MarkerS,...
    'DisplayName','lateral c_* = b_*');

% lgnd = legend(subplot1,'show','Location','SouthWest');
% legend boxoff
% set(lgnd,'color','none');

% create plot of b* with bedload
plot1(2) = plot(Xbhx(:,2),Ybhx(:,2),...
    'Color',colors(7,:),...
    'LineWidth',1,'LineStyle',lStyles{1,2},...
    'Marker',mStyles{1,2},'MarkerSize',MarkerS,...
    'MarkerFaceColor',[0.502 0.502 0.502],...
    'DisplayName','lateral b_* (with bedload)');

% create plot of regression curve b* < 0.4
plot1(3) = plot(xInterphx,yInterpBx,...
    'Color',[0.,0.,0.],...
    'LineWidth',1,'LineStyle',lStyles{1,4},...
    'Marker',mStyles{1,4},'MarkerSize',MarkerS,...
    'DisplayName','Regression curve');

% lower bounds
plot1(4) = plot(xInterphx,lyInterphx,...
    'Color',limColor,...
    'LineWidth',1,'LineStyle',lStyles{1,5},...
    'Marker',mStyles{1,4},'MarkerSize',MarkerS,...
    'DisplayName','Regression curve');
% upper bounds
plot1(5) = plot(xInterphx,uyInterphx,...
    'Color',limColor,...
    'LineWidth',1,'LineStyle',lStyles{1,5},...
    'Marker',mStyles{1,4},'MarkerSize',MarkerS,...
    'DisplayName','Regression curve');

% create plot of regression curve b* > 0.4
plot1(6) = plot(xInterpbxHigh,yInterpbxHigh,...
    'Color',[0.,0.,0.],...
    'LineWidth',1,'LineStyle',lStyles{1,4},...
    'Marker',mStyles{1,4},'MarkerSize',MarkerS,...
    'DisplayName','Regression curve');

% lower bounds
plot1(7) = plot(xInterpbxHigh,lyInterpbxHigh,...
    'Color',limColor,...
    'LineWidth',1,'LineStyle',lStyles{1,5},...
    'Marker',mStyles{1,4},'MarkerSize',MarkerS,...
    'DisplayName','Regression curve');
% upper bounds
plot1(8) = plot(xInterpbxHigh,uyInterpbxHigh,...
    'Color',limColor,...
    'LineWidth',1,'LineStyle',lStyles{1,5},...
    'Marker',mStyles{1,4},'MarkerSize',MarkerS,...
    'DisplayName','Regression curve');

fMakeXgrid(0.2:0.2:08,[0,2],0.5);
fMakeYgrid([0,1],0.5:0.5:1.5,0.5);

% Create xlabel
xlabel('Constriction width ratio b_* [-]','FontSize',fontS,'FontName','Arial');
% Create ylabel
ylabel('\epsilon = Q_{obs} / {Q_{c}(Eq.3)}  [-]',...
    'FontSize',fontS+2,...
    'FontName','Arial');
annotation(figure1,'textbox',...
        [0.14 yPos  0.4 0.1],... % [x_begin y_begin length height]
        'String',{'a)'},...
        'FontName','Arial','FontSize',fontS+2,...
        'FontWeight','bold',...
        'FitBoxToText','on',...
        'BackgroundColor',[1 1 1],...
        'LineStyle','none');

%% SUBPLOT b) -- Fr
subplot2 = subplot(1,2,2,'Parent',figure1,'FontSize',fontS,...
    'FontName','Arial','GridLineStyle','-',...
    'XTickLabel',{'0.0','0.2','0.4','0.6','0.8','1.0'},...
    'XTick',0.0:0.2:1,...
    'YTickLabel',{'','0.5','1.0','1.5','2.0'},...
    'YTick',0.:0.5:2,...
    'LineWidth', 1.5);
hold(subplot2,'all');
box(subplot2,'on');
grid(subplot2,'off');

xlim(subplot2,[0. 1]);
ylim(subplot2,[0. 2]);

plot2(1) = plot(XFr(:,2),YFr(:,2),...
    'Color',colors(7,:),...
    'LineWidth',1,'LineStyle',lStyles{1,2},...
    'Marker',mStyles{1,2},'MarkerSize',MarkerS,...
    'DisplayName','lateral c_* = b_*');

% legend(axes1,'show','Location','NorthWest');

plot2(2) = plot(XbFr(:,2),YbFr(:,2),...
    'Color',colors(7,:),...
    'LineWidth',1,'LineStyle',lStyles{1,2},...
    'Marker',mStyles{1,2},'MarkerSize',MarkerS,...
    'MarkerFaceColor',[0.502 0.502 0.502],...
    'DisplayName','lateral b_* (with bedload)');


% create plot of regression curve Fr
plot2(3) = plot(xInterpFr,yInterpFr,...
    'Color',[0.,0.,0.],...
    'LineWidth',1,'LineStyle',lStyles{1,4},...
    'Marker',mStyles{1,4},'MarkerSize',MarkerS,...
    'DisplayName','Regression curve');

% lower bounds
plot2(4) = plot(xInterpFr,lyInterpFr,...
    'Color',limColor,...
    'LineWidth',1,'LineStyle',lStyles{1,5},...
    'Marker',mStyles{1,4},'MarkerSize',MarkerS,...
    'DisplayName','Regression curve');
% upper bounds
plot2(5) = plot(xInterpFr,uyInterpFr,...
    'Color',limColor,...
    'LineWidth',1,'LineStyle',lStyles{1,5},...
    'Marker',mStyles{1,4},'MarkerSize',MarkerS,...
    'DisplayName','Regression curve');

% create plot of regression curve Fr Lower range
plot2(6) = plot(xInterpFrLow,yInterpFrLow,...
    'Color',[0.,0.,0.],...
    'LineWidth',1,'LineStyle',lStyles{1,4},...
    'Marker',mStyles{1,4},'MarkerSize',MarkerS,...
    'DisplayName','Regression curve');

fMakeXgrid(0.2:0.2:0.8,[0,2],0.5);
fMakeYgrid([0,1],0.5:0.5:1.5,0.5);

% Create xlabel
xlabel('Upstream Froude number Fr_0 [-]','FontSize',fontS,'FontName','Arial');
% Create ylabel
% ylabel('Discharge coefficient \mu [-]',...
%     'FontSize',fontS,...
%     'FontName','Arial');  
annotation(figure1,'textbox',...
        [0.585 yPos  0.4 0.1],... % [x_begin y_begin length height]
        'String',{'b)'},...
        'FontName','Arial','FontSize',fontS+2,...
        'FontWeight','bold',...
        'FitBoxToText','on',...
        'BackgroundColor',[1 1 1],...
        'LineStyle','none');

% set(legend,'Position',[0.6 0.75 0.2 0.2],'FontSize',fontS,...
%     'EdgeColor',[1 1 1],'YColor',[1 1 1],'XColor',[1 1 1]);

% create water surface indicator
% annotation(figure1,'arrow',[0.202 0.201985],...
%     [0.8824 0.882],'HeadWidth',22,'HeadLength',13,'HeadStyle','plain');



if write2disc
    cd('figures');
    export_fig alpha_bx_Fr.png -png
    export_fig alpha_bx_Fr.eps -eps
    cd ..
    disp('Figure (alpha_bx_Fr) written to disc (figures folder).');
    close all;
end


function[] = fPlotAlphaQ(X,Xb,xInterp,Y,Yb,yInterp, write2disc)
% Y = matrix with 3 columns

scrsz = get(0,'ScreenSize');
fontS = 36;
MarkerS = 16;
xPos = 0.15; % y position of the textbox
% create gray scale colormap
cmap = contrast(ones(1,10));
colors = colormap(cmap);
colors=zeros(size(colors));
colors(7,:)=[0 0 0];
%other:{'+','o','diamond','v','square','pentagram','x','^','*','>','h','<'};
mStyles = {'o','square','v','none'};
lStyles = {'none','none','none','-'};

figure1 = figure('Color',[1 1 1],'Position',[1 scrsz(4) scrsz(3)/1.3 scrsz(4)]);


axes1 = axes('Parent',figure1,'FontSize',fontS,...
    'FontName','Arial','GridLineStyle','-',...
    'XTickLabel',{'0.2','0.3','0.4','0.5','0.6','0.7','0.8'},...
    'XTick',0.2:0.1:0.8,...
    'YTickLabel',{'','0.5','1.0','1.5','2.0','2.5','3.0'},...
    'YTick',0.:0.5:3);
hold(axes1,'all');
box(axes1,'on');
grid(axes1,'on');

xlim(axes1,[0.2 0.8]);
ylim(axes1,[0. 3]);

% create plot of b* without bedload
plot1(1) = plot(X(:,2),Y(:,2),'Parent',axes1,...
    'Color',colors(7,:),...
    'LineWidth',1,'LineStyle',lStyles{1,2},...
    'Marker',mStyles{1,2},'MarkerSize',MarkerS,...
    'DisplayName','without bedload');

% create plot of b* without bedload
plot1(2) = plot(Xb(:,2),Yb(:,2),'Parent',axes1,...
    'Color',colors(7,:),...
    'LineWidth',1,'LineStyle',lStyles{1,2},...
    'Marker',mStyles{1,2},'MarkerSize',MarkerS,...
    'MarkerFaceColor',[0.502 0.502 0.502],...
    'DisplayName','with bedload');
legend(axes1,'show','Location','SouthWest');

% create plot of regression curve
plot1(3) = plot(xInterp,yInterp,'Parent',axes1,...
    'Color',[0.55,0.55,0.55],...
    'LineWidth',1,'LineStyle',lStyles{1,4},...
    'Marker',mStyles{1,4},'MarkerSize',MarkerS,...
    'DisplayName','Regression curve');

% Create xlabel
xlabel('Constriction width ratio b_* [-]','FontSize',fontS,'FontName','Arial');
% Create ylabel
ylabel('\alpha = Q_{c,meas.} / Q_{c,calc.} [-]',...
    'FontSize',fontS,...
    'FontName','Arial');


    
% set(legend,'Position',[0.6 0.75 0.2 0.2],'FontSize',fontS,...
%     'EdgeColor',[1 1 1],'YColor',[1 1 1],'XColor',[1 1 1]);

% create water surface indicator
% annotation(figure1,'arrow',[0.202 0.201985],...
%     [0.8824 0.882],'HeadWidth',22,'HeadLength',13,'HeadStyle','plain');



if write2disc
    cd('figures');
    export_fig alphaQ.png -png
    export_fig alphaQ.eps -eps
    cd ..
    disp('Figure (hx) written to disc (figures folder).');
    close all;
end


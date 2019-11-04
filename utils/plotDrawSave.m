function plotDrawSave(numTrk,plotDrawStyle,aveSuccessRatePlot,idxSeqSet,rankNum,rankingType,rankIdx,nameTrkAll,thresholdSet,titleName,xLabelName,yLabelName,figName,metricType, transparency)

for idxTrk=1:numTrk
    %each row is the sr plot of one sequence
    tmp=aveSuccessRatePlot(idxTrk, idxSeqSet,:);
    aa=reshape(tmp,[length(idxSeqSet),size(aveSuccessRatePlot,3)]);
    aa=aa(sum(aa,2)>eps,:);
    bb=mean(aa);
    switch rankingType
        case 'AUC'
            perf(idxTrk) = mean(bb);
        case 'threshold'
            perf(idxTrk) = bb(rankIdx);
    end
end

[tmp,indexSort]=sort(perf,'descend');% descend ascend

i=1;
fontSize = 16;
fontSizeLegend = 16;

figure1 = figure;

axes1 = axes('Parent',figure1,'FontSize',16);
% you can  modify the figure size to meet yours
if rankNum~=10
    fontSize = 16;
    fontSizeLegend = 11;
    set(figure1, 'position', [100 100 600 640]);
end

for idxTrk=indexSort(1:rankNum)
    
    tmp=aveSuccessRatePlot(idxTrk,idxSeqSet,:);
    aa=reshape(tmp,[length(idxSeqSet),size(aveSuccessRatePlot,3)]);
    aa=aa(sum(aa,2)>eps,:);
    bb=mean(aa);
    
    switch rankingType
        case 'AUC'
            score = mean(bb);
            tmp=sprintf('%.3f', score);
        case 'threshold'
            score = bb(rankIdx);
            tmp=sprintf('%.3f', score);
    end
    
    tmpName{i} = [' [' tmp ']' nameTrkAll{idxTrk}];
    disp([nameTrkAll{idxTrk} ' ' tmp]);
    grid on;
    
    h(i) = plot(thresholdSet,bb,'color',plotDrawStyle{i}.color, 'lineStyle', plotDrawStyle{i}.lineStyle, 'lineWidth', 5,'Parent',axes1);
    hold on
    i=i+1;
end

title(titleName,'fontsize',fontSize);
xlabel(xLabelName,'fontsize',fontSize);
ylabel(yLabelName,'fontsize',fontSize);
if isequal(rankingType, 'AUC')
    legend1=legend(tmpName,'Interpreter', 'none','fontsize',fontSizeLegend,'Location','SouthWest');
elseif isequal(rankingType, 'threshold')
    legend1=legend(tmpName,'Interpreter', 'none','fontsize',fontSizeLegend,'Location','SouthEast');
end
set(legend1,'Interpreter','latex','FontSize',fontSizeLegend);
% set semi-transparency of the legend
if transparency
    set(legend1.BoxFace, 'ColorType', 'truecoloralpha', 'ColorData', uint8([255;255;255;0.5*255]));
end
hold off
saveas(gcf,figName,'pdf');
saveas(gcf,figName,'fig');

end
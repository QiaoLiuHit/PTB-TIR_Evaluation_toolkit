% this file is to draw the success and precision plots 

clear
close all;
clc
warning off all;
addpath('./utils');
attPath = './tiranno/att/'; % The folder that contains the annotation files for sequence attributes


%plot's linestyle and color
plotSetting;

%  sequences can be configured in 'configSeqs.m'
seqs=configSeqs;

%  trackers can be configured in 'configTrackers.m'
trackers=configTrackers;

numSeq=length(seqs);
numTrk=length(trackers);

nameTrkAll=cell(numTrk,1);
for idxTrk=1:numTrk
    t = trackers{idxTrk};
    nameTrkAll{idxTrk}=t.namePaper;
end

nameSeqAll=cell(numSeq,1);
numAllSeq=zeros(numSeq,1);


% path of the generagted plots
figPath = './figs/results_OPE_all/';
if ~exist(figPath,'dir')
    mkdir(figPath);
end
% performance mat file
perfMatPath = './perfMat/Overall_all/';
if ~exist(perfMatPath,'dir')
    mkdir(perfMatPath);
end

% OPE  TRE  SRE
evalTypeSet = {'OPE'};  

% AUC->success plot  and threshold->precision plot
rankingType = {'threshold', 'AUC'};%, we use both threshold and AUC 

draw_attribute = 0; % draw attribute-based performance

transparency = 1; % We set legend to semi-transparency

rankNum = 27;% number of plots to show
%just show  top 10 trackers
if rankNum == 10
    plotDrawStyle=plotDrawStyle10;
end

thresholdSetOverlap = 0:0.05:1;
thresholdSetError = 0:50;

% attribute name
attName={'deformation' 'occlusion'	'scale variation' 'background clutter'	'low resolution' 'fast motion' 'motion blur' 'out of view' 'intensity variation' 'thermal crossover' };
attFigName={'deformation' 'occlusion'	'scale_variation' 'background_clutter'	'low_resolution' 'fast_motion' 'motion_blur' 'out-of-view' 'intensity_variation' 'thermal_crossover'};

%load attributes of all the sequences
att=[];
for idxSeq=1:numSeq
    s = seqs{idxSeq};
    nameSeqAll{idxSeq}=s.name;
    s.len = s.endFrame - s.startFrame + 1;
    numAllSeq(idxSeq) = s.len;
    att(idxSeq,:)=load([attPath s.name '.txt']);
end

attNum = size(att,2);
% draw performance
for k=1:length(rankingType)
    if isequal(rankingType{k},'AUC')
        metricTypeSet = {'overlap'};
    elseif isequal(rankingType{k},'threshold')
         metricTypeSet = {'error'};
    end

    for i=1:length(metricTypeSet)
        metricType = metricTypeSet{i};%error,overlap

        switch metricType
            case 'overlap'
                thresholdSet = thresholdSetOverlap;
                rankIdx = 11;
                xLabelName = 'Overlap threshold';
                yLabelName = 'Success rate';
            case 'error'
                thresholdSet = thresholdSetError;
                rankIdx = 21;
                xLabelName = 'Location error threshold';
                yLabelName = 'Precision';
        end  

        tNum = length(thresholdSet);

        for j=1:length(evalTypeSet)

            evalType = evalTypeSet{j};% we just use OPE

            plotType = [metricType '_' evalType];

            switch metricType
                case 'overlap'
                    titleName = ['Success plots of ' evalType];
                case 'error'
                    titleName = ['Precision plots of ' evalType];
            end

            dataName = [perfMatPath 'aveSuccessRatePlot_' num2str(numTrk) 'alg_'  plotType '.mat'];

            % If the performance Mat file, dataName, does not exist, it will call
            % genPerfMat to generate the file.
            if ~exist(dataName)
                genPerfMat(seqs, trackers, evalType, nameTrkAll, perfMatPath);
            end        

            load(dataName);
            numTrk = size(aveSuccessRatePlot,1);        

            if rankNum > numTrk || rankNum <0
                rankNum = numTrk;
            end

            figName= [figPath 'quality_plot_' plotType '_' rankingType{k}];
            idxSeqSet = 1:length(seqs);
            disp(evalType);

            % draw and save the overall performance plot
            plotDrawSave(numTrk,plotDrawStyle,aveSuccessRatePlot,idxSeqSet,rankNum,rankingType{k},rankIdx,nameTrkAll,thresholdSet,titleName, xLabelName,yLabelName,figName,metricType, transparency);

            % draw and save the performance plot for each attribute
            if draw_attribute
                attTrld = 0;
                for attIdx=1:attNum
                    idxSeqSet=find(att(:,attIdx)>attTrld);
                    if length(idxSeqSet) < 2
                        continue;
                    end
                    disp([attName{attIdx} ' ' num2str(length(idxSeqSet))])

                    figName=[figPath attFigName{attIdx} '_'  plotType '_' rankingType{k}];
                    titleName = ['Plots of ' evalType ': ' attName{attIdx} ' (' num2str(length(idxSeqSet)) ')'];

                    switch metricType
                        case 'overlap'
                            titleName = ['Success plots - ' attName{attIdx} ' (' num2str(length(idxSeqSet)) ')'];
                        case 'error'
                            titleName = ['Precision plots of ' evalType ' - ' attName{attIdx} ' (' num2str(length(idxSeqSet)) ')'];
                    end
                     plotDrawSave(numTrk,plotDrawStyle,aveSuccessRatePlot,idxSeqSet,rankNum,rankingType{k},rankIdx,nameTrkAll,thresholdSet,titleName, xLabelName,yLabelName,figName,metricType, transparency);
                end   
            end
         end
    end
end

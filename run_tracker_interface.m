% this file is used to run the evaluated tracker using OPE, TRE, or SRE
close all
clear
clc
warning off all;

addpath('./utils');
seqs=configSeqs; % your can configue sequences in 'configSeqs.m'
trackers=configTrackers; % you can congiure trackers in 'configTrackers.m'
shiftTypeSet = {'left','right','up','down','topLeft','topRight','bottomLeft','bottomRight','scale_8','scale_9','scale_11','scale_12'};

% your can choose one of them
evalType='OPE'; %'OPE','SRE','TRE'

numSeq=length(seqs);
numTrk=length(trackers);

finalPath = ['./results/results_' evalType '_temp/'];

if ~exist(finalPath,'dir')
    mkdir(finalPath);
end

tmpRes_path = ['./tmp/' evalType '/'];

if ~exist(tmpRes_path,'dir')
    mkdir(tmpRes_path);
end

pathAnno = './tiranno/';
bSaveImage = 0;
% run tracker in all sequences
for idxSeq=1:length(seqs)
    s = seqs{idxSeq};
    s.len = s.endFrame - s.startFrame + 1;
    s.s_frames = cell(s.len,1);
    nz	= strcat('%0',num2str(s.nz),'d'); %number of zeros in the name of image
    for i=1:s.len
        image_no = s.startFrame + (i-1);
        id = sprintf(nz,image_no);
        s.s_frames{i} = strcat(s.path,id,'.',s.ext);
    end
    
    img = imread(s.s_frames{1});
    [imgH,imgW,ch]=size(img);
    disp([pathAnno s.name '.txt']);
    rect_anno = dlmread([pathAnno s.name '.txt']);
    numSeg = 20;
    
    % split the video into 20 fragments
    [subSeqs, subAnno]=splitSeqTRE(s,numSeg,rect_anno);
    
    switch evalType
        case 'SRE'
            subS = subSeqs{1};
            subA = subAnno{1};
            subSeqs=[];
            subAnno=[];
            r=subS.init_rect;
            
            for i=1:length(shiftTypeSet)
                subSeqs{i} = subS;
                shiftType = shiftTypeSet{i};
                subSeqs{i}.init_rect=shiftInitBB(subS.init_rect,shiftType,imgH,imgW);
                subSeqs{i}.shiftType = shiftType;
                subAnno{i} = subA;
            end
        case 'OPE'
            subS = subSeqs{1};
            subSeqs=[];
            subSeqs{1} = subS;
            subA = subAnno{1};
            subAnno=[];
            subAnno{1} = subA;
        otherwise
    end
    
    % run trackers one by one
    for idxTrk=1:numTrk
        t = trackers{idxTrk};
        % validate the results
        if exist([finalPath s.name '_' t.name '.mat'])
            disp([finalPath s.name '_' t.name '.mat']);
            load([finalPath s.name '_' t.name '.mat']);
            [bfail, failed_idx]=checkResult(results, subAnno);
            if bfail
                disp([s.name ' '  t.name]);
            end
            if failed_idx ~= 0 && failed_idx ~= -1
                disp([num2str(idxTrk) '_' t.name ', ' num2str(idxSeq) '_' s.name ': ' num2str(failed_idx) '/' num2str(length(subSeqs))])
                rp = [tmpRes_path s.name '_' t.name '_' num2str(failed_idx) '/'];
                if bSaveImage&&~exist(rp,'dir')
                    mkdir(rp);
                end
                
                subS = subSeqs{failed_idx};
                
                subS.name = [subS.name '_' num2str(failed_idx)];
                
                funcName = ['res=run_' t.name '(subS, rp, bSaveImage);']; % 'subS' video information
                
                try
                    % step into the tracker folder
                    cd(['./trackers/' t.name]);
                    addpath(genpath('./'))
                    % run the tracker
                    eval(funcName);
                    % setp out the evaluated toolkit folder
                    rmpath(genpath('./'))
                    cd('../../');

                    if isempty(res)
                        results = [];
                        break;
                    end
                catch err
                    disp('error');
                    rmpath(genpath('./'))
                    cd('../../');
                    res=[];
                    continue;
                end
                res.len = subS.len;
                res.annoBegin = subS.annoBegin;
                res.startFrame = subS.startFrame;
                
                switch evalType
                    case 'SRE'
                        res.shiftType = shiftTypeSet{failed_idx};
                end
                
                results{failed_idx} = res;
                save([finalPath s.name '_' t.name '.mat'], 'results');
                
            end
            continue;
        end
        
        results = [];
        for idx=1:length(subSeqs)
            disp([num2str(idxTrk) '_' t.name ', ' num2str(idxSeq) '_' s.name ': ' num2str(idx) '/' num2str(length(subSeqs))])
            
            rp = [tmpRes_path s.name '_' t.name '_' num2str(idx) '/'];
            if bSaveImage && ~exist(rp,'dir')
                mkdir(rp);
            end

            subS = subSeqs{idx};
            subS.name = [subS.name '_' num2str(idx)];
            funcName = ['res=run_' t.name '(subS, rp, bSaveImage);'];
            
            try
                % step into the tracker folder
                cd(['./trackers/' t.name]);
                addpath(genpath('./'))
                % run the tracker and return the tracker's results as var 'res'
                eval(funcName);
                % setp out the evaluated toolkit folder
                rmpath(genpath('./'))
                cd('../../');
                
                if isempty(res)
                    results = [];
                    break;
                end
            catch err
                disp('error');
                rmpath(genpath('./'))
                cd('../../');
                res=[];
                continue;
            end
            
            res.len = subS.len;
            res.annoBegin = subS.annoBegin;
            res.startFrame = subS.startFrame;
            
            switch evalType
                case 'SRE'
                    res.shiftType = shiftTypeSet{idx};
            end
            
            results{idx} = res;
            
        end
        save([finalPath s.name '_' t.name '.mat'], 'results');
    end
end

figure
t=clock;
t=uint8(t(2:end));
disp([num2str(t(1)) '/' num2str(t(2)) ' ' num2str(t(3)) ':' num2str(t(4)) ':' num2str(t(5))]);


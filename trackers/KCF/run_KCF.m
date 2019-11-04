function results=run_KCF(seq, res_path, bSaveImage)
close all;
base_path='E:\TIR_Tracker_Benchmark_V1.0\'; 
img_files=seq.s_frames;

for i=1:numel(img_files)
    img_files_fullpath{i,1}=[base_path img_files{i,1}];
end

target_sz=[seq.init_rect(1,4),seq.init_rect(1,3)];
pos=[seq.init_rect(1,2),seq.init_rect(1,1)]+floor(target_sz/2);
video_path=[base_path seq.path];

[positions, fps] = run_tracker(img_files_fullpath, pos, target_sz,video_path);
target_size=[positions(:,4),positions(:,3)];
left_point=[positions(:,2),positions(:,1)]-floor(target_size/2);
results.res=[left_point,target_size];
results.fps=fps;
results.type='rect';
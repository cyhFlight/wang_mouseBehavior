F = '/tigress/yuhangc/wang_lab/test_run/aligned/TEST_ALIGNED_List.txt';
fid = fopen(F)
data = textscan(fid,'%s');
fclose(fid)
files = data{1};
for i = 1:length(files)
    files2{i} = [files{i}(1:end-3) '_PREDICTED_2.h5'];
end

fid = fopen('TEST_PRED_2_List.txt','wt');
for i = 1:length(files2)
    fprintf(fid,[files2{i} '\n']);
end
fclose(fid)

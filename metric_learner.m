load('metric_learning.mat');
avgdis=(fda(:)+klfda(:)+lfda(:))/3;
dis=reshape(avgdis,[size(fda,1) size(fda,2)]);
save('metric_learning.mat','dis','-append');
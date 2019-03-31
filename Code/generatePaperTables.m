regularCorr = zeros(1, 22);
regularCorrJOSS = zeros(1, 22);
regularCorrTROIKA = zeros(1, 22);
spearmanCorr = zeros(1, 22);
spearmanCorrTROIKA = zeros(1, 22);
spearmanCorrJOSS = zeros(1, 22);
kendallCorr = zeros(1, 22);
kendallCorrTROIKA = zeros(1, 22);
kendallCorrJOSS = zeros(1, 22);
MAE = zeros(1, 22);
MAETROIKA = zeros(1, 22);
MAEJOSS = zeros(1, 22);
for k = 1:22
    eval(sprintf('load result/result%d.mat', k));
    regularCorr(k) = corr(hr, BPM0);
    spearmanCorr(k) = corr(hr, BPM0, 'type', 'Spearman');
    kendallCorr(k) = corr(hr, BPM0, 'type', 'Kendall');
    MAE(k) = mean(abs(hr - BPM0));
end
for k = 1:22
    load(sprintf('JOSSresult/JOSSresult%d', k));
    regularCorrJOSS(k) = corr(BPM', BPM0);
    spearmanCorrJOSS(k) = corr(BPM', BPM0, 'type', 'Spearman');
    kendallCorrJOSS(k) = corr(BPM', BPM0, 'type', 'Kendall');
    MAEJOSS(k) = mean(abs(BPM' - BPM0));
end
for k = 1:22
    load(sprintf('TROIKAresult/TROIKAresult%d', k));
    regularCorrTROIKA(k) = corr(BPM', BPM0);
    spearmanCorrTROIKA(k) = corr(BPM', BPM0, 'type', 'Spearman');
    kendallCorrTROIKA(k) = corr(BPM', BPM0, 'type', 'Kendall');
    MAETROIKA(k) = mean(abs(BPM' - BPM0));
end
TABLE1 = [mean(regularCorrTROIKA), mean(spearmanCorrTROIKA), mean(kendallCorrTROIKA), mean(MAETROIKA);...
    mean(regularCorrJOSS), mean(spearmanCorrJOSS), mean(kendallCorrJOSS), mean(MAEJOSS);...
    mean(regularCorr), mean(spearmanCorr), mean(kendallCorr), mean(MAE)]
TABLE2 = [mean(regularCorrTROIKA(11:22)), mean(spearmanCorrTROIKA(11:22)), mean(kendallCorrTROIKA(11:22)), mean(MAETROIKA(11:22));...
    mean(regularCorrJOSS(11:22)), mean(spearmanCorrJOSS(11:22)), mean(kendallCorrJOSS(11:22)), mean(MAEJOSS(11:22));...
    0.989 0 0 1.83;...
    mean(regularCorr(11:22)), mean(spearmanCorr(11:22)), mean(kendallCorr(11:22)), mean(MAE(11:22))]
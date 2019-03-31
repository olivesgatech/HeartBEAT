%% test the algorithm on more competition data
correlation = zeros(22, 1);
meandeviation = zeros(22, 1);
global t;
for k = 1
    display(sprintf('No. %d', k));
    t = 1;
    if any(k == [1 2 6 8])
        load(sprintf('data/TEST_S0%d_T01.mat', k));
        load(sprintf('data/True_S0%d_T01.mat', k));
    elseif k == 9
        load(sprintf('data/TEST_S02_T02.mat'));
        load(sprintf('data/True_S02_T02.mat'));
    elseif k == 10
        load(sprintf('data/TEST_S06_T02.mat'));
        load(sprintf('data/True_S06_T02.mat'));
    elseif k <= 10
        load(sprintf('data/TEST_S0%d_T02.mat', k));
        load(sprintf('data/True_S0%d_T02.mat', k));
    else
        n = k - 10;
        if n == 1
            load('data/DATA_01_TYPE01.mat');
            load('data/DATA_01_TYPE01_BPMtrace.mat');
        elseif n < 10
            load(sprintf('data/DATA_0%d_TYPE02.mat', n));
            load(sprintf('data/DATA_0%d_TYPE02_BPMtrace.mat', n));
        else
            load(sprintf('data/DATA_%d_TYPE02.mat', n));
            load(sprintf('data/DATA_%d_TYPE02_BPMtrace.mat', n));
        end
    end
    if k <= 10
        sig = [zeros(1, size(sig, 2)); sig];
    end
    fs = 125;
    hr = analyzePPG_general(sig, fs);
    correlation(k, 1) = corr(hr, BPM0);
    display(sprintf('Correlation: %0.4f', corr(hr, BPM0)))
    meandeviation(k, 1) = mean(abs(hr - BPM0));
    display(sprintf('mean of deviation1: %0.4f', mean(abs(hr - BPM0))))
    eval(sprintf('save result%d.mat hr BPM0', k));
end
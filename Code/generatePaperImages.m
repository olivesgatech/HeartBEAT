close all
clc

for iteration = 1:2
    if iteration == 1
        load('fig_data/fig4_data.mat')
    else
        load('fig_data/fig5_data.mat')
    end
load('data/DATA_01_TYPE01_BPMtrace.mat')
data1_spectrum = periodogram(data1, [], 1e5, 125);
data2_spectrum = periodogram(data2, [], 1e5, 125);
fsize = 24;
figure('Unit', 'Normalized', 'Position', [0.2 0.4 0.6 0.4])
hold on
range = indexlimits(1):indexlimits(2);
plot([BPM0(index), BPM0(index)]/60, [0 1], 'k', 'LineWidth', 2)
plot(range/5e4*62.5, data1_spectrum(range)/max(data1_spectrum(range)), 'LineWidth', 2)
plot(range/5e4*62.5, data1_filtered_spectrum(range)/max(data1_filtered_spectrum(range)), 'LineWidth', 2)
xlabel('Frequency (Hz)', 'FontSize', fsize)
ylabel('Spectral Density', 'FontSize', fsize)
legend('ground truth', 'before', 'after')
set(gca, 'FontSize', fsize)
xlim([0.6 4])
figure('Unit', 'Normalized', 'Position', [0.2 0.4 0.6 0.4])
hold on
plot([BPM0(index), BPM0(index)]/60, [0 1], 'k', 'LineWidth', 2)
plot(range/5e4*62.5, data2_spectrum(range)/max(data2_spectrum(range)), 'LineWidth', 2)
plot(range/5e4*62.5, data2_filtered_spectrum(range)/max(data2_filtered_spectrum(range)), 'LineWidth', 2)
ylabel('Spectral Density', 'FontSize', fsize)
xlabel('Frequency (Hz)', 'FontSize', fsize)
legend('ground truth', 'before', 'after')
set(gca, 'FontSize', fsize)
xlim([0.6 4])
figure('Unit', 'Normalized', 'Position', [0.2 0.4 0.6 0.4])
hold on
plot([BPM0(index), BPM0(index)]/60, [0 1], 'k', 'LineWidth', 2)
plot(range/5e4*62.5, xacc_fft(range)/max(xacc_fft(range)), 'LineWidth', 2)
plot(range/5e4*62.5, yacc_fft(range)/max(yacc_fft(range)), 'LineWidth', 2)
plot(range/5e4*62.5, zacc_fft(range)/max(zacc_fft(range)), 'LineWidth', 2)
xlabel('Frequency (Hz)', 'FontSize', fsize)
ylabel('Spectral Density', 'FontSize', fsize)
legend('ground truth', 'X', 'Y', 'Z')
set(gca, 'FontSize', fsize)
xlim([0.6 4])
end
%% compare periodogram with fft
load('data/DATA_01_TYPE01_BPMtrace.mat')
load('fig_data/fftPeriodogramComparison.mat')
data1_periodogram = periodogram(data1, [], 1e5, 125);
data1_fft = abs(fft(data1));
fsize = 24;
figure('Unit', 'Normalized', 'Position', [0.2 0.4 0.6 0.4])
range = indexlimits(1):indexlimits(2);
plot(range/5e4*62.5,data1_periodogram(range)/max(data1_periodogram(range)), 'LineWidth', 2)
xlabel('Frequency (Hz)', 'FontSize', fsize )
ylabel('Normalized Magnitude', 'FontSize', fsize)
set(gca, 'FontSize', fsize)
xlim([0.6 4])
hold on
plot((5:32)/1000*125, data1_fft(5:32)/max(data1_fft(5:32)), 'r', 'LineWidth', 2)
legend('periodogram', 'fft')
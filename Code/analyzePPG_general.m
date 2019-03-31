function hr = analyzePPG_general(sig, fs)
    global t;
    maxHRC = 12;
    PPG1 = sig(2, :);
    PPG2 = sig(3, :);
    xacc = sig(4, :);
    yacc = sig(5, :);
    zacc = sig(6, :);
    len = length(PPG1);
    duration = floor(len/fs);
    wsize = 8;
    offs = 0;
    hr = zeros(length(wsize:2:duration), 1);
    previous_value_counter = 0;
    predict_counter = 0;
    for k = wsize:2:duration
        display(sprintf('%d', t));
        hrls1_1 = dsp.RLSFilter('Length', 16, 'Method', 'Householder RLS');
        hrls1_2 = dsp.RLSFilter('Length', 16, 'Method', 'Householder RLS');
        hrls1_3 = dsp.RLSFilter('Length', 16, 'Method', 'Householder RLS');
        hrls2_1 = dsp.RLSFilter('Length', 16, 'Method', 'Householder RLS');
        hrls2_2 = dsp.RLSFilter('Length', 16, 'Method', 'Householder RLS');
        hrls2_3 = dsp.RLSFilter('Length', 16, 'Method', 'Householder RLS');
        range = ((k-wsize)*fs+1):(k*fs);
        data1 = PPG1(((k-wsize)*fs+1):(k*fs));
        data2 = PPG2(((k-wsize)*fs+1):(k*fs));

        [~, ~] = step(hrls1_1, xacc(range), data1);
        [~, err1_1] = step(hrls1_1, xacc(range), data1);
        [~, ~] = step(hrls1_2, yacc(range), err1_1);
        [~, err1_2] = step(hrls1_2, yacc(range), err1_1);
        [~, ~] = step(hrls1_3, zacc(range), err1_2);
        [~, err1_3] = step(hrls1_3, zacc(range), err1_2);
        data1_filtered_spectrum = periodogram(err1_3, [], 1e5, 125);
        %
        [~, ~] = step(hrls2_1, xacc(range), data2);
        [~, err2_1] = step(hrls2_1, xacc(range), data2);
        [~, ~] = step(hrls2_2, yacc(range), err2_1);
        [~, err2_2] = step(hrls2_2, yacc(range), err2_1);
        [~, ~] = step(hrls2_3, zacc(range), err2_2);
        [~, err2_3] = step(hrls2_3, zacc(range), err2_2);
        data2_filtered_spectrum = periodogram(err2_3, [], 1e5, 125);

        indexlimits = [534 3200];
        [pks1, locs1] = findthreepeaks(data1_filtered_spectrum(indexlimits(1):...
            indexlimits(2)), 75);
        [pks2, locs2] = findthreepeaks(data2_filtered_spectrum(indexlimits(1):...
            indexlimits(2)), 75);
        locs1 = (locs1+indexlimits(1)-1)/(1e5/2+1)*62.5*60;
        locs2 = (locs2+indexlimits(1)-1)/(1e5/2+1)*62.5*60;

        locs1(pks1< 0.6*max(pks1)) = [];
        pks1(pks1< 0.6*max(pks1)) = [];
        locs2(pks2< 0.6*max(pks2)) = [];
        pks2(pks2< 0.6*max(pks2)) = [];
        pks = [pks1; pks2/max(pks2)*max(pks1)];
        locs = [locs1; locs2];

        index = (k-wsize)/2 + offs + 1;
        if index == 22 || index == 81 || index == 88 || index == 90
        end
        plot(t, locs, 'k.', 'MarkerSize', 10)
        t = t+1;
        drawnow;
        % heart rate changing constraint:
        if index > 3
            locs_der = abs(locs-hr(index-1));
            locs_der_valid = locs_der < maxHRC;
        end
        if index <=3
            indices = locs >= 180;
            locs(indices) = [];
            pks(indices) = [];
            [~, indices] = max(pks);
            hr(index) = locs(indices);
            maxHRC = 12;
            predict_counter = 0;
            previous_value_counter = 0;
        elseif  sum(locs_der_valid) == 1 
            hr(index) = locs(locs_der_valid);
            maxHRC = 12;
            predict_counter = 0;
            previous_value_counter = 0;
        elseif sum(locs_der_valid) >= 2
            pks(~locs_der_valid) = [];
            locs(~locs_der_valid) = [];
            [maxpks, maxpksloc] = max(pks);
            also_valid = pks > 0.4 * maxpks;
            if sum(also_valid) == 1
                hr(index) = locs(maxpksloc);
            else
                [~, min_der_pos] = min(abs(locs-hr(index-1)));
                hr(index) = locs(min_der_pos);
            end
            maxHRC = 12;
            predict_counter = 0;
            previous_value_counter = 0;
        elseif previous_value_counter <= 4
            hr(index) = hr(index-1);
            maxHRC = 24 + previous_value_counter * 5;
            previous_value_counter = previous_value_counter + 1;
        else
            predict_counter = predict_counter + 1;
            if index > 10
                hr_predict = polyval(polyfit(index-10:index-1, hr(index-10:index-1)', 1), index);
            else
                hr_predict = polyval(polyfit(1:index-1, hr(1:index-1)', 1), index);
            end
            if hr_predict > hr(index-1)
                hr(index) = hr(index-1) + 5;
            else
                hr(index) = hr(index-1) - 5;
            end
            maxHRC = 24 + predict_counter * 8;
        end
    end
end
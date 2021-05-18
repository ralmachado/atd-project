function activityDFT(data, labels, activities, find, cells, threshold)
    arguments
        data
        labels
        activities
        find
        cells
        threshold = 0.4
    end
    Fs = 50;
    for i = 1:size(labels, 1)
        activityNum = labels(i,3);
        % Skip activities different than param. activity
        if (activityNum ~= find)
            continue
        end
        activity = string(activities(activityNum));
        
        start_t = labels(i, 4);
        end_t = labels(i,5);
        N = end_t - start_t + 1;
        deltaF = Fs/N;
        
        % Adjust frequency axis
        if mod(N, 2) == 0
            f = -Fs/2:deltaF:Fs/2-deltaF;
        else
            f = -Fs/2+deltaF/2:deltaF:Fs/2-deltaF/2;
        end
        
        window = start_t:end_t;
        hammingWindow = hamming(N);
        X = data(window, 1);
        Y = data(window, 2);
        Z = data(window, 3);
        
        % Detrend dynamic or transition activities
        if (activityNum > 3) && (activityNum < 7)
            X = X.*hammingWindow;
            Y = Y.*hammingWindow;
            Z = Z.*hammingWindow;
        else
            X = detrend(data(window, 1)).*hammingWindow;
            Y = detrend(data(window, 2)).*hammingWindow;
            Z = detrend(data(window, 3)).*hammingWindow;
        end
        
        dftX = abs(fftshift(fft(X)));
        dftY = abs(fftshift(fft(Y)));
        dftZ = abs(fftshift(fft(Z)));
        thresholdX = threshold*max(dftX);
        thresholdY = threshold*max(dftY);
        thresholdZ = threshold*max(dftZ);
        
        cleanX = dftX;
        cleanX(cleanX < thresholdX) = 0;
        cleanY = dftY;
        cleanY(cleanY < thresholdY) = 0;
        cleanZ = dftZ;
        cleanZ(cleanZ < thresholdZ) = 0;
        [pksX, locsX]= findpeaks(cleanX);
        [pksY, locsY]= findpeaks(cleanY);
        [pksZ, locsZ]= findpeaks(cleanZ);
        
        for i = 1:length(pksX)
            freq = f(locsX(i));
            if (freq >= 0)
                mag = pksX(i);
                if (freq == 0)
                    amp = mag/N;
                else
                    amp = 2*mag/N;
                end
                cells(1,:) = {cells(1,:) [freq amp]};
            end
        end
        
        for i = 1:length(pksY)
            freq = f(locsY(i));
            if (freq >= 0)
                mag = pksY(i);
                if (freq == 0)
                    amp = mag/N;
                else
                    amp = 2*mag/N;
                end
            end
        end
        
        for i = 1:length(pksZ)
            freq = f(locsZ(i));
            if (freq >= 0)
                if (freq == 0)
                    amp = mag/N;
                else
                    amp = 2*mag/N;
                end
                cells(3,:) = {cells(3,:) [freq amp]};
            end
        end
    end
end
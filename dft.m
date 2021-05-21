function dft(data, labels, activities, find, file, showPlot, showFreq, threshold)
    arguments
        data
        labels
        activities
        find
        file = 1
        showPlot = false
        showFreq = true
        threshold = 0.60
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
        X = signalTreat(data(window, 1));
        Y = signalTreat(data(window, 2));
        Z = signalTreat(data(window, 3));
        
        % Detrend dynamic or transition activities
        if (activityNum < 4) || (activityNum > 6)
            X = detrend(X);
            Y = detrend(Y);
            Z = detrend(Z);
        end
        
        dftX = abs(fftshift(fft(X)));
        dftY = abs(fftshift(fft(Y)));
        dftZ = abs(fftshift(fft(Z)));
        thresholdX = threshold*max(dftX);
        thresholdY = threshold*max(dftY);
        thresholdZ = threshold*max(dftZ);
        
        if (showPlot == true)
            figure('Name', sprintf("Atividade: %s", activity), 'NumberTitle', 'off');

            subplot(3,1,1)
            plot(f, dftX)
            hold on
            plot(f, repmat(thresholdX,length(f)), 'color', 'r')
            title("Hamming DFT X")
            xlabel("Frequency (Hz)")
            ylabel("Magnitude")
            subplot(3,1,2)
            plot(f, dftY)
            hold on
            plot(f, repmat(thresholdY,length(f)), 'color', 'r')
            title("Hamming DFT Y")
            xlabel("Frequency (Hz)")
            ylabel("Magnitude")
            subplot(3,1,3)
            plot(f, dftZ)
            hold on
            plot(f, repmat(thresholdZ,length(f)), 'color', 'r')
            title("Hamming DFT Z")
            xlabel("Frequency (Hz)")
            ylabel("Magnitude")
        end
   
        if (showFreq == true)
            cleanX = dftX;
            cleanX(cleanX < thresholdX) = 0;
            cleanY = dftY;
            cleanY(cleanY < thresholdY) = 0;
            cleanZ = dftZ;
            cleanZ(cleanZ < thresholdZ) = 0;
            [pksX, locsX]= findpeaks(cleanX);
            [pksY, locsY]= findpeaks(cleanY);
            [pksZ, locsZ]= findpeaks(cleanZ);
            fprintf(file, "Activity: %s\n", activity);
            fprintf(file, "Relevant Frequencies (x axis)\n");
            j = 0;
            for i = 1:length(pksX)
                freq = f(locsX(i));
                if (freq >= 0)
                    mag = pksX(i);
                    if (freq == 0)
                        amp = mag/N;
                    else
                        amp = 2*mag/N;
                    end
                    fprintf(file, "Freq: %.2f Hz | Amplitude: %.2f\n", freq, amp);
                    j = j + 1;
                    if (j == 3)
                        break;
                    end
                end
            end
            j = 0;
            fprintf(file, "Relevant Frequencies (y axis)\n");
            for i = 1:length(pksY)
                freq = f(locsY(i));
                if (freq >= 0)
                    mag = pksY(i);
                    if (freq == 0)
                        amp = mag/N;
                    else
                        amp = 2*mag/N;
                    end
                    fprintf(file, "Freq: %.2f Hz | Amplitude: %.2f\n", freq, amp); 
                    j = j + 1;
                    if (j == 3)
                        break;
                    end
                end
            end
            j = 0;
            fprintf(file, "Relevant Frequencies (z axis)\n");
            for i = 1:length(pksZ)
                freq = f(locsZ(i));
                if (freq >= 0)
                    if (freq == 0)
                        amp = mag/N;
                    else
                        amp = 2*mag/N;
                    end
                    fprintf(file, "Freq: %.2f Hz | Amplitude: %.2f\n", freq, amp); 
                    j = j + 1;
                    if (j == 3)
                        break;
                    end
                end
            end
        end
        if (file ~= 1) 
            fprintf(file, "-----------------------------------\n");
        end
    end
end
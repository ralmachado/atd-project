function windowedDFT(data, labels, activities, dynamic, showWV, wvI)
    arguments
        data
        labels
        activities 
        dynamic = true
        showWV = false
        wvI = 1
    end
    
    Fs = 50;
    counters = zeros(1,12);
    for i = 1:size(labels, 1)
        %% Setting up the signal segment
        activityNum = labels(i,3);
        if (activityNum ~= 1)
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
        
        figure('Name', sprintf("%s - Janelas p/ DFT", activity));
        
        %% Rectangular window
        window = start_t:end_t;
        X = data(window, 1);
        Y = data(window, 2);
        Z = data(window, 3);
        dftX = abs(fftshift(fft(X)));
        dftY = abs(fftshift(fft(Y)));
        dftZ = abs(fftshift(fft(Z)));
        
        subplot(3,4,1)
        plot(f, dftX)
        title("DFT X")
        xlabel("Frequency (Hz)")
        ylabel("Magnitude")
        subplot(3,4,5)
        plot(f, dftY)
        title("DFT Y")
        xlabel("Frequency (Hz)")
        ylabel("Magnitude")
        subplot(3,4,9)
        plot(f, dftZ)
        title("DFT Z")
        xlabel("Frequency (Hz)")
        ylabel("Magnitude")
        
        %% Hamming Window
        hammingWindow = hamming(N);
        windowedX = X.*hammingWindow;
        windowedY = Y.*hammingWindow;
        windowedZ = Z.*hammingWindow;
        
        dftX = abs(fftshift(fft(windowedX)));
        dftY = abs(fftshift(fft(windowedY)));
        dftZ = abs(fftshift(fft(windowedZ)));
        
        subplot(3,4,2)
        plot(f, dftX)
        title("Hamming DFT X")
        xlabel("Frequency (Hz)")
        ylabel("Magnitude")
        subplot(3,4,6)
        plot(f, dftY)
        title("Hamming DFT Y")
        xlabel("Frequency (Hz)")
        ylabel("Magnitude")
        subplot(3,4,10)
        plot(f, dftZ)
        title("Hamming DFT Z")
        xlabel("Frequency (Hz)")
        ylabel("Magnitude")
        
        %% Hann Window
        hannWindow = hann(N);
        windowedX = X.*hannWindow;
        windowedY = Y.*hannWindow;
        windowedZ = Z.*hannWindow;
        
        dftX = abs(fftshift(fft(windowedX)));
        dftY = abs(fftshift(fft(windowedY)));
        dftZ = abs(fftshift(fft(windowedZ)));
        
        subplot(3,4,3)
        plot(f, dftX)
        title("Hann DFT X")
        xlabel("Frequency (Hz)")
        ylabel("Magnitude")
        subplot(3,4,7)
        plot(f, dftY)
        title("Hann DFT Y")
        xlabel("Frequency (Hz)")
        ylabel("Magnitude")
        subplot(3,4,11)
        plot(f, dftZ)
        title("Hann DFT Z")
        xlabel("Frequency (Hz)")
        ylabel("Magnitude")
        
        %% Blackman Window
        blackmanWindow = blackman(N);
        windowedX = X.*blackmanWindow;
        windowedY = Y.*blackmanWindow;
        windowedZ = Z.*blackmanWindow;
        
        dftX = abs(fftshift(fft(windowedX)));
        dftY = abs(fftshift(fft(windowedY)));
        dftZ = abs(fftshift(fft(windowedZ)));
        
        subplot(3,4,4)
        plot(f, dftX)
        title("Blackman DFT X")
        xlabel("Frequency (Hz)")
        ylabel("Magnitude")
        subplot(3,4,8)
        plot(f, dftY)
        title("Blackman DFT Y")
        xlabel("Frequency (Hz)")
        ylabel("Magnitude")
        subplot(3,4,12)
        plot(f, dftZ)
        title("Blackman DFT Z")
        xlabel("Frequency (Hz)")
        ylabel("Magnitude")
        
        %% Update the counter
        counters(activityNum) = 1;
        if (showWV == true) && (i == wvI)
            wvtool(hammingWindow, hannWindow, blackmanWindow);
        end
        return
    end
end
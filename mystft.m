function specFig = mystft(data, tFrame)
    arguments
        data
        tFrame = 4;
    end
    
    Fs = 50;
    Ts = 1/Fs;
    N = length(data);
    if adftest(data) == 0
        data = detrend(data);
    end
    data = signalTreat(data);
    time = linspace(0, (N-1)*Ts, N);
    
    %{
    tFrame = N*Ts;
    for i = 1:length(expLabels)
        temp = expLabels(i,5) - expLabels(i,4);
        if temp < tFrame
            tFrame = temp;
        end
    end
    tFrame = tFrame*Ts;
    %}
    
    tOverlap = tFrame/2; % Overlap at half time
    nFrame = round(tFrame*Fs);
    nOverlap = round(tOverlap*Fs);
    
    if mod(nFrame, 2) == 0
        fFrame = -(Fs/2):Fs/nFrame:(Fs/2)-(Fs/nFrame);
    else
        fFrame = -(Fs/2)+(Fs/nFrame/2):Fs/nFrame:(Fs/2)-(Fs/nFrame/2);
    end
    
    h = hamming(nFrame);
    specFig = figure('Name', 'Spectrogram', 'NumberTitle', 'off');
    spectrogram(data, nFrame, nOverlap, [], Fs, 'yaxis');
    
    freqRelev = [];
    nFrames = 0;
    tFrames = [];
    for ii = 1:nFrame-nOverlap:N-nFrame+1
        xFrame = data(ii:ii+nFrame-1).*h;
        magFrame = abs(fftshift(fft(xFrame)));
        maxMag = max(magFrame);
        ind = find(abs(magFrame-maxMag) < 0.001);
        if length(ind) == 2
            freqRelev = [freqRelev fFrame(ind(2))];
        else
            freqRelev = [freqRelev fFrame(ind(1))];
        end
        nFrames = nFrames + 1;
        tFrame = time(ii:ii+nFrame-1);
        tFrames = [tFrames tFrame(round(nFrame/2+1))];
    end
    
    figure('Name', 'Relevant Frequencies', 'NumberTitle', 'off');
    tFrames = tFrames./60;
    plot(tFrames, freqRelev, 'o');
    axis('normal');
    xlabel('Time (min)');
    ylabel('Frequency (Hz)');
end
function sftf(data)
    fs=50;
    Ts=1/fs;
    N = numel(data);
    
    %time = linspace(0,(N-1)*Ts,N);
    time = 0;
    tFrame = 0;
    tOverlap = 0;
    
    nFrame = round(tFrame*fs);
    nOverlap = round(tOverlap*fs);
    
    h = hamming(Nframe);
    
    if mod(N,2) == 0
        f = -Fs/2:Fs/N:Fs/2-Fs/N;
    else
        f = -Fs/2+(Fs/N/2):Fs/N:Fs/2-(Fs/N/2);
    end
    
    fin = [];
    for ii = 1:nFrame-nOverlap:N-nFrame+1
        dFrame = data(ii:ii+nFrame-1).*h;
        mFrame = abs(fftshift(fft(dFrame)));
        fin = horzcat(fin,mFrame(x));
    end
    
    figure('Name','STFT ',' NumberTitle', 'off');
    waterfall(20*log10(fin))
    figure('Name', 'STFT', 'NumberTitle','off');
    imagesec(20*log10(fin))
end
function stft(data)
    fs=50;
    Ts=1/fs;
    N = numel(data);
    
    t = N*Ts;
    tFrame = 0;
    tOverlap = 0.050;
    
    nFrame = round(tFrame*fs);
    nOverlap = round(tOverlap*fs);
    
    h = hamming(nFrame);
    
    if(mod(nFrame,2))==0
       f = -fs/2:fs/nFrame:fs/2-fs/nFrame;
    else
        f = -fs/2+fs/(2*nFrame):fs/nFrame:fs/2-fs/(2*nFrame);
    end
    
    x = find(f>=0);
    fin = [];
    for ii = 1:nFrame-nOverlap:N-nFrame+1
        dFrame = data(ii:ii+nFrame-1).*h;
        mFrame = abs(fftshift(fft(dFrame)));
        fin = horzcat(fin,mFrame(x));
    end
    
    figure('Name','STFT','NumberTitle', 'off');
    waterfall(20*log10(fin))
    figure('Name', 'STFT', 'NumberTitle','off');
    imagesec(20*log10(fin))    
end
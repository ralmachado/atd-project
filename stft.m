function sftf(data)
    fs=50;
    Ts=1/fs;
    N = numel(data);
    if mod(N,2) == 0
        f = -Fs/2:Fs/N:Fs/2-Fs/N;
    else
        f = -Fs/2+(Fs/N/2):Fs/N:Fs/2-(Fs/N/2);
    end
    
    %time = linspace(0,(N-1)*Ts,N);
    time = 0;
    tFrame = 0;
    tOverlap = 0;
    
    
    
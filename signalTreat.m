function cleanData = signalTreat(data)
    % Find NaN and extrapolate missing values
    idx = find(isnan(data));
    cleanData = data;
    if ~(isempty(idx))
        for i = 1:length(idx)
            cleanData(idx(i)) = pchip(idx(i)-4:idx(i)-1, data(idx(i)-4:idx(i)-1), idx(i));
        end
    end
    
    dataMean = mean(data);
    dataDev = std(data);
    
    % Find any outliers and replace values
    outliers = find(abs(cleanData-dataMean) > 3*dataDev);
    factor = 1.5 * dataDev;
    for i = 1:length(outliers)
        if cleanData(outliers(i)) > dataMean
            cleanData(outliers(i)) = dataMean + factor;
        else
            cleanData(outliers(i)) = dataMean - factor;
        end
    end
end
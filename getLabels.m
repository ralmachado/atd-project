function expLabels = getLabels(expNum, labels)
    expLabels = labels(labels(:,1) == expNum, :);
end
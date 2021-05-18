function [labels, legend]=importLabels()
    labels = readmatrix('dataset\labels.txt', 'Range', '168:329');
    legend = readcell('dataset\activity_labels.txt', 'Range', 'C:C');
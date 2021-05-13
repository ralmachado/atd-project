%% Import experiment data
condition = exist("data.mat", "file");
if (condition == 0)
    exp09 = getData('dataset\acc_exp09_user05.txt');
    exp10 = getData('dataset\acc_exp10_user05.txt');
    exp11 = getData('dataset\acc_exp11_user06.txt');
    exp12 = getData('dataset\acc_exp12_user06.txt');
    exp13 = getData('dataset\acc_exp13_user07.txt');
    exp14 = getData('dataset\acc_exp14_user07.txt');
    exp15 = getData('dataset\acc_exp15_user08.txt');
    exp16 = getData('dataset\acc_exp16_user08.txt');
    [labels, legend] = getLabels();
    save data.mat
else
    load data.mat
end

%% Ex. 2 - Plot signal, identifying activities

Experiment = input("Experiment no.: ");
switch Experiment
    case 9
        data = exp09;
        num = 9;
    case 10
        data = exp10;
        num = 10;
    case 11
        data = exp11;
        num = 11;
    case 12
        data = exp12;
        num = 12;
    case 13
        data = exp13;
        num = 13;
    case 14
        data = exp14;
        num = 14;
    case 15
        data = exp15;
        num = 15;
    case 16
        data = exp16;
        num = 16;
    otherwise
        disp("Invalid Experiment")
        return
end

plotAcc(data, num, labels, legend, sprintf('Experiment %d', num));

%% Ex. 3
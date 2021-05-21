%% Ex. 1 - Import experiment data
condition = exist("data.mat", "file");
if (condition == 0)
    exp09 = importData('dataset\acc_exp09_user05.txt');
    exp10 = importData('dataset\acc_exp10_user05.txt');
    exp11 = importData('dataset\acc_exp11_user06.txt');
    exp12 = importData('dataset\acc_exp12_user06.txt');
    exp13 = importData('dataset\acc_exp13_user07.txt');
    exp14 = importData('dataset\acc_exp14_user07.txt');
    exp15 = importData('dataset\acc_exp15_user08.txt');
    exp16 = importData('dataset\acc_exp16_user08.txt');
    [labels, activities] = importLabels();
    save data.mat
else
    load data.mat
end

%% Ex. 2 - Plot signal, identifying activities

% experiment = input("Experiment no.: ");
experiment = 9;
switch experiment
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
expLabels = getLabels(num, labels);
plotAcc(data, num, expLabels, activities, sprintf('Experiment %d', num));

%% Ex. 3.1
windowedDFT(data, expLabels, activities);

%% Ex. 3.2
suffix = ["w.txt", "wu.txt", "wd.txt", "sit.txt", "stand.txt", "lay.txt", "stand2sit.txt", "sit2stand.txt", "sit2lie.txt", "lie2sit.txt", "stand2lie.txt", "lie2stand.txt"];
filenames = ["dft\exp09_", "dft\exp10_", "dft\exp11_", "dft\exp12_", "dft\exp13_", "dft\exp14_", "dft\exp15_", "dft\exp16_"];
experiments = {exp09 exp10 exp11 exp12 exp13 exp14 exp15 exp16};

for i=1:length(filenames)
    expLabels = getLabels(8+i, labels);
    for j = 1:length(suffix)
        file = fopen(strcat(filenames(i), suffix(j)), "w+");
        dft(experiments{i}, expLabels, activities, j, file);
        fclose(file);
    end
    % Finish this
end
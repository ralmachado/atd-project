function plotAcc(data, labels, activities, plotTitle)
    % Plotting accelerometer data
    arguments
        data
        labels
        activities
        plotTitle = 'Accelerometer data'
    end
    %% Signal properties and data division
    Ts = 1/50;
    N = size(data,1);
    ylabels = ["ACC\_X", "ACC\_Y", "ACC\_Z"];
    t = linspace(0, Ts*(N-1)/60, N);
    start_t = labels(:,4);
    end_t = labels(:,5);

    %% Plotting data
    uppos = max(data);
    downpos = min(data);
    figure('Name', "Signal Plot");
   
    % Simple plotting (no colored activity segments)
    for j=1:3
            subplot(3, 1, j);        
            plot(t, data(:,j), 'Color', 'k');
            ylabel(ylabels(j));
            xlabel("Time (min)");
            axis('tight');
            ylim([downpos(j)-0.5 uppos(j)+0.5]);
            if (j == 1) 
                title(plotTitle);
            end
            hold on
    end
    
    % Drawing over the activity segments (MatLab automatically cycles
    % colors)
    for j=1:3
        subplot(3,1,j);
        for i=1:size(labels, 1)
            plot(t(start_t(i):end_t(i)), data(start_t(i):end_t(i),j));
            if (mod(i,2) == 0)
                text(start_t(i)*Ts/60, uppos(j), activities(labels(i,3)), 'FontSize', 8);
            else
                text(start_t(i)*Ts/60, downpos(j), activities(labels(i,3)), 'FontSize', 8);
            end
        end
    end
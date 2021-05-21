function acc=importData(filename)
    arguments
        filename {mustBeText}
    end
    
    % Set import options
    opts = delimitedTextImportOptions("NumVariables", 3);
    opts.VariableTypes = ["double", "double", "double"];
    opts.Delimiter = ' ';
    opts.EmptyLineRule = 'read';
    opts.ExtraColumnsRule = 'ignore';
    opts.ConsecutiveDelimitersRule = 'join';
    opts.LeadingDelimitersRule = 'ignore';
    opts.TrailingDelimitersRule = 'ignore';
    
    % Import data to table
    acc = readmatrix(filename, opts);
    
    % acc = readmatrix(filename);
    % N = size(acc, 1);
    % Omega0 = 2*pi/N;
    % resolution = Fs/N;
end
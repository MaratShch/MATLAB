function checkMLToolboxes()
    % Get MATLAB version
    matlabVersion = ver('MATLAB');
    fprintf('MATLAB Version: %s\n\n', matlabVersion.Version);

    % List of essential toolboxes for machine learning in MATLAB
    requiredToolboxes = {
        'Statistics and Machine Learning Toolbox'
        'Deep Learning Toolbox'
        'Computer Vision Toolbox'
        'Parallel Computing Toolbox'
        'Optimization Toolbox'
    };

    % Get the list of installed toolboxes
    installedToolboxes = ver;

    % Extract the names of installed toolboxes
    installedNames = {installedToolboxes.Name};

    % Initialize flag for missing toolboxes
    allToolboxesInstalled = true;

    % Check each required toolbox
    for i = 1:length(requiredToolboxes)
        if ismember(requiredToolboxes{i}, installedNames)
            fprintf('%s is installed.\n', requiredToolboxes{i});
        else
            fprintf('%s is NOT installed.\n', requiredToolboxes{i});
            allToolboxesInstalled = false;
        end
    end

    % Final status
    if allToolboxesInstalled
        fprintf('\nAll required machine learning toolboxes are installed.\n');
    else
        fprintf('\nSome required machine learning toolboxes are missing.\n');
    end
end
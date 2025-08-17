%% Simulate CGA/EGA with selectable palette
% Matlab R2018b

clear; clc;

%% ---- User settings ----
filename = '.\image\Input.png';  % Input image
palette_type = 'CGA2';         % Options: 'CGA1', 'CGA2', 'EGA'

% Virtual resolution
switch upper(palette_type)
    case {'CGA1','CGA2'}
        virtual_width = 320;
        virtual_height = 200;
    case 'EGA'
        virtual_width = 640;
        virtual_height = 350;
    otherwise
        error('Unknown palette type');
end

%% ---- Load image ----
img = imread(filename);
[height, width, ~] = size(img);
img = im2double(img);

%% ---- Define palette ----
switch upper(palette_type)
    case 'CGA1'
        palette = [ ...
            0 0 0;       % Black
            0 1 1;       % Cyan
            1 0 1;       % Magenta/Purple
            1 1 1];      % White
    case 'CGA2'
        palette = [ ...
            0 0 0;       % Black
            1 0 0;       % Red
            0 1 0;       % Green
            1 1 0];      % Yellow
    case 'EGA'
        levels = [0 85/255 170/255 1];
        palette = zeros(64,3);
        idx = 1;
        for r = levels
            for g = levels
                for b = levels
                    palette(idx,:) = [r g b];
                    idx = idx + 1;
                end
            end
        end
end

%% ---- Compute scale factors ----
scaleX = width / virtual_width;
scaleY = height / virtual_height;

%% ---- Create output image ----
output = zeros(size(img));

%% ---- Simulation loop ----
for vy = 1:virtual_height
    for vx = 1:virtual_width
        x_start = floor((vx-1)*scaleX) + 1;
        x_end   = min(floor(vx*scaleX), width);
        y_start = floor((vy-1)*scaleY) + 1;
        y_end   = min(floor(vy*scaleY), height);

        block = img(y_start:y_end, x_start:x_end, :);
        avg_color = squeeze(mean(mean(block,1),2));

        % Map to nearest palette color
        distances = sum((palette - avg_color').^2,2);
        [~, idx] = min(distances);
        mapped_color = palette(idx,:);

        % Fill block in output
        output(y_start:y_end, x_start:x_end, 1) = mapped_color(1);
        output(y_start:y_end, x_start:x_end, 2) = mapped_color(2);
        output(y_start:y_end, x_start:x_end, 3) = mapped_color(3);
    end
end

%% ---- Display and save ----
figure; imshow(output);
imwrite(output, ['simulated_' palette_type '.png']);
disp(['Simulation complete! Saved as simulated_' palette_type '.png']);

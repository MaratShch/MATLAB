%% Simulate CGA/EGA look in HD image
% Matlab R2018b
% Input: HD JPG or PNG image (true color)
% Output: same size, visually simulated CGA/EGA

clear; clc;

%% ---- User settings ----
filename = '.\image\Input.png';  % Input image
palette_type = 'EGA';          % 'CGA' or 'EGA'

% Virtual resolution for simulation
if strcmp(palette_type,'CGA')
    virtual_width = 320;
    virtual_height = 200;
elseif strcmp(palette_type,'EGA')
    virtual_width = 640;
    virtual_height = 350;
else
    error('Unknown palette type');
end

%% ---- Load image ----
img = imread(filename);
[height, width, ~] = size(img);
img = im2double(img);  % convert to 0..1

%% ---- Define palette ----
if strcmp(palette_type,'CGA') || strcmp(palette_type,'EGA')
    % RGB values normalized 0..1
    palette = [
        0   0   0;       % Black
        0   0   170/255; % Blue
        0   170/255 0;   % Green
        0   170/255 170/255; % Cyan
        170/255 0 0;     % Red
        170/255 0 170/255; % Magenta
        170/255 85/255 0; % Brown
        170/255 170/255 170/255; % Light Gray
        85/255 85/255 85/255; % Dark Gray
        85/255 85/255 1; % Light Blue
        85/255 1 85/255; % Light Green
        85/255 1 1;      % Light Cyan
        1 85/255 85/255; % Light Red
        1 85/255 1;      % Light Magenta
        1 1 85/255;      % Yellow
        1 1 1;           % White
    ];
end

%% ---- Compute scale factors ----
scaleX = width / virtual_width;
scaleY = height / virtual_height;

%% ---- Create output image ----
output = zeros(size(img));

%% ---- Simulation loop ----
for vy = 1:virtual_height
    for vx = 1:virtual_width
        % Compute HD block
        x_start = floor((vx-1)*scaleX) + 1;
        x_end   = min(floor(vx*scaleX), width);
        y_start = floor((vy-1)*scaleY) + 1;
        y_end   = min(floor(vy*scaleY), height);

        % Extract block and compute average color
        block = img(y_start:y_end, x_start:x_end, :);
        avg_color = squeeze(mean(mean(block,1),2)); % [R G B]

        % Map to nearest palette color
        distances = sum((palette - avg_color').^2,2); % Euclidean distance
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

disp('Simulation complete!');

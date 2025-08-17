%% Simulate 256-color VGA look in HD image
% Matlab R2018b
% Input: HD JPG or PNG image (true color)
% Output: same size, visually simulated VGA 256-color

clear; clc;

%% ---- User settings ----
filename = '.\image\Input.png';  % Input image

% Virtual resolution for pixelated look (optional)
virtual_width = 320;   % Can choose lower resolution for blocky look
virtual_height = 200;

%% ---- Load image ----
img = imread(filename);
[height, width, ~] = size(img);
img = im2double(img);  % convert to 0..1

%% ---- Build VGA 256-color palette ----

palette = zeros(256,3);

% 0-15: EGA colors (normalized 0..1)
palette(1:16,:) = [
    0 0 0;
    0 0 170/255;
    0 170/255 0;
    0 170/255 170/255;
    170/255 0 0;
    170/255 0 170/255;
    170/255 85/255 0;
    170/255 170/255 170/255;
    85/255 85/255 85/255;
    85/255 85/255 1;
    85/255 1 85/255;
    85/255 1 1;
    1 85/255 85/255;
    1 85/255 1;
    1 1 85/255;
    1 1 1
];

% 16-231: 6x6x6 RGB cube
levels = [0 51 102 153 204 255]/255;
idx = 17;
for r = 1:6
    for g = 1:6
        for b = 1:6
            palette(idx,:) = [levels(r) levels(g) levels(b)];
            idx = idx + 1;
        end
    end
end

% 232-255: grayscale ramp
for i = 232:255
    gray = (8 + (i-232)*10)/255;
    palette(i+1,:) = [gray gray gray];
end

%% ---- Compute scale factors for blocky look ----
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

        % Map to nearest VGA palette color
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
imwrite(output, 'simulated_VGA256.png');

disp('VGA 256-color simulation complete!');

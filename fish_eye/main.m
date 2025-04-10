clc
clear all;
close all;

% 1. Load an image
myImage = imread('peppers.png');

% 2. Call the function
degree = 0.5; % Adjust degree (0 to 1)

% Option 1: Crop mode (Recommended for clean look)
fisheye_cropped = createFisheyeFill(myImage, degree, 'crop');

% Option 2: Clamp mode (Fills frame, might have edge artifacts)
fisheye_clamped = createFisheyeFill(myImage, degree, 'clamp');

% 3. Display the results
figure;
subplot(1, 3, 1); imshow(myImage); title('Original Image');
subplot(1, 3, 2); imshow(fisheye_cropped); title(['Fisheye (Crop), Degree=', num2str(degree)]);
subplot(1, 3, 3); imshow(fisheye_clamped); title(['Fisheye (Clamp), Degree=', num2str(degree)]);
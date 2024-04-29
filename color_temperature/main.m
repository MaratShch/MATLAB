clc;
clear all;
close all;

% Read the input image (assuming it's in the current directory)
input_image = imread('IMG//Ara_macao.jpg');
% Check if the image is in grayscale, convert to RGB if needed
if size(input_image, 3) == 1
    input_image = cat(3, input_image, input_image, input_image);
end

% Get the dimensions of the image
[rows, cols, channels] = size(input_image);

% Check if image is in RGB format
if channels ~= 3
    error('Input image is not in RGB format.');
end

CCT = 8000;
Tint = -0.50;
fprintf("Start Wiener Estimation algoirthm\n");

[adjusted_image, newCCT, newTint] = wiener_estimation (input_image, CCT, Tint);

fprintf("Wiener Estimation algoirthm completed...\n");




clc;
clear all;
close all;

% Read the input image (assuming it's in the current directory)
input_image = imread('IMG//disbalanced//beans.jpg');
% Get the dimensions of the image
[rows, cols, channels] = size(input_image);

% Check if image is in RGB format
if channels ~= 3
    error('Input image is not in RGB format.');
end

CCT = 8000;
Tint = -0.50;
fprintf("Start Perceptual Color Correction algoirthm\n");

float_image = double(input_image) / 255.0;
figure(1);
imshow(float_image);

[adjusted_image] = perceptual_color_correction (float_image, CCT, Tint);
figure(3);
imshow(adjusted_image);


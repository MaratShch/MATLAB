% CIE 1964 color space
% https://en.wikipedia.org/wiki/CIE_1964_color_space
% 10 degrees observer 1964

clc
clear all;
close all;

idx_offset = 379;
lambda = 380:1:750;

x_bar1964 = zeros(size(lambda));
y_bar1964 = zeros(size(lambda));
z_bar1964 = zeros(size(lambda));

% compute x, y and z curves values
for wavelength=lambda
    array_idx = wavelength-idx_offset;
    x_bar1964(array_idx) = x_1964(wavelength);
    y_bar1964(array_idx) = y_1964(wavelength);
    z_bar1964(array_idx) = z_1964(wavelength);
end

hold on;

xlabel('Wavelength in nanometers')
ylabel('CIE-1964 10 degrees observer, standard curves color point')
title('The CIE-1964 XYZ standard observer color matching functions')
w_direction = min(lambda):max(lambda);
p1 = plot(w_direction, x_bar1964, 'red');
hold on;
p2 = plot(w_direction, y_bar1964, 'green');
hold on;
p3 = plot(w_direction, z_bar1964, 'blue');

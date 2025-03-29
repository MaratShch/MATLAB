% CIE 1931 color space
% https://en.wikipedia.org/wiki/CIE_1931_color_space
% 2 degrees observer 1931

clc
clear all;
close all;

idx_offset = 379;
lambda = 380:1:750;

x_bar1931 = zeros(size(lambda));
y_bar1931 = zeros(size(lambda));
z_bar1931 = zeros(size(lambda));

% compute x, y and z curves values
for wavelength=lambda
    array_idx = wavelength-idx_offset;
    x_bar1931(array_idx) = x_1931(wavelength);
    y_bar1931(array_idx) = y_1931(wavelength);
    z_bar1931(array_idx) = z_1931(wavelength);
end

hold on;

xlabel('Wavelength in nanometers')
ylabel('CIE-1931 2 degrees observer, standard curves color point')
title('The CIE-1931 XYZ standard observer color matching functions')
w_direction = min(lambda):max(lambda);
p1 = plot(w_direction, x_bar1931, 'red');
hold on;
p2 = plot(w_direction, y_bar1931, 'green');
hold on;
p3 = plot(w_direction, z_bar1931, 'blue');

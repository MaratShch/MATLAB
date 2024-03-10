% CIE 1931 color space
% https://en.wikipedia.org/wiki/CIE_1931_color_space

clc
clear all;
close all;

idx_offset = 359;
lambda = 360:1:830;

x_bar = zeros(size(lambda));
y_bar = zeros(size(lambda));
z_bar = zeros(size(lambda));

% compute x, y and z curves values
for wavelength=lambda
    array_idx = wavelength-idx_offset;
    x_bar(array_idx) = x_1931(wavelength);
    y_bar(array_idx) = y_1931(wavelength);
    z_bar(array_idx) = z_1931(wavelength);
end

hold on;

xlabel('Wavelength in nanometers')
ylabel('CIE-1931 standard curves color point')
title('The CIE XYZ standard observer color matching functions')
w_direction = min(lambda):max(lambda);
p1 = plot(w_direction, x_bar, 'red');
hold on;
p2 = plot(w_direction, y_bar, 'green');
hold on;
p3 = plot(w_direction, z_bar, 'blue');

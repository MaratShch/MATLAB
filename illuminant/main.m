%% D65 (Daylight, sRGB): 6504 Kelvin - Marked as "D65"
%% Cloudy D65 (D65 with slight tint): 6504 Kelvin - Marked as "D65 Cloudy"
%% Tungsten (Incandescent): 3200 Kelvin
%% Fluorescent Daylight: 6500 Kelvin 
%% Warm White Fluorescent: 3000 Kelvin
%% Incandescent: 2700 Kelvin
%% Soft White Fluorescent: 4200 Kelvin
%% Moonlight (Cool Blue): 4100 Kelvin

clc;
clear all;
close all;

wavelength_start = 380;
wavelength_stop  = 740;
wavelength_step  = 1;
wavelength = wavelength_start:wavelength_step:wavelength_stop;
 
d65 = illuminant_d65 (wavelength);
tint_factor = 0.03;
d65_cloudy = illuminant_d65_cloudy (wavelength, tint_factor);
tungsten = illuminant_tungsten (wavelength);
fluorescent_daylight = illuminant_fluorescent_daylight(wavelength);
fluorescent_warm_white = illuminant_warm_white_fluorescent(wavelength);

hold on;

xlabel('Wavelength (nm)');
ylabel('Relative Energy');
title('Illuminant spectral radiance for each wavelength')
w_direction = wavelength_start:wavelength_stop;
p1 = plot(w_direction, d65, 'yellow');
hold on;
p2 = plot(w_direction, d65_cloudy, 'blue');
hold on;
p3 = plot(w_direction, tungsten, 'red');
hold on;
p4 = plot(w_direction, fluorescent_daylight, 'magenta');
hold on;
p5 = plot(w_direction, fluorescent_warm_white, 'green');

legend('D65', 'D65 Cloudy', 'Tungsten', 'Fluorescent DayLight', 'Fluorescent WarmWhite');

fprintf("Complete\n");
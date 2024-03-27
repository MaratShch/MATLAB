% % D65
% % Cloudy (D65 with slight tint)
% % Tungsten (Incandescent)
% % Fluorescent (Daylight or Cool White)
% % Warm White Fluorescent
% % Incandescent (Tungsten)
% % Soft White Fluorescent
% % Moonlight (Cool Blue)

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

legend('D65', 'D65 Cloudy', 'Tungsten', 'Fluorescent');

fprintf("Complete\n");
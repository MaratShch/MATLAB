clc;
clear all;
close all;

minimal_size = 30;
% Fill the array with random values in the range of 1 to 10
x = randi([1, 10], minimal_size, minimal_size);
 
disp("Input Signal x:");
disp(x);

% Perform Winograd 2D FFT
F_u = winograd_2d_fft(x);
% Display the results
disp("Winograd 2D FFT Result F_u:");
disp(F_u.');

% Compute 2D FFT for columns and for rows
output_matrix = winograd_2d_by_1d_fft (x);
disp("Winograd 2D FFT Result by 1D functions:");
disp(output_matrix');

% Buil-in functions for references only
F_u_ref = real(fft2(x));
% Display the results
disp("Matlab buil-in function 1D FFT. Result F_u:");
disp(F_u_ref.');

fprintf("Completed.\n");
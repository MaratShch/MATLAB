clc;
clear all;
close all;

% Example input signal
x = [1, 2, 3, 4, 5, 6, 7, 10];
disp("Input Signal x:");
disp(x);

% Perform Winograd 1D FFT
F_u = winograd_1d_fft(x);
restored_signal = winograd_1d_fft_inverse(F_u);
% Display the results
disp("Winograd 1D FFT Result F_u:");
disp(F_u.');
disp("Winograd 1D IFFT Restored signal:");
disp(restored_signal);

restored_signal_ref = ifft(F_u);
disp("IFFT Restored signal:");
disp(real(restored_signal_ref));

% Buil-in functions for references only
F_u_ref = fft(x);
% Display the results
disp("Matlab buil-in function 1D FFT. Result F_u:");
disp(F_u_ref.');

fprintf("Completed.\n");
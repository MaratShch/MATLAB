clc;
clear all;
close all;


% % % minimal_size = 30;
% % % % Fill the array with random values in the range of 1 to 10
% % % x = randi([1, 10], minimal_size, minimal_size);

x = [ 
    1  2  3  4;
    5  6  7  8;
    8  7  6  5;
    4  3  2  1
];
 
disp("Input Signal x:");
disp(x.');

% Perform Winograd 2D FFT
F_u = winograd_2d_by_1d_fft (x);
% Display the results
disp("Winograd 2D FFT Result (by 1D calls) F_u:");
disp(F_u.');

% Buil-in functions for references only
F_u_ref = fft2(x);
% Display the results
disp("Matlab buil-in function 2D FFT. Result F_u:");
disp(F_u_ref.');

% diff = F_u_ref - F_u;
% disp("Computational differences fft2() - winograd_2d_fft():");
% disp(diff.');

fprintf("Completed.\n");
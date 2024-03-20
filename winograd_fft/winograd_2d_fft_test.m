clc;
clear all;
close all;

% % % minimal_size = 30;
% % % % Fill the array with random values in the range of 1 to 10
% % % x = randi([1, 10], minimal_size, minimal_size);

x = [ 1  2  3  4  5  6  7  8;
      9 10 11 12 13 14 15 16;
     17 18 19 20 21 22 23 24;
     25 26 27 28 29 30 31 31;
     33 34 35 36 37 38 39 40;
     41 42 43 44 45 46 47 48;
     49 50 51 52 53 54 55 56;
     57 58 59 60 61 62 63 64 ];
 
disp("Input Signal x:");
disp(x);

% Perform Winograd 2D FFT
F_u = winograd_2d_fft(x);
% Display the results
disp("Winograd 2D FFT Result F_u:");
disp(F_u.');

% Buil-in functions for references only
F_u_ref = fft2(x);
% Display the results
disp("Matlab buil-in function 2D FFT. Result F_u:");
disp(F_u_ref.');

diff = F_u_ref - F_u;
disp("Computational differences fft2() - winograd_2d_fft():");
disp(diff.');

fprintf("Completed.\n");
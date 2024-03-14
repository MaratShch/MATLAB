% This is simple example with usage Matlab fft module buil-in functions
% and show how to perfom 2D FTT by usage of 1D FFT function
%
clc
clear all;
close all;

% Input matrix
A = [1, 2, 3; 4, 5, 6; 7, 8, 9];

% Compute 1D FFT for columns
A_fft_col = fft(A);

% Compute 1D FFT for rows
A_fft = fft(A_fft_col, [], 2);

% Print the results
disp('Original Matrix:');
disp(A);

disp('2D FFT using Built-in Functions:');
disp(A_fft);

% Compute 2D FFT using fft2 for comparison
A_fft2 = fft2(A);

% Print the result from fft2
disp('2D FFT using fft2 Function:');
disp(A_fft2);

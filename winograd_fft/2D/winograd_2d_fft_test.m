clc;
clear all;
close all;


% % % minimal_size = 30;
% % % % Fill the array with random values in the range of 1 to 10
% % % x = randi([1, 10], minimal_size, minimal_size);

x = [ 
    1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16;
    11 12 13 14 15 16 17 18 19 20  21  22  23  24  25  26;
    10 12 13 24  5  6  7  8  9  10  11  12  13  14  15  16;
    10 12 13 44  5  6  7  8  9  10  11  12  13  14  15  16;
    10 42 13 94  5  6  7  8  9  10  11  12  13  14  15  16;
    10 32 13 14  5  6  7  8  9  10  10  12  13  14  15  16;
    10 22 13 74  5  6  7  8  9  10  10  12  13  14  15  16;
    10 12 13 74  5  6  7  8  9  10  10  12  13  14  15  16;
    10 22 13 74  5  6  7  8  9  10  21  12  13  14  15  16;
    10 12 13 74  5  6  7  8  9  10  11  12  13  14  15  16;
    10 12 13 74  5  6  7  8  9  10  11  12  13  14  15  16;
    10 12 13 74  5  6  7  8  9  10  11  12  13  14  15  16;
    10 22 13 74  5  6  7  8  9  10  11  12  13  14  15  12;
    10 12 23 74  5  6  7  8  9  10  11  12  13  14  15  16;
    10 12 13 74  5  6  7  8  9  10  11  12  13  14   5  10;
    11 12 13 64  5  6  7  8  9  10  11  12  13  14  15  10;
];
 
disp("Input Signal x:");
disp(x.');


% Buil-in functions for references only
F_u_ref = fft2(x);
% Display the results
disp("Matlab buil-in function 2D FFT. Result F_u:");
disp(F_u_ref.');

F_u = winograd_2d_fft(x);

% diff = F_u_ref - F_u;
% disp("Computational differences fft2() - winograd_2d_fft():");
% disp(diff.');

fprintf("Completed.\n");
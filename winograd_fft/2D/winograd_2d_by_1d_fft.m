function fft2d_result = winograd_2d_by_1d_fft (input_matrix)
    % Function to compute the 2D Winograd Fourier Transform (WFTA) for a given input matrix
    %
    % Parameters:
    %   input_matrix: Input matrix to transform (2D array)
    %
    % Output:
    %   complex_output: Transformed matrix using WFTA (complex numbers)

     fft_result   = fft (input_matrix, [], 1); % Compute FFT along the rows
     fft2d_result = fft (fft_result, [], 2); % Compute FFT along the columns

end

% % % Input Signal x:
% % %      1     5     8     4
% % %      2     6     7     3
% % %      3     7     6     2
% % %      4     8     5     1
% % % 
% % % Winograd 2D FFT Result (by 1D calls) F_u:
% % %   72.0000 + 0.0000i -16.0000 -16.0000i   0.0000 + 0.0000i -16.0000 +16.0000i
% % %    0.0000 + 0.0000i   0.0000 + 8.0000i   0.0000 + 0.0000i  -8.0000 + 0.0000i
% % %    0.0000 + 0.0000i  -4.0000 + 4.0000i   0.0000 + 0.0000i  -4.0000 - 4.0000i
% % %    0.0000 + 0.0000i  -8.0000 + 0.0000i   0.0000 + 0.0000i   0.0000 - 8.0000i
% % % 
% % % Matlab buil-in function 2D FFT. Result F_u:
% % %   72.0000 + 0.0000i -16.0000 -16.0000i   0.0000 + 0.0000i -16.0000 +16.0000i
% % %    0.0000 + 0.0000i   0.0000 + 8.0000i   0.0000 + 0.0000i  -8.0000 + 0.0000i
% % %    0.0000 + 0.0000i  -4.0000 + 4.0000i   0.0000 + 0.0000i  -4.0000 - 4.0000i
% % %    0.0000 + 0.0000i  -8.0000 + 0.0000i   0.0000 + 0.0000i   0.0000 - 8.0000i
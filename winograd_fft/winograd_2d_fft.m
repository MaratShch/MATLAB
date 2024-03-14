function real_output = winograd_2d_fft(input_matrix)
    % Function to compute the 2D Winograd FFT directly using cosine functions
    %
    % Parameters:
    %   input_matrix: Input matrix to transform (2D array)
    %
    % Output:
    %   real_output: Real part of the 2D Winograd FFT output
    
    [M, N] = size(input_matrix);
    real_output = zeros(M, N);
    
    % Winograd transform matrix
    G = [
        1, 0, 0, 0;
        cos(pi/4), cos(2*pi/4), cos(4*pi/4), cos(6*pi/4);
        cos(2*pi/4), cos(4*pi/4), cos(6*pi/4), cos(8*pi/4);
        0, 0, 1, 0
    ];
    
    % Step 1: Compute Intermediate Matrix B
    B = input_matrix * G.';
    
    % Step 2: Compute Intermediate Matrix BT
    BT = G * B.';
    
    % Step 3: Compute Real Part of the 2D Winograd FFT
    real_output = real(BT);
end

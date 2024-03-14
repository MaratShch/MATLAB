function real_output = winograd_2d_fft_direct_cosine(input_matrix)
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
        0.5, 0.5, 0.5, 0.5;
        0.5, -0.5, 0.5, -0.5;
        0, 0, 1, 0
    ];
    
    % Step 1: Compute Intermediate Matrix B
    B = zeros(M, N);
    for i = 1:M
        for j = 1:N/4
            % Extract a 4-element chunk from the input matrix
            chunk = input_matrix(i, (j-1)*4+1 : j*4);
            % Multiply by the Winograd transform matrix G
            B(i, (j-1)*4+1 : j*4) = chunk * G.';
        end
    end
    
    % Step 2: Compute Intermediate Matrix BT
    BT = zeros(M, N);
    for j = 1:N
        for i = 1:M/4
            % Extract a 4-element chunk from the intermediate matrix B
            chunk = B((i-1)*4+1 : i*4, j);
            % Multiply by the Winograd transform matrix G
            BT((i-1)*4+1 : i*4, j) = G * chunk;
        end
    end
    
    % Step 3: Compute Real Part of the 2D Winograd FFT
    real_output = BT(1:M, 1:N);
end

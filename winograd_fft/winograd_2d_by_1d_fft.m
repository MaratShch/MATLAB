function real_output = winograd_2d_by_1d_fft(input)
    % Function to compute 2D Winograd FFT using validated 1D Winograd FFT function
    % Returns only the real part
    %
    % Parameters:
    %   input: Input matrix to transform (2D array)
    %
    % Output:
    %   real_output: Real part of the 2D Winograd FFT output
    
    [M, N] = size(input);
    real_output = zeros(M, N);
    
    % Apply 1D Winograd FFT on rows
    for i = 1:M
        real_output(i, :) = winograd_1d_fft(input(i, :));
    end
    
    % Apply 1D Winograd FFT on columns
    for j = 1:N
        real_output(:, j) = winograd_1d_fft(real_output(:, j).');
    end
end

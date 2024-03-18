function complex_output = winograd_2d_fft(input_matrix)
    % Function to compute the 2D Winograd Fourier Transform (WFTA) for a given input matrix
    %
    % Parameters:
    %   input_matrix: Input matrix to transform (2D array)
    %
    % Output:
    %   complex_output: Transformed matrix using WFTA (complex numbers)

    [M, N] = size(input_matrix);
    complex_output = zeros(M, N);

    % Perform 1D WFTA for each row
    for i = 1:M
        row_input = input_matrix(i, :);
        row_output = winograd_1d_fft(row_input);
        complex_output(i, :) = row_output;
    end

    % Perform 1D WFTA for each column
    for j = 1:N
        col_input = complex_output(:, j)';
        col_output = winograd_1d_fft(col_input);
        complex_output(:, j) = col_output;
    end
end


function complex_output = winograd_2d_fft(input_matrix)
    % Function to compute the 2D Winograd FFT
    %
    % Parameters:
    %   input_matrix: 2D matrix representing the input image
    %
    % Output:
    %   complex_output: Complex output of the 2D Winograd FFT

    % Define the Transform Matrix G
    G = [1, 0, 0, 0;
         0.5,  0.5,  0.5,  0.5;
         0.5, -0.5,  0.5, -0.5;
         0, 0, 1, 0];
    
    % Get the dimensions of the input matrix
    [rows, cols] = size(input_matrix);
    
    % Determine the number of rows and columns needed for zero-padding
    pad_rows = mod(4 - mod(rows, 4), 4);
    pad_cols = mod(4 - mod(cols, 4), 4);
    
    % Pad the input matrix with zeros to ensure dimensions are multiples of 4
    padded_input = padarray(input_matrix, [pad_rows, pad_cols], 0, 'post');
    
    % Get the updated dimensions after zero-padding
    [padded_rows, padded_cols] = size(padded_input);
    
    % Create an empty complex matrix to store the transformed values
    complex_output = zeros(padded_rows, padded_cols);
    
    % Step 1: Apply the Transform Matrix G to blocks of the padded input matrix
    for i = 1:4:padded_rows
        for j = 1:4:padded_cols
            % Extract a 4x4 block from the padded input matrix
            block = padded_input(i:i+3, j:j+3);
            
            % Apply the Transform Matrix G to the block
            transformed_block = G * block * G';
            
            % Store the transformed block in the complex output matrix
            complex_output(i:i+3, j:j+3) = transformed_block;
        end
    end
    
    % Step 2: Block Processing
    for i = 1:4:padded_rows
        for j = 1:4:padded_cols
            % Extract a 4x4 block from the complex output matrix
            block = complex_output(i:i+3, j:j+3);
            
            % Compute the Hadamard product with the matrix H
            H = [1, -1, 1, -1;
                 -1, 1, -1, 1;
                 1, -1, 1, -1;
                 -1, 1, -1, 1];
            
            processed_block = H * block * H';
            
            % Store the processed block back into the complex output matrix
            complex_output(i:i+3, j:j+3) = processed_block;
        end
    end
    
    % Step 3: Compute the Real Part of the 2D WFTA
    real_output = real(complex_output);
    
    % Step 4: Compute the Imaginary Part of the 2D WFTA
    imag_output = imag(complex_output);
    
    % Step 5: Multiply by Matrix H
    for i = 1:4:padded_rows
        for j = 1:4:padded_cols
            % Extract a 4x4 block from the complex output matrix
            blockR = real_output(i:i+3, j:j+3);
            blockI = imag_output(i:i+3, j:j+3);
            
            % Compute the Hadamard product with the matrix H
            YR = H * blockR * H';
            YI = H * blockI * H';
            
            % Store the processed block back into the complex output matrix
            complex_output(i:i+3, j:j+3) = complex(YR, YI);
        end
    end
    
    % Normalize the output
    complex_output = complex_output / sqrt(rows * cols);
    
    % Convert the output to 'complex double'
    complex_output = complex(complex_output);
end

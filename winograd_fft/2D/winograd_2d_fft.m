function output = winograd_fft_2d(input)
% Function to perform 2D Winograd FFT transformation on input data
% Input:
%   input: Input 2D data matrix
% Output:
%   output: Complex result of 2D Winograd FFT transformation

    % Step 1: Detect input data size and choose block size
    [rows, cols] = size(input);
    block_size = choose_block_size(rows, cols);
    
    % Step 2: Preprocessing (if necessary)
    % - Apply padding if needed
    input_padded = apply_padding(input, block_size);
    
    % Step 3: Factorization and Transformation
     blocks = factorize_input(input_padded, block_size);

     transformed_blocks = apply_winograd_transform(blocks);
     
     % Step 4: Post-processing
     output = recombine_blocks(transformed_blocks);
    
end

function input_padded = apply_padding(input, block_size)
% Function to apply padding to input data if necessary
% Input:
%   input: Input 2D data matrix
%   block_size: Chosen block size for factorization
% Output:
%   input_padded: Input data matrix with padding applied (if needed)

    % Calculate required padding size to make input dimensions divisible by block size
    pad_rows = ceil(size(input, 1) / block_size(1)) * block_size(1) - size(input, 1);
    pad_cols = ceil(size(input, 2) / block_size(2)) * block_size(2) - size(input, 2);
    
    % Apply zero-padding if necessary
    input_padded = padarray(input, [pad_rows, pad_cols], 0, 'post');
    
end
function block_size = choose_block_size(rows, cols)
% Function to choose block size based on input data dimensions
% Input:
%   rows: Number of rows in input data
%   cols: Number of columns in input data
% Output:
%   block_size: Chosen block size for factorization

    % Choose block size based on optimization strategy
    % - For simplicity, let's choose a block size of 8x8
    block_size = [8, 8];
    
end
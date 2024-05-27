function blocks = factorize_input(input, block_size)
% Function to factorize input data into smaller blocks
% Input:
%   input: Input 2D data matrix
%   block_size: Size of each block (e.g., [8, 8])
% Output:
%   blocks: Cell array of smaller blocks

    % Get size of input data matrix
    [rows, cols] = size(input);
    
    % Calculate number of blocks in each dimension
    num_blocks_rows = ceil(rows / block_size(1));
    num_blocks_cols = ceil(cols / block_size(2));
    
    % Initialize cell array to store blocks
    blocks = cell(num_blocks_rows, num_blocks_cols);
    
    % Loop through input data and extract blocks
    for i = 1:num_blocks_rows
        for j = 1:num_blocks_cols
            % Calculate indices for current block
            start_row = (i - 1) * block_size(1) + 1;
            end_row = min(start_row + block_size(1) - 1, rows);
            start_col = (j - 1) * block_size(2) + 1;
            end_col = min(start_col + block_size(2) - 1, cols);
            
            % Extract current block from input data
            blocks{i, j} = input(start_row:end_row, start_col:end_col);
        end
    end
    
end

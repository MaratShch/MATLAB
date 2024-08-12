function transformed_blocks = apply_winograd_transform(blocks)
    % Apply Winograd transform to each block of input data

    % Determine block size
    block_size = size(blocks{1}, 1);

    % Compute transformation matrices A, B, and G based on block size
    [A, B, G] = compute_matrices(block_size);
    
    % Compute bias vector based on block size
    bias_vector = compute_bias_vector(block_size);

    num_blocks = numel(blocks); % Number of blocks

    transformed_blocks = cell(num_blocks, 1); % Initialize cell array to store transformed blocks
    
    % Apply transformation and add bias to each block
    for i = 1:num_blocks
        block = blocks{i};
        transformed_block = B * block * B';
        transformed_block = G * transformed_block * G';
        transformed_block = A * transformed_block * A';
        
        % Add bias vector element-wise
        transformed_block_with_bias = transformed_block + bias_vector;
        
        transformed_blocks{i} = transformed_block_with_bias;
    end
end

function [A, B, G] = compute_matrices(block_size)
    % Compute transformation matrices A, B, and G based on block size
    if block_size == 4
        % Coefficients for 4x4 block size
        % Define transformation matrices A, B, and G for 4x4 block size
        A = [ 1    0    0    0;
              0.5  0.5  0.5  0.5;
              0.5 -0.5  0.5 -0.5;
              0    0    1    0]; % 4x4 matrix
          
        B = [ 1    0    0    0;
              0.5  0.5 -0.5 -0.5;
              0.5 -0.5 -0.5  0.5;
              0    0    1    0]; % 4x4 matrix
          
        G = [ 1   1   1   0; 
              0   1  -1   1;
              0   1   1  -1;
              0   1  -1   0]; % 4x4 matrix
    elseif block_size == 8
        % Coefficients for 8x8 block size
        % Define transformation matrices A, B, and G for 8x8 block size
        A = [1 0 0 0 0 0 0 0; 0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5; 0.5 -0.5 0.5 -0.5 0.5 -0.5 0.5 -0.5;
             0.5 0.5 -0.5 -0.5 0.5 0.5 -0.5 -0.5; 0.5 -0.5 -0.5 0.5 0.5 -0.5 -0.5 0.5; 0.5 0.5 0.5 -0.5 -0.5 -0.5 -0.5 0.5;
             0.5 -0.5 0.5 -0.5 -0.5 0.5 -0.5 0.5; 0 0 0 0 1 0 0 0]; % 8x8 matrix
        B = [1 0 0 0 0 0 0 0; 0.5 0.5 -0.5 -0.5 -0.5 -0.5 0.5 0.5; 0.5 -0.5 -0.5 0.5 -0.5 0.5 0.5 -0.5;
             0.5 -0.5 0.5 0.5 -0.5 -0.5 0.5 0.5; 0.5 0.5 0.5 -0.5 -0.5 -0.5 -0.5 0.5; 0.5 -0.5 0.5 -0.5 0.5 -0.5 0.5 -0.5;
             0.5 -0.5 -0.5 0.5 0.5 -0.5 -0.5 0.5; 0 0 0 0 0 0 0 1]; % 8x8 matrix
        G = [1 1 1 1 1 1 1 0; 1 -1 1 -1 1 -1 1 0; 1 1 -1 -1 1 1 -1 0; 1 -1 -1 1 1 -1 -1 0;
             1 1 1 1 -1 -1 -1 0; 1 -1 1 -1 -1 1 -1 0; 1 1 -1 -1 -1 -1 1 0; 0 0 0 0 0 0 0 1]; % 8x8 matrix
    else
        error('Unsupported block size. Supported block sizes are 4 and 8.');
    end
end

function bias_vector = compute_bias_vector(block_size)
    % Compute bias vector based on block size
    if block_size == 4
        bias_vector = [0.5; -0.5; 0.5; -0.5];
    elseif block_size == 8
        bias_vector = [0.5; -0.5; 0.5; -0.5; 0.5; -0.5; 0.5; -0.5];
    else
        error('Unsupported block size. Supported block sizes are 4 and 8.');
    end
end
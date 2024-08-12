function transformed_image = recombine_transformed_blocks(transformed_blocks, block_size, original_size)
    % Recombine transformed blocks to obtain the transform result of the full image

    num_blocks_x = ceil(original_size(2) / block_size);
    num_blocks_y = ceil(original_size(1) / block_size);

    transformed_image = zeros(original_size); % Initialize transformed image

    for i = 1:num_blocks_y
        for j = 1:num_blocks_x
            block_index = (i - 1) * num_blocks_x + j;
            if block_index <= numel(transformed_blocks)
                % Extract transformed block
                transformed_block = transformed_blocks{block_index};
                % Determine the position of the block in the transformed image
                start_row = (i - 1) * block_size + 1;
                end_row = min(i * block_size, original_size(1));
                start_col = (j - 1) * block_size + 1;
                end_col = min(j * block_size, original_size(2));
                % Place the transformed block in the transformed image
                transformed_image(start_row:end_row, start_col:end_col) = transformed_block(1:end_row-start_row+1, 1:end_col-start_col+1);
            end
        end
    end
end

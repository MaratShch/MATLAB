function complex_output = winograd_2d_fft_bw(input_image)
    % Function to compute the 2D Winograd FFT for black and white (grayscale) images
    %
    % Parameters:
    %   input_image: 2D matrix representing the input black and white image
    %
    % Output:
    %   complex_output: Complex output of the 2D Winograd FFT for the grayscale image
    %
    % Configuration:
    %   Change the block size by uncommenting the desired size and commenting the others.
    %   The function will adapt to the chosen block size automatically.
    
    % Block size configuration (change as needed)
    block_size = 4; % Default block size
    % block_size = 8; % Uncomment for 8x8 block size
    
    % Step 1: Apply zero-padding if needed to make dimensions multiples of block_size
    [height, width] = size(input_image);
    pad_height = ceil(height / block_size) * block_size - height;
    pad_width = ceil(width / block_size) * block_size - width;
    padded_image = padarray(input_image, [pad_height, pad_width], 0, 'post');
    
    % Step 2: Apply the Winograd transformation matrices G and B
    
    % Step 3: Apply block processing using the matrix H
    
    % Step 4: Compute the real and imaginary parts separately
    
    % Step 5: Combine the real and imaginary parts to get complex output
    
end

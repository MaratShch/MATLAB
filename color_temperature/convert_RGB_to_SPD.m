function SPD_image = convert_RGB_to_SPD (input_RGB_image, observer, illuminant_spd, wavelengths)
    % Convert RGB image to Spectral Power Distribution (SPD)
    
    % Normalize the input RGB image to the range [0, 1]
    normalized_RGB_image = double(input_RGB_image) / 255;
    
    % Initialize the SPD image
    [rows, cols, ~] = size(normalized_RGB_image);
    SPD_image = zeros(rows, cols, length(wavelengths));
    
    % Loop through each pixel and compute the SPD
    for i = 1:rows
        for j = 1:cols
            X = sum(normalized_RGB_image(i, j, 1) .* observer);
            Y = sum(normalized_RGB_image(i, j, 2) .* observer);
            Z = sum(normalized_RGB_image(i, j, 3) .* observer);
            
            % Compute the SPD for the pixel
            SPD_pixel = X .* illuminant_spd + Y .* illuminant_spd + Z .* illuminant_spd;
            
            % Assign the SPD to the corresponding pixel in the SPD image
            SPD_image(i, j, :) = SPD_pixel;
        end
    end
end
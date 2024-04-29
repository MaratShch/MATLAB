function XYZ_image = convert_SPD_to_XYZ(SPD_image, illuminant, observer)
    % Convert SPD image to XYZ image
    
    % Check if input dimensions match
    [rows, cols, wavelengths] = size(SPD_image);
    [illuminant_rows, illuminant_cols] = size(illuminant);
    [observer_rows, observer_cols] = size(observer);
    
    if (illuminant_rows ~= 1 || observer_rows ~= 3 || wavelengths ~= illuminant_cols || wavelengths ~= observer_cols)
        error('Dimensions of SPD image, illuminant, or observer do not match.');
    end
    
    % Reshape SPD image to a 2D matrix (rows*cols x wavelengths)
    SPD_reshaped = reshape(SPD_image, [], wavelengths);
    
    % Apply illuminant to each color channel of observer
    observer_illuminated = observer .* illuminant;
    
    % Compute XYZ values for each pixel
    X = sum(SPD_reshaped .* observer_illuminated(1,:), 2);
    Y = sum(SPD_reshaped .* observer_illuminated(2,:), 2);
    Z = sum(SPD_reshaped .* observer_illuminated(3,:), 2);
    
    % Normalize XYZ values
    sum_XYZ = sum([X, Y, Z], 2);
    X = X ./ sum_XYZ;
    Y = Y ./ sum_XYZ;
    Z = Z ./ sum_XYZ;
    
    % Convert to XYZ image
    XYZ_image = reshape([X, Y, Z], rows, cols, 3);
end

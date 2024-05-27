function [x, y] = compute_chromaticity_coordinates(rgb_image)
    % Convert RGB image to XYZ color space
    xyz_image = rgb2xyz(rgb_image);
    
    % Extract XYZ channels
    X = xyz_image(:,:,1);
    Y = xyz_image(:,:,2);
    Z = xyz_image(:,:,3);
    
    % Compute chromaticity coordinates (x, y)
    x = X ./ (X + Y + Z);
    y = Y ./ (X + Y + Z);
end

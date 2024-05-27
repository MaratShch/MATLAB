function [cct, tint] = compute_cct_and_tint (white_balanced_image)
    % Step 1: Convert the white balanced image to CIELab color space (already done)
    lab_image = rgb2lab(white_balanced_image);

    % Step 2: Compute the average a* and b* values
    avg_L = mean(lab_image(:,:,1), 'all');
    avg_a = mean(lab_image(:,:,2), 'all');
    avg_b = mean(lab_image(:,:,3), 'all');

    % Step 3: Convert a* and b* values to CCT and Tint
    [cct, tint] = ab2ct(avg_L, avg_a, avg_b);
end

function [cct, tint] = ab2ct(L, a, b)
    % Convert CIELab values to CCT and Tint
    
    % Step 1: Convert CIELab to XYZ
    XYZ = lab2xyz([L, a, b]);
    
    % Step 2: Convert XYZ to xy chromaticity coordinates
    xy = XYZ(1:2) / sum(XYZ);
    
    % Step 3: Calculate correlated color temperature (CCT) in Kelvins
    cct = xy2kelvin(xy);

    % Step 4: Calculate tint
    tint = b / a; % Tint is the ratio of b* to a*
end

function kelvin = xy2kelvin(xy)
    % Convert chromaticity coordinates (x, y) to correlated color temperature (CCT) in Kelvin
    % This conversion is based on a simple linear relationship
    kelvin = 1000000 / (xy(1) + 15 * xy(2));
end

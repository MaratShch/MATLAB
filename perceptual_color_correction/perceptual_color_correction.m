function adjusted_image = perceptual_color_correction(rgb_image, cct_value, tint_value)
% PERCEPTUAL_COLOR_CORRECTION Performs perceptual color correction on an RGB image.
%
%   INPUTS:
%       rgb_image: Input RGB image (height x width x 3 matrix).
%       cct_value: Desired Correlated Color Temperature (CCT) value.
%       tint_value: Desired tint value.
%
%   OUTPUT:
%       adjusted_image: RGB image after perceptual color correction.
%
%   SUB-STEPS:
%       1. White Balance Adjustment:
%           - Adjusts the color balance of the image to achieve neutral whites.
%           - Input: rgb_image
%           - Output: white_balanced_image
%
%       2. Compute CCT and Tint:
%           - Estimates the CCT and tint values from the white-balanced image.
%           - Input: white_balanced_image
%           - Outputs: estimated_cct, estimated_tint
%
%       3. CCT and Tint Adjustment:
%           - Adjusts the image's CCT and tint to match the desired values.
%           - Inputs: rgb_image, cct_value, tint_value
%           - Output: adjusted_image
%
%   NOTE:
%       - Each sub-step will be implemented as separate functions later.


% Step 1: White Balance Adjustment
 white_balanced_image = grayWorldWhiteBalance (rgb_image);
 figure(2);
 imshow(white_balanced_image);
 
% Step 2: Compute CCT and Tint
% %  [estimated_cct, estimated_tint] = compute_cct_and_tint (white_balanced_image);
% %  fprintf('Balanced Image. Estimated CCT: %.2f Kelvin\n', estimated_cct);
% %  fprintf('Balanced Image. Estimated Tint: %.2f\n', estimated_tint);

[x, y] = compute_chromaticity_coordinates (white_balanced_image);
x_avg = mean(x(:));
y_avg = mean(y(:));

% % 
% % % Step 3: CCT and Tint Adjustment
% % % adjusted_image = cct_and_tint_adjustment(white_balanced_image, cct_value, tint_value);
% % 
% % % Return the adjusted image
% % % Note: Uncomment the relevant steps once their functions are implemented.
% % % For now, returning the input image without adjustments.
adjusted_image = white_balanced_image;

end

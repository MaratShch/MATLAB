function balanced_image = grayWorldWhiteBalance(rgb_image)
% gray_world - Gray World Algorithm for white balance correction
%
% Usage:
%   balanced_image = gray_world(rgb_image)
%
% Inputs:
%   - rgb_image: Input RGB image (floating point format, range 0...1)
%
% Output:
%   - balanced_image: White-balanced RGB image
%
% Description:
%   This function performs white balance correction on the input RGB image
%   using the Gray World Algorithm. It assumes that the average color in the
%   image should appear gray and adjusts color channels accordingly.

% Compute average color of the image
avg_color = mean(mean(rgb_image, 1), 2);

% Compute scaling factors for each color channel
scale_factor_r = 0.5 / avg_color(1);
scale_factor_g = 0.5 / avg_color(2);
scale_factor_b = 0.5 / avg_color(3);

% Get the size of the image
[rows, cols, ~] = size(rgb_image);

% Initialize balanced image
balanced_image = zeros(rows, cols, 3);

% Apply scaling factors to each color channel
balanced_image(:,:,1) = rgb_image(:,:,1) * scale_factor_r;
balanced_image(:,:,2) = rgb_image(:,:,2) * scale_factor_g;
balanced_image(:,:,3) = rgb_image(:,:,3) * scale_factor_b;

end

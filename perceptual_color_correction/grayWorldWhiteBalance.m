function balancedImage = grayWorldWhiteBalance(rgbImage)
    % Calculate the average color of the image
    averageColor = mean(mean(rgbImage, 1), 2);

    % Compute scaling factors for each color channel
    scalingFactors = 0.5 ./ averageColor;

    % Get image dimensions
    [height, width, ~] = size(rgbImage);

    % Initialize balanced image
    balancedImage = zeros(height, width, 3, 'like', rgbImage);

    % Apply scaling factors to each pixel's color value
    for i = 1:height
        for j = 1:width
            for k = 1:3 % Iterate over RGB channels
                balancedImage(i, j, k) = rgbImage(i, j, k) * scalingFactors(k);
            end
        end
    end

    % Clip pixel values to ensure they remain within the valid range [0, 1]
    balancedImage = max(0, min(balancedImage, 1));
end

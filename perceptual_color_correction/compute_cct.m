function [CCT, tint] = computeCCT(image)
    % Convert image to CIE XYZ color space
    xyzImage = rgb2xyz(image);

    % Compute chromaticity coordinates
    xyWhite = chromaticityCoordinates(xyzImage);

    % Convert chromaticity coordinates to correlated color temperature (CCT)
    CCT = xy2CCT(xyWhite);

    % Compute tint
    tint = computeTint(xyzImage, xyWhite);
end

function xy = chromaticityCoordinates(xyzImage)
    % Compute chromaticity coordinates from XYZ image
    sumXYZ = sum(xyzImage, 3);
    xy = bsxfun(@rdivide, xyzImage(:,:,1:2), sumXYZ);
end

function CCT = xy2CCT(xy)
    % Convert chromaticity coordinates to correlated color temperature (CCT)
    % This conversion is based on the CIE 1931 chromaticity diagram
    mired = 1 / norm(xy - [0.3127, 0.3290]); % D65 illuminant
    CCT = 1000000 / mired;
end

function tint = computeTint(xyzImage, xyWhite)
    % Compute tint based on the deviation of the white point from D65
    xyD65 = [0.3127, 0.3290]; % D65 illuminant
    deltaXY = xyWhite - xyD65;
    tint = deltaXY(2) / deltaXY(1); % Tint is the ratio of delta Y to delta X
end

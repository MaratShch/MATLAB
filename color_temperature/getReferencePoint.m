function referencePoint = getReferencePoint(index)
%getReferencePoint Returns a specific reference point from the initialized list.
%   referencePoint = getReferencePoint(index) returns the reference point at
%   the specified index.

% Ensure the index is a scalar integer.
if ~isscalar(index) || ~isnumeric(index) || mod(index, 1) ~= 0
    error('Index must be a scalar integer.');
end

% Initialize the reference points (this is done only once)
persistent referencePoints

if isempty(referencePoints)
    % Define the data
    R           = int32([255, 255, 220, 255, 0, 255, 255, 255, 240, 255]');
    G           = int32([220, 250, 230, 150, 0, 255, 255, 255, 255, 250]');
    B           = int32([180, 240, 255,  75, 255, 100, 200,   0, 240, 240]');
    CCT         =     [2700, 5600, 7500, 3200, 15000, 4000, 5000, 4500, 6000, 5600]';
    Tint        =     [   2,    0,   -3,   -5,     0,    5,    3,    0,    7,    5]';
    Description = {
        "Warm White (Incandescent)";
        "Neutral Daylight";
        "Cool Daylight (Overcast)";
        "Studio Tungsten with Correction";
        "Extreme Blue (Special Effect)";
        "Warm Yellow";
        "Pale Yellow (Near White)";
        "Bright Yellow";
        "Near White with Green Tint";
        "Neutral Daylight, Different Tint"
        };

    % Create the table
    referencePoints = table(R, G, B, CCT, Tint, Description);
end

% Validate the index
if index < 1 || index > height(referencePoints)
    error('Index out of bounds. Must be between 1 and %d.', height(referencePoints));
end

% Access the specified row
referencePoint = referencePoints(index,:);
end

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

% Display the table
disp(referencePoints);

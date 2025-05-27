% NOT COMPLETED YET !!!!
clc
clear all;
close all;

workingFolder = pwd;
% Add the subfolder with API for compute color curves
addpath(strcat(workingFolder, '/CURVES'));
% Add the subfolder with API for compute SPD
addpath(strcat(workingFolder, '/PLANCK'));

% working ranges
WavelengthRange = 380:0.5:750; % Wavelenght in nanometers
CCTlengthRange  = 1000:1:25000;% CCT in Kelvin degrees
CIE_observer = 1931; % use 2 degrees 1931 color observer

% create Color Observer
if CIE_observer == 1931
    observer = observer_1931(WavelengthRange);
else
    observer = observer_1964(WavelengthRange);
end

% compute Chromaticity Coordinates
[u,v,cct,duv] = ChromaticityPoints (WavelengthRange, observer, CCTlengthRange);

% % hold on;
% % title('Chromaticity u (red), v (green), Duv (blue) coordinates')
% % w_direction = min(cct):max(cct);
% % p1 = plot(w_direction, u, 'red');
% % hold on;
% % p2 = plot(w_direction, v, 'green');
% % hold on;
% % p3 = plot(w_direction, duv, 'blue');

% create LUT
numElements = length(u);
indices = 1:numElements;
lut = arrayfun(@(i) struct('u', u(i), 'v', v(i), 'cct', cct(i), 'duv', duv(i)), indices);

% check reference point
gamma = 0;
R = 255.0;
G = 255.0;
B = 255.0;
expectedCCT = 6504.0;
expectedDuv = 0.0;

fprintf('Color values R = %f, G = %f, B = %f\n', R, G, B);
fprintf('Gamma correction = %d\n', gamma);
fprintf('Used observer = %d\n', CIE_observer);
[Cct, Duv] = RGB2CctDuv(R, G, B, gamma, lut);
fprintf('Computed CCT and Tint: CCT = %f, Tint = %f\n', Cct, Duv);
fprintf('Expected CCT and Tint: CCT = %f, Tint = %f\n', expectedCCT, expectedDuv); 
fprintf('Differences between expected and computed values: CCT = %f, Duv = %f\n', ...
         expectedCCT - Cct, expectedDuv - Duv); 
fprintf('\n');

gamma = 0;
R = 255.0;
G = 219.0;
B = 165.0;
expectedCCT = 2850.0;
expectedDuv = 0.0;
     
fprintf('Color values R = %f, G = %f, B = %f\n', R, G, B);
fprintf('Gamma correction = %d\n', gamma);
fprintf('Used observer = %d\n', CIE_observer);
[Cct, Duv] = RGB2CctDuv(R, G, B, gamma, lut);
fprintf('Computed CCT and Tint: CCT = %f, Tint = %f\n', Cct, Duv);
fprintf('Expected CCT and Tint: CCT = %f, Tint = %f\n', expectedCCT, expectedDuv); 
fprintf('Differences between expected and computed values: CCT = %f, Duv = %f\n', ...
         expectedCCT - Cct, expectedDuv - Duv); 
fprintf('\n');


gamma = 0;
R = 201.0;
G = 226.0;
B = 255.0;
expectedCCT = 7500.0;
expectedDuv = -0.001;
     
fprintf('Color values R = %f, G = %f, B = %f\n', R, G, B);
fprintf('Gamma correction = %d\n', gamma);
fprintf('Used observer = %d\n', CIE_observer);
[Cct, Duv] = RGB2CctDuv(R, G, B, gamma, lut);
fprintf('Computed CCT and Tint: CCT = %f, Tint = %f\n', Cct, Duv);
fprintf('Expected CCT and Tint: CCT = %f, Tint = %f\n', expectedCCT, expectedDuv); 
fprintf('Differences between expected and computed values: CCT = %f, Duv = %f\n', ...
         expectedCCT - Cct, expectedDuv - Duv); 
fprintf('\n');



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
gamma = 1;
R = 240.0;
G = 255.0;
B = 240.0;
[Cct, Duv] = RGB2CctDuv(R, G, B, gamma, lut);




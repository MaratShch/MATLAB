clc
clear all;
close all;

sizeX = 1920;
sizeY = 1080;

[powers_X, powers_Y] = compute_highest_powers (sizeX, sizeY);
fprintf("Powers for image size %d x %d: X = %d, Y = %d\n", ... 
         sizeX, sizeY, powers_X(1), powers_Y(1));

fprintf("COMPLETE\n");
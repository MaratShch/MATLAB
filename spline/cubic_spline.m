clc
clear all;
close all;

% --- Define some data points ---
x = [0, 1, 2, 3, 4, 5];
y = [0, 0.8, 0.9, 0.1, -0.8, -1.0];

% --- Define query points for smooth plotting ---
xq = linspace(min(x), max(x), 200); % 200 points for a smooth curve

% --- 1. Default "Not-a-Knot" Cubic Spline ---
yq_notaknot = spline(x, y, xq);

% Let's specify slopes at the endpoints
slope_start = 0;  % Desired S'(x_0)
slope_end = 0;    % Desired S'(x_n)
% Construct the augmented y vector for clamped spline
y_clamped_input = [slope_start, y, slope_end];
yq_clamped = spline(x, y_clamped_input, xq);

% --- Get the piecewise polynomial structure for the not-a-knot spline ---
pp_notaknot = spline(x, y);
disp('Piecewise polynomial structure (pp_notaknot):');
disp(pp_notaknot);
disp('Coefficients for the first piece (not-a-knot):');
disp(pp_notaknot.coefs(1,:)); % [d1, c1, b1, a1] for interval [x0, x1]

% --- Plotting ---
figure;
hold on;

% Plot original data points
plot(x, y, 'o', 'MarkerFaceColor', 'r', 'MarkerSize', 8, 'DisplayName', 'Data Points');

% Plot Not-a-Knot spline
plot(xq, yq_notaknot, 'b-', 'LineWidth', 2, 'DisplayName', 'Not-a-Knot Spline (Default)');

% Plot Clamped spline (with specified zero end slopes)
plot(xq, yq_clamped, 'g--', 'LineWidth', 2, 'DisplayName', 'Clamped Spline (Slopes=0 at ends)');

hold off;
xlabel('x');
ylabel('y');
title('Cubic Spline Interpolation in MATLAB');
legend('show', 'Location', 'SouthEast');
grid on;
axis tight;

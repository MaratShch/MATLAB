function outputImage = createFisheyeFill(inputImage, degree, fill_mode)
    % Creates a more realistic fisheye effect using a power law mapping.
    %
    % Args:
    %   inputImage: The input image matrix (grayscale or RGB).
    %   degree:     Controls the "rounding" intensity, range [0, 1].
    %               0 = no distortion, 1 = maximum configured distortion.
    %   fill_mode:  'crop' (recommended) leaves areas outside the fisheye
    %               projection black, avoiding edge artifacts.
    %               'clamp' attempts to fill the frame by clamping coordinates,
    %               which may still introduce some edge stretching.
    %
    % Returns:
    %   outputImage: The image with the fisheye effect applied.

    if nargin < 2
        degree = 0.5;
        disp(['Using default fisheye degree = ', num2str(degree)]);
    end
    if nargin < 3
        fill_mode = 'crop'; % Default to crop for better quality
        disp("Using default fill_mode = 'crop'");
    end

    % Input validation
    if degree < 0 || degree > 1
        error('Degree must be between 0 and 1.');
    end
    if ~ismember(fill_mode, {'crop', 'clamp'})
        error("fill_mode must be either 'crop' or 'clamp'.");
    end

    % --- Configuration ---
    % Maximum strength coefficient 'k' when degree is 1.
    % This value is for the exponent term (1 + k). Adjust as needed.
    % Higher values -> more extreme rounding/compression at degree=1.
    k_max = 1.5; % Tunable parameter (e.g., 1.5, 2.0, 2.5, 3.0)

    % Calculate the actual strength based on degree
    k_strength = k_max * degree;
    exponent = 1.0 + k_strength; % The power for the mapping

    % --- Basic Setup ---
    [H, W, C] = size(inputImage);
    original_class = class(inputImage);

    if ~isa(inputImage, 'double')
        inputImage_double = im2double(inputImage);
    else
        inputImage_double = inputImage;
    end

    % Initialize output image (black background)
    outputImage_double = zeros(H, W, C, 'double');

    cx = W / 2;
    cy = H / 2;
    % Use distance to corner for normalization if clamping, or just min radius
    % Using min radius is often simpler and visually okay.
    max_radius = max(cx, cy);
    % Alternatively, for potentially better corner handling in clamp mode:
    % max_radius = sqrt(cx^2 + cy^2);

    if max_radius == 0 % Handle edge case of tiny image
        if strcmp(original_class, 'uint8')
            outputImage = im2uint8(outputImage_double);
        elseif strcmp(original_class, 'uint16')
            outputImage = im2uint16(outputImage_double);
        else
            outputImage = outputImage_double;
        end
        disp('Image too small, returning black image.');
        return;
    end

    % --- Inverse Mapping Loop ---
    for y = 1:H
        for x = 1:W
            xd = x - cx;
            yd = y - cy;
            r_d = sqrt(xd^2 + yd^2);

            % Normalized destination radius
            norm_r_d = r_d / max_radius;

            % --- Apply NEW Inverse Distortion Model ---
            % Apply power law mapping for compression
            % Handle norm_r_d = 0 separately if needed, although 0^exponent is 0
            if norm_r_d == 0
                norm_r_u = 0;
            else
                % Ensure base is non-negative if exponent isn't integer
                 norm_r_u = max(0, norm_r_d) ^ exponent;
            end

            % Calculate source radius r_u
            r_u = max_radius * norm_r_u;

            % Angle remains the same
            theta = atan2(yd, xd); % atan2 handles quadrants correctly

            % --- Calculate Corresponding Input Coordinates (u, v) ---
            u = cx + r_u * cos(theta);
            v = cy + r_u * sin(theta);

            % --- Handle Boundaries and Interpolation ---
            perform_interpolation = false;
            interp_u = u; % Coordinates to use for interpolation
            interp_v = v;

            if strcmp(fill_mode, 'crop')
                % Check if the calculated (u, v) is within the source image
                if u >= 1 && u <= W && v >= 1 && v <= H
                    perform_interpolation = true;
                    % Use original u, v for interpolation
                else
                    % Pixel remains black (already initialized)
                end
            elseif strcmp(fill_mode, 'clamp')
                % Clamp coordinates to be within source image bounds
                interp_u = max(1, min(W, u));
                interp_v = max(1, min(H, v));
                perform_interpolation = true; % Always interpolate in clamp mode
            end

            % --- Perform Bilinear Interpolation if required ---
            if perform_interpolation
                x1 = floor(interp_u);
                y1 = floor(interp_v);
                x2 = ceil(interp_u);
                y2 = ceil(interp_v);

                % Clamp floor/ceil results to be within [1, Dim] range
                x1 = max(1, x1);
                y1 = max(1, y1);
                x2 = min(W, x2);
                y2 = min(H, y2);
                
                % Added robustness: Ensure x1 <= x2 and y1 <= y2 even with clamping
                % This can happen if interp_u is exactly 1, floor=1, ceil=1
                if x1 > x2, x2 = x1; end
                if y1 > y2, y2 = y1; end
                
                % Handle cases where floor == ceil
                if x1 == x2 && y1 == y2
                    interpolated_value = inputImage_double(y1, x1, :);
                else
                     % Calculate fractional distances using the interpolation coordinates
                    dx = interp_u - x1;
                    dy = interp_v - y1;

                    % Get neighbor values
                    P1 = inputImage_double(y1, x1, :); % Top-left
                    P2 = inputImage_double(y1, x2, :); % Top-right
                    P3 = inputImage_double(y2, x1, :); % Bottom-left
                    P4 = inputImage_double(y2, x2, :); % Bottom-right

                    % Interpolate
                    interpolated_value = P1*(1-dx)*(1-dy) + P2*dx*(1-dy) + P3*(1-dx)*dy + P4*dx*dy;
                end

                % Assign value to output image
                outputImage_double(y, x, :) = interpolated_value;
            end % end if perform_interpolation

        end % end loop x
    end % end loop y

    % --- Convert back to original data type ---
    if strcmp(original_class, 'uint8')
        outputImage = im2uint8(outputImage_double);
    elseif strcmp(original_class, 'uint16')
         outputImage = im2uint16(outputImage_double);
    else
        outputImage = outputImage_double;
    end

    disp('Fisheye transformation complete.');
end
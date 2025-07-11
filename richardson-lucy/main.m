% --- Setup ---
original_image = imread('..\img\Ara_macao.jpg');
% IMPORTANT: Convert to a linear, floating point format for calculations
original_image_linear = double(rgb2lin(original_image));

K = 15; % Number of iterations
alpha = 0.2; % Temporal factor

% Create your sharpening PSF (e.g., a tight Gaussian)
psf = fspecial('gaussian', [5 5], 0.8);
psf_adjoint = rot90(psf, 2); % Adjoint is just the PSF rotated 180 degrees

% --- Main Loop (simulating video) ---
% For a real video, you would load frames in a loop
% For now, we simulate with a previous processed frame
prev_processed_linear_frame = original_image;
original_image_linear = original_image;

% Assume 'prev_processed_linear_frame' exists from the last loop iteration
% ... for the first frame, you'd skip the blend

% Stage 1: Temporal Smoothing
g = (original_image_linear * (1 - alpha)) + (prev_processed_linear_frame * alpha);

% Stage 2: Initialization
f = g; % Start with the smoothed input as the first estimate

% Stage 3: The RL Iterative Loop
for i = 1:K
    % 3a: Forward Blur
    blurred_estimate = imfilter(f, psf, 'replicate');

    % 3b: Ratio Calculation (add epsilon for stability)
    ratio = g ./ (blurred_estimate + 1e-9);

    % 3c: Back-Projection
    correction_factor = imfilter(ratio, psf_adjoint, 'replicate');

    % 3d: Multiplicative Update
    f = f .* correction_factor;

    % Optional: Visualize the progress
     imshow(lin2rgb(f));
     title(['Iteration: ', num2str(i)]);
     drawnow;
end

% Stage 4: Final Output
final_sharp_image_linear = f;
final_output_srgb = lin2rgb(final_sharp_image_linear);
imshow(final_output_srgb);

% ------------------------
% MAIN (run example)
% ------------------------
simulate_hercules('.\image\Input.png'); 

function simulate_hercules(image_path)
    % Simulate Hercules Graphics Card view of an input JPG image
    % Input:
    %   image_path : path to JPG image
    
    %----------------------
    % PARAMETERS
    %----------------------
    target_width  = 720;  % Hercules graphics resolution (approx)
    target_height = 348;
    threshold     = 0.5;  % Grayscale threshold for monochrome
    contrast_boost = 1.5; % contrast scaling
    sharpen_amount = 0.7; % sharpening factor
    dithering = true;     % enable Bayer dithering
    
    %----------------------
    % LOAD IMAGE
    %----------------------
    img = imread(image_path);
    img = im2double(img);  % normalize [0,1]
    
    %----------------------
    % CONVERT TO GRAYSCALE
    %----------------------
    if size(img, 3) == 3
        gray = 0.299 * img(:,:,1) + 0.587 * img(:,:,2) + 0.114 * img(:,:,3);
    else
        gray = img;
    end
    
    %----------------------
    % RESIZE TO HERCULES RESOLUTION
    %----------------------
    gray_resized = imresize(gray, [target_height, target_width], 'bicubic');
    
    %----------------------
    % CONTRAST ENHANCEMENT
    %----------------------
    mean_val = mean(gray_resized(:));
    gray_resized = (gray_resized - mean_val) * contrast_boost + mean_val;
    gray_resized = min(max(gray_resized, 0), 1);
    
    %----------------------
    % SHARPENING (simple Laplacian-based)
    %----------------------
    h = fspecial('laplacian', 0.2);
    edges = imfilter(gray_resized, h, 'replicate');
    gray_resized = gray_resized - sharpen_amount * edges;
    gray_resized = min(max(gray_resized, 0), 1);
    
    %----------------------
    % DITHERING (Bayer 8x8 ordered dithering)
    %----------------------
    if dithering
        bayer8 = [0 48 12 60 3 51 15 63;
                  32 16 44 28 35 19 47 31;
                  8 56 4 52 11 59 7 55;
                  40 24 36 20 43 27 39 23;
                  2 50 14 62 1 49 13 61;
                  34 18 46 30 33 17 45 29;
                  10 58 6 54 9 57 5 53;
                  42 26 38 22 41 25 37 21] / 64;
        [hgt, wdt] = size(gray_resized);
        tiled_bayer = repmat(bayer8, ceil(hgt/8), ceil(wdt/8));
        tiled_bayer = tiled_bayer(1:hgt, 1:wdt);
        
        binary_img = gray_resized > (threshold + (tiled_bayer - 0.5) * 0.2);
    else
        % Simple threshold
        binary_img = gray_resized > threshold;
    end
    
    %----------------------
    % UPSCALE BACK TO ORIGINAL IMAGE SIZE
    %----------------------
    [orig_h, orig_w, ~] = size(img);
    final_img = imresize(binary_img, [orig_h, orig_w], 'nearest');
    
    %----------------------
    % DISPLAY RESULT
    %----------------------
    figure;
    subplot(1,2,1);
    imshow(img);
    title('Original Image');
    
    subplot(1,2,2);
    imshow(final_img);
    colormap(gca, [0 0 0; 1 1 1]);   % black and white % % pure black/white
    title('Simulated Hercules Monitor');
end



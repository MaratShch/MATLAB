clear; clc;

simulate_vga();


function simulate_vga()
    % Read input JPG
    img = imread('.\image\Input.png');
    if size(img,3) == 1
        img = repmat(img,[1 1 3]);
    end

    % VGA 16-color palette
    VGA16 = uint8([
        0 0 0;
        0 0 170;
        0 170 0;
        0 170 170;
        170 0 0;
        170 0 170;
        170 85 0;
        170 170 170;
        85 85 85;
        85 85 255;
        85 255 85;
        85 255 255;
        255 85 85;
        255 85 255;
        255 255 85;
        255 255 255
    ]);

    % VGA 256-color palette (6x6x6 + grayscale)
    VGA256 = [];
    for r = 0:5
        for g = 0:5
            for b = 0:5
                VGA256(end+1,:) = [r g b] * 51;
            end
        end
    end
    for i = 0:23
        v = i*10 + 8;
        VGA256(end+1,:) = [v v v];
    end
    VGA256 = uint8(VGA256);

    % Resize to VGA resolution
    img_resized = imresize(img, [480 640]);

    % Quantize to 16 colors
    out16 = quantize_palette(img_resized, VGA16);
    imwrite(out16, 'vga16_output.jpg');

    % Quantize to 256 colors
    out256 = quantize_palette(img_resized, VGA256);
    imwrite(out256, 'vga256_output.jpg');
end

function out = quantize_palette(img, palette)
    img = double(img);
    palette = double(palette);
    [h,w,~] = size(img);
    out = zeros(h,w,3,'uint8');

    for y = 1:h
        for x = 1:w
            pixel = squeeze(img(y,x,:))';
            diffs = sum((palette - pixel).^2,2);
            [~,idx] = min(diffs);
            out(y,x,:) = uint8(palette(idx,:));
        end
    end
end


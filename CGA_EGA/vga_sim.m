% vga_fs_sim.m
% Usage:
%   vga_fs_sim('input.jpg','out16.jpg','16');   % 16-color VGA
%   vga_fs_sim('input.jpg','out256.jpg','256'); % 256-color VGA

vga_fs_sim('.\image\Input.png','out256.jpg','256');
vga_fs_sim('.\image\Input.png','out16.jpg' ,'16');

fprintf("Complete\n");

function vga_fs_sim(input_path, output_path, mode)
if nargin < 3, mode = '16'; end

img = imread(input_path);
if size(img,3) == 1, img = repmat(img,[1 1 3]); end
[H, W, ~] = size(img);
img = uint8(img);

% Active 4:3 area centered
target_W = min(W, floor(H*4/3));
target_H = min(H, floor(W*3/4));
x0 = floor((W - target_W)/2);
y0 = floor((H - target_H)/2);

VW = 640; VH = 480;        % VGA logical pixels
cell_w = double(target_W) / VW;
cell_h = double(target_H) / VH;

% Build virtual RGB (VH x VW) by supersampling (2x2)
SS = 2;
virt = zeros(VH, VW, 3, 'double');
for vy = 1:VH
    sy = y0 + (vy-1)*cell_h;
    for vx = 1:VW
        sx = x0 + (vx-1)*cell_w;
        acc = [0 0 0];
        for jy = 1:SS
            yy = round(sy + (jy-0.5)*(cell_h/SS));
            yy = clampi(yy, 1, H);
            for jx = 1:SS
                xx = round(sx + (jx-0.5)*(cell_w/SS));
                xx = clampi(xx, 1, W);
                acc = acc + double(reshape(img(yy,xx,:),[1 3]));
            end
        end
        virt(vy, vx, :) = acc / (SS*SS);
    end
end

% Palettes
VGA16 = uint8([
    0 0 0; 0 0 170; 0 170 0; 0 170 170;
    170 0 0; 170 0 170; 170 85 0; 170 170 170;
    85 85 85; 85 85 255; 85 255 85; 85 255 255;
    255 85 85; 255 85 255; 255 255 85; 255 255 255
]);
VGA256 = make_vga256();

if strcmp(mode, '16')
    palette = double(VGA16);
else
    palette = double(VGA256);
end

% Floyd–Steinberg dithering in RGB
work = virt;                 % double
idx = zeros(VH, VW, 'uint16');

for y = 1:VH
    for x = 1:VW
        old = squeeze(work(y,x,:))';  % 1x3
        diffs = palette - old;
        dists = sum(diffs.^2,2);
        [~, i] = min(dists);
        new = palette(i, :);
        idx(y,x) = i;
        err = old - new;
        if x+1 <= VW,   work(y, x+1, :) = squeeze(work(y, x+1, :))' + err*(7/16); end
        if y+1 <= VH
            if x-1 >= 1, work(y+1, x-1, :) = squeeze(work(y+1, x-1, :))' + err*(3/16); end
            work(y+1, x, :) = squeeze(work(y+1, x, :))' + err*(5/16);
            if x+1 <= VW, work(y+1, x+1, :) = squeeze(work(y+1, x+1, :))' + err*(1/16); end
        end
    end
end

% Paint back into original size (centered 4:3 area)
out = zeros(H, W, 3, 'uint8'); % letterbox background black
for vy = 1:VH
    sy = y0 + (vy-1)*cell_h;
    ey = y0 + vy*cell_h;
    ys = max(1, floor(sy)) : min(H, ceil(ey)-1);
    for vx = 1:VW
        sx = x0 + (vx-1)*cell_w;
        ex = x0 + vx*cell_w;
        xs = max(1, floor(sx)) : min(W, ceil(ex)-1);
        c = uint8(palette(idx(vy, vx), :));
        out(ys, xs, 1) = c(1);
        out(ys, xs, 2) = c(2);
        out(ys, xs, 3) = c(3);
    end
end

imwrite(out, output_path);

end

% ---- helpers ----
function v = clampi(v, lo, hi), v = max(lo, min(hi, v)); end
function P = make_vga256()
    P = zeros(256,3,'uint8');
    steps = [0 51 102 153 204 255];
    k = 1;
    for r = steps
        for g = steps
            for b = steps
                P(k,:) = [r g b]; k = k+1;
            end
        end
    end
    left = 256 - (k-1);
    grays = round(linspace(0,255,left));
    for g = grays
        P(k,:) = uint8([g g g]); k = k+1;
        if k>256, break; end
    end
end

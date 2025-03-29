function linear_rgb = srgb_to_linear(srgb)
% Converts sRGB values (in range [0, 1]) to linear RGB values.

    if (srgb <= 0.04045)
        linear_rgb = srgb / 12.92;
    else
        srgb_double = double(srgb); % Explicitly convert to double
        linear_rgb = ((srgb_double + 0.055) / 1.055).^2.4;
    end

end
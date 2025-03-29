function [X, Y, Z] = sRGB2XYZ(r, g, b, applyGamma)
    % Convert sRGB (normalized 0-1) to XYZ (scaled to 100)
    % applyGamma = true -> Apply gamma correction
    % applyGamma = false -> No gamma correction (linear RGB)
    
    if applyGamma
        % Gamma correction function
        gammaCorrect = @(c) ((c > 0.04045) .* ((c + 0.055) / 1.055).^2.4) + ...
                            ((c <= 0.04045) .* (c / 12.92));
    else
        gammaCorrect = @(c) c; % No gamma correction
    end

    % Apply gamma correction
    R = gammaCorrect(r) * 100;
    G = gammaCorrect(g) * 100;
    B = gammaCorrect(b) * 100;

    % Transformation matrix from sRGB to XYZ (D65)
    X =  0.4124564 * R + 0.3575761 * G + 0.1804375 * B;
    Y =  0.2126729 * R + 0.7151522 * G + 0.0721750 * B;
    Z =  0.0193339 * R + 0.1191920 * G + 0.9503041 * B;
end
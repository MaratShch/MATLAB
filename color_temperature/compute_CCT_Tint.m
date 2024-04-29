function [CCT, Tint] = compute_CCT_Tint(normalized_XYZ_image)
    % Compute CCT and Tint for each pixel in the normalized XYZ image

    [M, N, ~] = size(normalized_XYZ_image);
    CCT = zeros(M, N);
    Tint = zeros(M, N);

    for i = 1:M
        for j = 1:N
            [CCT(i, j), Tint(i, j)] = compute_CCT_Tint_Pixel(normalized_XYZ_image(i, j, :));
        end
    end
end

function [CCT, Tint] = compute_CCT_Tint_Pixel(XYZ)
    % Compute CCT and Tint for a single pixel with normalized XYZ values

    % Compute u' and v' from normalized XYZ
    [u_prime, v_prime] = XYZ_to_uv_prime(XYZ);

    % Compute CCT and Tint
    CCT = compute_CCT(u_prime, v_prime);
    Tint = compute_Tint(u_prime, v_prime);
end

function [u_prime, v_prime] = XYZ_to_uv_prime(XYZ)
    % Convert normalized XYZ to u' and v' chromaticity coordinates

    % Constants
    u_prime_n = 4 * XYZ(1) / sum(XYZ);
    v_prime_n = 9 * XYZ(2) / sum(XYZ);

    % Compute u' and v' coordinates
    u_prime = 4 * XYZ(1) / sum(XYZ);
    v_prime = 9 * XYZ(2) / sum(XYZ);

    % Handle special case when sum(XYZ) is 0
    if sum(XYZ) == 0
        u_prime = u_prime_n;
        v_prime = v_prime_n;
    end
end

function CCT = compute_CCT(u_prime, v_prime)
    % Compute correlated color temperature (CCT) from u' and v' coordinates

    x = 0.3320;
    y = 0.1858 - 0.37 * (u_prime / v_prime);
    CCT = 437 * (1 / ((x - 0.3320) / (y - 0.1858))^1.6);
end

function Tint = compute_Tint(u_prime, v_prime)
    % Compute tint from u' and v' coordinates

    Tint = 0.5 - 0.5 * (2 * u_prime - 12*v_prime + 3)^2 / ((2 * u_prime - 12*v_prime + 3)^2 + (3 * v_prime - 2)^2);
end

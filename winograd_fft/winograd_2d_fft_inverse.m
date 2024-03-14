function reconstructed_image = winograd_2d_fft_inverse(F_uv)
    % Size of the FFT
    [M, N] = size(F_uv);

    % Transformation Matrix F
    F = zeros(M, M);
    for x = 1:M
        for m = 1:M
            F(x, m) = cos((pi / M) * (m - 1/2) * (x - 1));
        end
    end

    % Pointwise Multiplication Matrix D
    D = zeros(M, M);
    for u = 1:M
        for x = 1:M
            D(u, x) = 2 / M * cos((pi / M) * (u - 1/2) * (x - 1/2));
        end
    end

    % Inverse of Pointwise Multiplication Matrix D
    D_inverse = zeros(M, M);
    for u = 1:M
        for x = 1:M
            D_inverse(u, x) = 2 / M * cos((pi / M) * (u - 1/2) * (x - 1/2));
        end
    end

    % Compute r(u, v) = F * F_uv * F'
    r = zeros(M, N);
    for u = 1:M
        for v = 1:N
            for x = 1:M
                for y = 1:N
                    r(u, v) = r(u, v) + F(u, x) * F(v, y) * F_uv(x, y);
                end
            end
        end
    end

    % Compute h(u, v) = r(u, v) .* D_inverse
    h = zeros(M, N);
    for u = 1:M
        for v = 1:N
            h(u, v) = r(u, v) * D_inverse(u, v);
        end
    end

    % Compute reconstructed_image = F' * h * F
    reconstructed_image = zeros(M, N);
    for x = 1:M
        for y = 1:N
            for u = 1:M
                for v = 1:N
                    reconstructed_image(x, y) = reconstructed_image(x, y) + F(u, x) * h(u, v) * F(v, y);
                end
            end
        end
    end

    % Normalize the reconstructed image
    normalization_factor = 1 / (M * N);
    reconstructed_image = reconstructed_image * normalization_factor;
end

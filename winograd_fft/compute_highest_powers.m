function [powers_M, powers_N] = compute_highest_powers(M, N)
    % Function to compute highest powers of prime factors for image size M x N

    % Prime factorization of M
    factors_M = factor(M);
    unique_factors_M = unique(factors_M);
    powers_M = zeros(size(unique_factors_M));

    % Compute highest powers for M
    for i = 1:length(unique_factors_M)
        prime_factor = unique_factors_M(i);
        while mod(M, prime_factor^powers_M(i)) == 0
            powers_M(i) = powers_M(i) + 1;
        end
        powers_M(i) = powers_M(i) - 1;  % Reduce by 1 to get highest power
    end

    % Prime factorization of N
    factors_N = factor(N);
    unique_factors_N = unique(factors_N);
    powers_N = zeros(size(unique_factors_N));

    % Compute highest powers for N
    for i = 1:length(unique_factors_N)
        prime_factor = unique_factors_N(i);
        while mod(N, prime_factor^powers_N(i)) == 0
            powers_N(i) = powers_N(i) + 1;
        end
        powers_N(i) = powers_N(i) - 1;  % Reduce by 1 to get highest power
    end
end
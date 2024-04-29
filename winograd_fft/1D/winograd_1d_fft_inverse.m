function restored_signal = winograd_1d_fft_inverse (complex_output)
    % Function to compute the inverse 1D Winograd FFT to restore the original signal
    %
    % Parameters:
    %   complex_output: Complex output of the Winograd 1D FFT (1D array)
    %
    % Output:
    %   restored_signal: Restored signal after inverse Winograd 1D FFT

    N = length(complex_output);
    restored_signal = zeros(1, N);

    for k = 1:N
        % Initialize the restored sample
        restored_sample = 0;

        % Compute the restored sample at index k
        for n = 1:N
            cos_term = cos(2*pi*(n-1)*(k-1)/N);
            sin_term = sin(2*pi*(n-1)*(k-1)/N);
            restored_sample = restored_sample + real(complex_output(n)) * cos_term - imag(complex_output(n)) * sin_term;
        end

        % Store the restored sample in correct order
        restored_signal(k) = restored_sample / N;
    end
end


% % function output = winograd_1d_fft_inverse (real_input)
% %     % Function to compute inverse Winograd 1D FFT for a given input sequence
% %     %
% %     % Parameters:
% %     %   real_input: Real part of the Winograd 1D FFT output (1D array)
% %     %
% %     % Output:
% %     %   output: Inverse Winograd 1D FFT result (1D array)
% % 
% %     N = length(real_input);
% %     output = zeros(1, N);
% % 
% %     % Calculate the inverse WFTA for each output point
% %     for n = 1:N
% %         % Initialize the input for the n-th output
% %         input_val = 0;
% % 
% %         % Compute the n-th element of the inverse WFTA output
% %         for k = 1:N
% %             % Calculate the cosine term only (no need for sine term)
% %             cos_term = cos(2*pi*(n-1)*(k-1)/N);
% %             % Accumulate the input value
% %             input_val = input_val + real_input(k) * cos_term;
% %         end
% %         % Normalize and store the result
% %         output(n) = input_val / N;
% %     end
% % end

function output_signal = winograd_1d_fft_inverse(complex_input)
    % Function to compute the inverse 1D Winograd FFT to reconstruct the original real signal
    %
    % Parameters:
    %   complex_input: Array of complex numbers (1D) representing the Winograd 1D FFT output
    %
    % Output:
    %   output_signal: Reconstructed original real signal from the inverse Winograd 1D FFT

    N = length(complex_input);
    output_signal = zeros(1, N);

    % Calculate the inverse Winograd FFT for each output point
    for n = 1:N
        % Initialize the output signal for the n-th point
        output_n = 0;

        % Compute the n-th element of the output signal
        for k = 1:N
            % Calculate the cosine and sine terms
            cos_term = cos(2*pi*(n-1)*(k-1)/N);
            sin_term = -sin(2*pi*(n-1)*(k-1)/N); 
            
            % Accumulate the real part of the output signal
            output_n = output_n + real(complex_input(k) * (cos_term + 1i*sin_term));
        end
        % Store the reconstructed signal
        output_signal(n) = output_n / N;
    end
end
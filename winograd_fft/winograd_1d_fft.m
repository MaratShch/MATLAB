function complex_output = winograd_1d_fft(input)
    % Function to compute real and imaginary parts of Winograd 1D FFT for a given input sequence
    %
    % Parameters:
    %   input: Input sequence to transform (1D array)
    %
    % Output:
    %   real_output: Real part of the Winograd 1D FFT output
    %   imag_output: Imaginary part of the Winograd 1D FFT output

    N = length(input);
    real_output = zeros(1, N);
    imag_output = zeros(1, N);

    % Calculate the real and imaginary parts of the WFTA for each output point
    for k = 1:N
        % Initialize the real and imaginary parts for the k-th output
        real_part = 0;
        imag_part = 0;

        % Compute the k-th element of the real and imaginary parts of the WFTA output
        for n = 1:N
            % Calculate the cosine and sine terms
            cos_term =  cos(2*pi*(n-1)*(k-1)/N);
            sin_term = -sin(2*pi*(n-1)*(k-1)/N);
            
            % Accumulate the real and imaginary parts
            real_part = real_part + input(n) * cos_term;
            imag_part = imag_part + input(n) * sin_term;
        end
        % Store the real and imaginary results
        real_output(k) = real_part;
        imag_output(k) = imag_part;
    end
    
    % Combine real and imaginary parts into complex numbers
    complex_output = complex(real_output, imag_output);
end


function illuminant_spd = Planck (Wavelengths, WhitePoint)
    % Constants
    c = 299792458;        % Speed of light in m/s
    h = 6.62607015e-34;   % Planck's constant in m^2 kg/s
    k = 1.380649e-23;     % Boltzmann's constant in m^2 kg/s^2 K

    % Convert wavelength to meters
    lambda = Wavelengths / 1e9;  % Convert nm to meters

    % Calculate spectral radiance for each wavelength
    spectral_radiance = (2 * pi * c^2 * h) ./ (lambda.^5 .* (exp((h * c) ./ (lambda * k * WhitePoint)) - 1));

    % Normalize to have a peak value of 1.0
    illuminant_spd = spectral_radiance / max(spectral_radiance);
end
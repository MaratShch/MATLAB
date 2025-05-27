% % Planckian locus or black body locus is the path or locus that the color of 
% % an incandescent black body would take in a particular chromaticity space 
% % as the blackbody temperature changes
function illuminant_spd = Planck (Wavelengths, WhitePoint)
    % Constants
    c = 299792458;        % Speed of light in m/s
    h = 6.62607015e-34;   % Planck's constant in m^2 kg/s
    k = 1.380649e-23;     % Boltzmann's constant in m^2 kg/s^2 K

    % Convert wavelength to meters
    lambda = Wavelengths / 1e9;  % Convert nm to meters

    % Planck’s law (spectral radiance, W·sr?¹·m?³)
    spectral_radiance = (2 * h * c^2) ./ (lambda .^ 5 .* (exp((h * c) ./ (lambda * k * WhitePoint)) - 1));

    % Normalize to have a peak value of 1.0
    illuminant_spd = spectral_radiance / max(spectral_radiance);
end
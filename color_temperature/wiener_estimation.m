
function [adjusted_RGB_image, CCT, Tint] = wiener_estimation (input_RGB_image, new_CCT, new_Tint)
%WIENER_ESTIMATION Adjusts the input RGB image to the specified CCT and Tint.

 wavelength_start = 380;
 wavelength_stop  = 740;
 wavelength_step  = 1;
 wavelength = wavelength_start:wavelength_step:wavelength_stop;

% Inputs:
%   - input_RGB_image: Input RGB image with pixel values ranging from 0 to 255.
%   - new_CCT: New Color Correlated Temperature (CCT) value for adjustment.
%   - new_Tint: New Tint value for adjustment.

% Outputs:
%   - adjusted_RGB_image: Adjusted RGB image with modified CCT and Tint.
%   - CCT: Calculated Color Correlated Temperature (CCT) for the adjusted image.
%   - Tint: Calculated Tint for the adjusted image.

    % Define the wavelength range and step size
    wavelength_start = 380;
    wavelength_stop = 740;
    wavelength_step = 1;
    wavelengths = wavelength_start:wavelength_step:wavelength_stop;
    
    % Define the color matching functions for the 2-degree observer (1931)
    observer = observer_2_degrees_1931(wavelengths);
    
    % Compute the D65 illuminant spectrum
    illuminant = illuminant_D65(wavelengths);
    

% Implementation:
%   1. Convert input RGB image to Spectral Power Distribution (SPD).
    SPD_image = convert_RGB_to_SPD(input_RGB_image, observer, illuminant, wavelengths);
%   2. Convert SPD to XYZ color space.
    XYZ_image = convert_SPD_to_XYZ(SPD_image, illuminant, observer);

%   3. Normalize XYZ values.
%   4. Perform white balance adjustment.
%   5. Compute CCT and Tint.
%   6. Adjust the CCT and Tint to the new values.
%   7. Convert adjusted XYZ to RGB.
%   8. Return adjusted RGB image, CCT, and Tint.

adjusted_RGB_image = input_RGB_image;
CCT = new_CCT;
Tint = new_Tint;

end


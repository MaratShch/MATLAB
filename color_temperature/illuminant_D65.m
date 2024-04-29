function illuminant_spd = illuminant_d65 (wavelengths)
    % Temperature of D65 illuminant in Kelvin
    T = 6504;             
    illuminant_spd = Planck (wavelengths, T);
end
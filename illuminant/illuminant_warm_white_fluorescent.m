function illuminant_spd = illuminant_warm_white_fluorescent(wavelengths)
    % Temperature of Warm White Fluorescent illuminant in Kelvin
    T = 3000;             
    illuminant_spd = Planck (wavelengths, T);
end

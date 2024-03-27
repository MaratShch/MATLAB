function illuminant_spd = illuminant_fluorescent_daylight(wavelengths)
    % Temperature of day light fluorescent illuminant in Kelvin
    T = 5000;             
    illuminant_spd = Planck (wavelengths, T);
end

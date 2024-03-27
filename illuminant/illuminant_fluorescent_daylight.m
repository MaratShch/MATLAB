function illuminant_spd = illuminant_fluorescent_daylight(wavelengths)
    % Temperature of tungsten illuminant in Kelvin
    T = 5000;             
    illuminant_spd = Planck (wavelengths, T);
end

function illuminant_spd = illuminant_tungsten(wavelengths)
    % Temperature of tungsten illuminant in Kelvin
    T = 2856;             
    illuminant_spd = Planck (wavelengths, T);
end

function bar = z_1964 (wavelength)
    t = log((wavelength - 266.0) / 180.40);
    bar = 2.060 * exp (-32.0 * t * t);
end
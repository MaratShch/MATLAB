function bar = z_1931 (wavelength)
    if (wavelength < 437.0)
        t1 = (wavelength - 437.0) * 0.08450;
    else
        t1 = (wavelength - 437.0) * 0.02780;
    end
    
    if (wavelength < 459.0)
        t2 = (wavelength - 459.0) * 0.03850;
    else
        t2 = (wavelength - 459.0) * 0.07250;
    end
    bar = 1.2170 * exp(-0.5 * t1 * t1) + 0.6810 * exp(-0.5 * t2 * t2);
end
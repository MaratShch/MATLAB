function bar = x_1931 (wavelength)
    if (wavelength < 442.0)
        t1 = (wavelength - 442.0) * 0.0624;
    else
        t1 = (wavelength - 442.0) * 0.0374;
    end
    if (wavelength < 599.8)
        t2 = (wavelength - 599.8) * 0.0264;
    else
        t2 = (wavelength - 599.8) * 0.0323;
    end
    if (wavelength < 501.1)
        t3 = (wavelength - 501.1) * 0.0490;
    else
        t3 = (wavelength - 501.1) * 0.0382;
    end
    bar = 0.362 * exp(-0.50 * t1 * t1) + 1.056 * exp(-0.50 * t2 * t2) - 0.065 * exp(-0.50 * t3 * t3);   
end
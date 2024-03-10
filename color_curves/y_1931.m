function bar = y_1931 (wavelength)
    if (wavelength < 568.8)
        t1 = (wavelength - 568.8) * 0.02130;
    else
        t1 = (wavelength - 568.8) * 0.02470;
    end
    
    if (wavelength < 530.9)
        t2 = (wavelength - 530.9) * 0.06130;
    else
        t2 = (wavelength - 530.9) * 0.03220;
    end
    bar = 0.821 * exp(-0.5 * t1 * t1) + 0.286 * exp(-0.5 * t2 * t2);
end
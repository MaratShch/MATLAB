function bar = x_1964 (wavelength)
    a = log((wavelength + 570.0) / 1014.0);
    t1 = 0.40 * exp (-1250.0 * a * a);
    b = log((1338.0 - wavelength) / 743.50);
    t2 = 1.130 * exp(-234.0 * b * b);
    bar = t1 + t2;
end
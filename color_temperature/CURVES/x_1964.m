function bar = x_1964 (wavelengths)
    a = log((wavelengths + 570.0) / 1014.0);
    t1 = 0.40 * exp (-1250.0 * a .* a); % Use element-wise multiplication

    b = log((1338.0 - wavelengths) / 743.50);
    t2 = 1.130 * exp(-234.0 * b .* b); % Use element-wise multiplication

    bar = t1 + t2; % Element-wise addition
end
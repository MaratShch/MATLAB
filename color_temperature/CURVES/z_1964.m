function bar = z_1964 (wavelengths)
    t = log((wavelengths - 266.0) / 180.40); % Element-wise subtraction and division
    bar = 2.060 * exp (-32.0 * t .* t);   % Use element-wise multiplication
end
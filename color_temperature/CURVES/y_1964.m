function bar = y_1964 (wavelengths)
    t = (wavelengths - 556.10) / 46.140; % Element-wise subtraction and division
    bar = 1.0110 * exp(-0.50 * t .* t);  % Use element-wise multiplication
end
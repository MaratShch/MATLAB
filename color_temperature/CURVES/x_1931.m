function bar = x_1931 (wavelengths)
    bar = zeros(size(wavelengths)); % Initialize output vector

    % Apply the first condition element-wise
    condition1 = wavelengths < 442.0;
    t1_true = (wavelengths(condition1) - 442.0) * 0.0624;
    t1_false = (wavelengths(~condition1) - 442.0) * 0.0374;
    t1 = zeros(size(wavelengths));
    t1(condition1) = t1_true;
    t1(~condition1) = t1_false;

    % Apply the second condition element-wise
    condition2 = wavelengths < 599.8;
    t2_true = (wavelengths(condition2) - 599.8) * 0.0264;
    t2_false = (wavelengths(~condition2) - 599.8) * 0.0323;
    t2 = zeros(size(wavelengths));
    t2(condition2) = t2_true;
    t2(~condition2) = t2_false;

    % Apply the third condition element-wise
    condition3 = wavelengths < 501.1;
    t3_true = (wavelengths(condition3) - 501.1) * 0.0490;
    t3_false = (wavelengths(~condition3) - 501.1) * 0.0382;
    t3 = zeros(size(wavelengths));
    t3(condition3) = t3_true;
    t3(~condition3) = t3_false;

    % Calculate 'bar' using element-wise operations
    bar = 0.362 * exp(-0.50 * t1 .* t1) + 1.056 * exp(-0.50 * t2 .* t2) - 0.065 * exp(-0.50 * t3 .* t3);
end
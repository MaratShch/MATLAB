function bar = z_1931 (wavelengths)
    bar = zeros(size(wavelengths)); % Initialize output vector

    % Apply the first condition element-wise
    condition1 = wavelengths < 437.0;
    t1_true = (wavelengths(condition1) - 437.0) * 0.08450;
    t1_false = (wavelengths(~condition1) - 437.0) * 0.02780;
    t1 = zeros(size(wavelengths));
    t1(condition1) = t1_true;
    t1(~condition1) = t1_false;

    % Apply the second condition element-wise
    condition2 = wavelengths < 459.0;
    t2_true = (wavelengths(condition2) - 459.0) * 0.03850;
    t2_false = (wavelengths(~condition2) - 459.0) * 0.07250;
    t2 = zeros(size(wavelengths));
    t2(condition2) = t2_true;
    t2(~condition2) = t2_false;

    % Calculate 'bar' using element-wise operations
    bar = 1.2170 * exp(-0.5 * t1 .* t1) + 0.6810 * exp(-0.5 * t2 .* t2);
end
function bar = y_1931 (wavelengths)
    bar = zeros(size(wavelengths)); % Initialize output vector

    % Apply the first condition element-wise
    condition1 = wavelengths < 568.8;
    t1_true = (wavelengths(condition1) - 568.8) * 0.02130;
    t1_false = (wavelengths(~condition1) - 568.8) * 0.02470;
    t1 = zeros(size(wavelengths));
    t1(condition1) = t1_true;
    t1(~condition1) = t1_false;

    % Apply the second condition element-wise
    condition2 = wavelengths < 530.9;
    t2_true = (wavelengths(condition2) - 530.9) * 0.06130;
    t2_false = (wavelengths(~condition2) - 530.9) * 0.03220;
    t2 = zeros(size(wavelengths));
    t2(condition2) = t2_true;
    t2(~condition2) = t2_false;

    % Calculate 'bar' using element-wise operations
    bar = 0.821 * exp(-0.5 * t1 .* t1) + 0.286 * exp(-0.5 * t2 .* t2);
end
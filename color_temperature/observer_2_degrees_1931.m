function observer = observer_2_degrees_1931 (wavelengths)

lambda = wavelengths;

LambdaSize = size(lambda);
x_bar1931 = zeros(LambdaSize);
y_bar1931 = zeros(LambdaSize);
z_bar1931 = zeros(LambdaSize);
observer  = zeros(3, LambdaSize(2));

% compute x, y and z curves values
idx = 1;
for wavelength=lambda
    x_bar1931(idx) = x_1931(wavelength);
    y_bar1931(idx) = y_1931(wavelength);
    z_bar1931(idx) = z_1931(wavelength);
    idx = idx + 1;
end

observer(1, :) = x_bar1931;
observer(2, :) = y_bar1931;
observer(3, :) = z_bar1931;

end

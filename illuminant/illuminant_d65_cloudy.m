function spectral_radiance_d65_cloudy = illuminant_d65_cloudy(wavelengths, tint_factor)
    spectral_radiance_d65_cloudy = illuminant_d65(wavelengths) * (1.0 - tint_factor);
end

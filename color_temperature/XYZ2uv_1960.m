% convert XYZ tristimulus to u and v chromaticity points
function [u,v] = XYZ2uv_1960 (X, Y, Z)
   xy_to_uv = @(x, y, z) deal((4*X) / ((X) + (15*Y) + (3*Z)), (6*Y) / ((X) + (15*Y) + (3*Z)));
   [u, v] = xy_to_uv(X, Y, Z);
end

% convert XYZ tristimulus to u' and v' chromaticity points
function [u,v] = XYZ2uv_1976 (X, Y, Z)
   xy_to_uv = @(x, y, z) deal((4*X) / ((X) + (15*Y) + (3*Z)), (9*Y) / ((X) + (15*Y) + (3*Z)));
   [u, v] = xy_to_uv(X, Y, Z);
end

% convert XYZ tristimulus to u and v chromaticity points
function [u,v] = XYZ2uv (X, Y, Z)
   x = X / (X + Y + Z);
   y = Y / (X + Y + Z);
      
   xy_to_uv = @(x, y) deal((4*x) / ((-2*x) + (12*y) + 3), (6*y) / ((-2*x) + (12*y) + 3));
   [u, v] = xy_to_uv(x, y);
end

function [Cct, Duv] = RGB2CctDuv (R, G, B, gamma, lut)
  [X, Y, Z] = sRGB2XYZ(R/255.0, G/255.0, B/255.0, gamma);
  [u0, v0] = XYZ2uv(X, Y, Z);

  % Get initial value of CCT and Duv from chromaticity coordinates u and v
  idx = FindClosestCCT (u0, v0, lut);
  iCct = lut(idx).cct;
  iDuv = lut(idx).duv;
  
 
  [refinedCCT, refinedDuv, refined_u, refined_v] = refine_CCT_Duv(u0, v0, iCct, iDuv, lut)

end
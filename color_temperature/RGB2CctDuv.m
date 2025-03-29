function [Cct, Duv] = RGB2CctDuv (R, G, B, gamma, lut)
  [X, Y, Z] = sRGB2XYZ(R/255.0, G/255.0, B/255.0, gamma);
  [u, v] = XYZ2uv(X, Y, Z);

  % Get initial value of CCT and Duv from chromaticity coordinates u and v
  idx = FindClosestCCT (u, v, lut);
  iCct = lut(idx).cct;
  iDuv = lut(idx).duv;
  
  %%% Refinement Loop
  maxIterations = 16;  % Maximum number of refinement cycles
  tolerance_CCT = 1;   % CCT tolerance in Kelvin
  tolerance_Duv = 0.0002; % Duv tolerance
  
  iteration = 0;
  CCT_old = iCct;
  Duv_old = iDuv;
  
  while (iteration < maxIterations)
    % Compute new CCT and Duv estimates here

    
    % Check if refinement is within tolerance
    if (abs(CCT_new - CCT_old) < tolerance_CCT) && (abs(Duv_new - Duv_old) < tolerance_Duv)
        break;  % Exit loop if tolerance reached
    end

    % Update values for next iteration
    CCT_old = CCT_new;
    Duv_old = Duv_new;
    
    iteration = iteration + 1;
  end
  
  Cct = iCct;
  Duv = iDuv;
end
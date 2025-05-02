function [refinedCCT, refinedDuv, refined_u, refined_v] = refine_CCT_Duv(u0, v0, initialCCT, initialDuv, lut)
% Refines CCT and Duv using Ohno's 2013 advanced algorithm
% INPUT:
%   u0, v0       - initial chromaticity coordinates
%   initialCCT   - initial CCT estimate from LUT (Kelvin)
%   initialDuv   - initial Duv estimate from LUT
%   lut          - LUT as an array of structs with fields: u, v, cct, duv
% OUTPUT:
%   refinedCCT   - refined correlated color temperature
%   refinedDuv   - refined Duv
%   refined_u, v - refined chromaticity coordinates

    % === Parameters ===
    maxIterations = 16;
    tol_CCT = 1.0;         % Kelvin
    tol_Duv = 0.0002;      % dimensionless

    % === Initialization ===
    refined_u = u0;
    refined_v = v0;
    refinedCCT = initialCCT;
    refinedDuv = initialDuv;

    stepSize = 0.0005;     % Optional: not required in this fixed projection version
    iteration = 0;

    % === Preconvert LUT to arrays for vectorized computation ===
    lut_u = [lut.u];
    lut_v = [lut.v];
    lut_cct = [lut.cct];

    while iteration < maxIterations
        iteration = iteration + 1;

        % --- Step 1: Project current (u,v) to closest Planckian point ---
        distances = hypot(refined_u - lut_u, refined_v - lut_v);
        [minDist, idx] = min(distances);

        % Get projected point and its CCT
        proj_u = lut_u(idx);
        proj_v = lut_v(idx);
        proj_CCT = lut_cct(idx);

        % --- Step 2: Direction vector from Planckian to test point ---
        delta_u = refined_u - proj_u;
        delta_v = refined_v - proj_v;
        dist_uv = hypot(delta_u, delta_v);

        if dist_uv == 0
            break; % Already aligned on Planckian locus
        end

        direction = [delta_u, delta_v] / dist_uv;

        % --- Step 3: Update (u,v) by moving in same Duv direction ---
        refined_u = proj_u + direction(1) * initialDuv;
        refined_v = proj_v + direction(2) * initialDuv;

        % --- Step 4: Recompute refined Duv and CCT ---
        refinedDuv = norm([refined_u - proj_u, refined_v - proj_v]);
        deltaCCT = abs(proj_CCT - refinedCCT);
        deltaDuv = abs(refinedDuv - initialDuv);
        refinedCCT = proj_CCT;

        % --- Step 5: Exit if converged ---
        if deltaCCT < tol_CCT && deltaDuv < tol_Duv
            break;
        end

        % Optional: adjust step size for future use
        stepSize = stepSize * 0.8;
    end
end

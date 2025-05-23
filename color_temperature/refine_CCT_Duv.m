function [refinedCCT, refinedDuv, refinedU, refinedV] = refineCCTDuv(u0, v0, lut)
% Refines the initial coarse chromaticity coordinates (u0, v0)
% using Ohno�s 2013 combined method with CCT and Duv refinement.
% INPUT:
%   u0, v0  - initial chromaticity coordinates
%   lut     - LUT array with fields u, v, cct, duv
%
% OUTPUT:
%   refinedCCT, refinedDuv - refined values
%   refinedU, refinedV     - refined chromaticity coordinates

% === Tolerances and limits ===
CCT_TOL = 1.0;        % Kelvin
DUV_TOL = 0.0002;      % dimensionless
MAX_ITER = 16;

% === Initial projection ===
initialIdx = findClosestCCTIndex(u0, v0, lut);
refU = u0;
refV = v0;
refCCT = lut(initialIdx).cct;
refDuv = lut(initialIdx).duv;

% === Refinement loop ===
for iter = 1:MAX_ITER
    % Project current u,v onto LUT
    idx = findClosestCCTIndex(refU, refV, lut);
    base = lut(idx);

    % Direction to move in (unit tangent vector on LUT curve)
    if idx < length(lut)
        next = lut(idx + 1);
    else
        next = lut(idx - 1);
    end
    du = next.u - base.u;
    dv = next.v - base.v;
    direction = [du; dv] / norm([du; dv]);

    % Perpendicular direction (normal to the locus at this point)
    normal = [-direction(2); direction(1)];

    % Project current point to base point
    delta = [refU - base.u; refV - base.v];
    delta_duv = dot(delta, normal);   % how far we are from Planckian

    % Update chromaticity u,v by stepping back toward the locus
    step_size = 0.25 * delta_duv;
    refU = refU - step_size * normal(1);
    refV = refV - step_size * normal(2);

    % Update CCT and Duv
    idx_new = findClosestCCTIndex(refU, refV, lut);
    refCCT_new = lut(idx_new).cct;
    refDuv_new = dot([refU - lut(idx_new).u, refV - lut(idx_new).v], ...
                     [-direction(2), direction(1)]);

    % Check convergence
    if abs(refCCT_new - refCCT) < CCT_TOL && abs(refDuv_new - refDuv) < DUV_TOL
        break;
    end

    % Update values for next iteration
    refCCT = refCCT_new;
    refDuv = refDuv_new;
end

fprintf(' - Refinement takes %d cycles\n', iter);
% Final outputs
refinedCCT = refCCT;
refinedDuv = refDuv;
refinedU = refU;
refinedV = refV;
end

function idx = findClosestCCTIndex(u, v, lut)
% Finds index in LUT with closest Euclidean distance
    distances = arrayfun(@(e) sqrt((u - e.u)^2 + (v - e.v)^2), lut);
    [~, idx] = min(distances);
end

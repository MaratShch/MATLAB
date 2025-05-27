function [refinedCCT, refinedDuv, u_proj, v_proj] = refine_CCT_Duv(u0, v0, lut)

    % Step 1: extract u, v, cct vectors from LUT
    uLUT = [lut.u];
    vLUT = [lut.v];
    cctLUT = [lut.cct];

    % Step 2: find closest LUT point
    distances = (uLUT - u0).^2 + (vLUT - v0).^2;
    [~, idx_min] = min(distances);

    % Step 3: select ±2 neighbors around idx_min
    idx_range = max(1, idx_min-2):min(length(lut), idx_min+2);
    u_seg = uLUT(idx_range);
    v_seg = vLUT(idx_range);
    cct_seg = cctLUT(idx_range);

    % Step 4: fit parametric curve u(t), v(t), CCT(t) using normalized t
    t = linspace(0, 1, numel(u_seg));
    u_fit = spline(t, u_seg);
    v_fit = spline(t, v_seg);
    cct_fit = spline(t, cct_seg);

    % Step 5: objective = distance^2 from (u0, v0) to (u(t), v(t))
    objective = @(tval) (ppval(u_fit, tval) - u0).^2 + (ppval(v_fit, tval) - v0).^2;

    % Step 6: find t* minimizing objective (constrained to [0,1])
    options = optimset('TolX', 1e-10);
    t_star = fminbnd(objective, 0, 1, options);

    % Step 7: evaluate projection point and interpolated CCT
    u_proj = ppval(u_fit, t_star);
    v_proj = ppval(v_fit, t_star);
    refinedCCT = ppval(cct_fit, t_star);

    % Step 8: compute signed Duv (orthogonal distance)
    % Approximate local direction vector (tangent to curve)
    delta = 1e-5;
    u_tangent = (ppval(u_fit, t_star + delta) - ppval(u_fit, t_star - delta)) / (2*delta);
    v_tangent = (ppval(v_fit, t_star + delta) - ppval(v_fit, t_star - delta)) / (2*delta);
    tangent = [u_tangent, v_tangent];
    tangent = tangent / norm(tangent);  % Normalize

    % Compute signed orthogonal distance
    vec = [u0 - u_proj, v0 - v_proj];
    orthogonal_vec = vec - dot(vec, tangent) * tangent;
    refinedDuv = sign(det([tangent; vec])) * norm(orthogonal_vec);
end

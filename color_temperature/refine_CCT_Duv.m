function [refined_cct, refined_duv, u_refined, v_refined] = refineCCT_Duv(u0, v0, lut)

    % === Configuration ===
    MAX_ITER = 16;
    CCT_TOLERANCE = 1;          % in Kelvin
    DUV_TOLERANCE = 0.0002;     % dimensionless

    % === Initial chromaticity (u0,v0) ===
    u_refined = u0;
    v_refined = v0;

    % === Step 1: Find initial nearest point on Planckian locus ===
    [~, idx] = findClosestLUTIndex(u_refined, v_refined, lut);
    u_proj = lut(idx).u;
    v_proj = lut(idx).v;
    cct_proj = lut(idx).cct;

    % === Step 2: Estimate initial Duv ===
    du = u_refined - u_proj;
    dv = v_refined - v_proj;
    norm_dir = sqrt(du^2 + dv^2);
    if norm_dir == 0
        direction = [0, 0];
    else
        direction = [du, dv] / norm_dir;
    end
    initial_duv = norm_dir;

    % === Step 3: Initial values ===
    refined_cct = cct_proj;
    refined_duv = initial_duv;

    % === Begin refinement loop ===
    for iter = 1:MAX_ITER

        % --- Step 3.1: Project current (u,v) onto LUT to get new closest point ---
        [~, idx] = findClosestLUTIndex(u_refined, v_refined, lut);
        u_proj = lut(idx).u;
        v_proj = lut(idx).v;
        cct_proj = lut(idx).cct;

        % --- Step 3.2: Direction vector from projection to current (u,v) ---
        du = u_refined - u_proj;
        dv = v_refined - v_proj;
        norm_dir = sqrt(du^2 + dv^2);
        if norm_dir == 0
            direction = [0, 0];
        else
            direction = [du, dv] / norm_dir;
        end

        % --- Step 3.3: Update u,v using projected point + direction × initial_duv ---
        u_new = u_proj + direction(1) * initial_duv;
        v_new = v_proj + direction(2) * initial_duv;

        % --- Step 3.4: Compute new refined CCT/Duv ---
        [~, new_idx] = findClosestLUTIndex(u_new, v_new, lut);
        cct_new = lut(new_idx).cct;
        duv_new = sqrt((u_new - lut(new_idx).u)^2 + (v_new - lut(new_idx).v)^2);

        % --- Step 3.5: Check tolerances ---
        delta_CCT = abs(cct_new - refined_cct);
        delta_Duv = abs(duv_new - refined_duv);

        % Update results
        refined_cct = cct_new;
        refined_duv = duv_new;
        u_refined = u_new;
        v_refined = v_new;

        % --- Break condition ---
        if (delta_CCT < CCT_TOLERANCE) && (delta_Duv < DUV_TOLERANCE) && iter > 1
            break;
        end
    end
end

% === Utility Function: Find Closest LUT Index by Euclidean Distance ===
function [minDist, minIdx] = findClosestLUTIndex(u, v, lut)
    distances = arrayfun(@(entry) sqrt((u - entry.u)^2 + (v - entry.v)^2), lut);
    [minDist, minIdx] = min(distances);
end
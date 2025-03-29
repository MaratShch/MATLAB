function idx = FindClosestCCT(u, v, lut)
    % Find the closest CCT in the LUT using a binary search
    % Input:
    %   - u, v: Input chromaticity coordinates
    %   - lut: LUT structure with fields 'u' and 'v'
    % Output:
    %   - idx: Index of the closest CCT in the LUT

    % Helper function to compute Euclidean distance
    euclideanDistance = @(u1, v1, u2, v2) sqrt((u1 - u2)^2 + (v1 - v2)^2);

    % Binary search initialization
    low = 1;
    high = numel(lut);

    while low <= high
        mid = floor(low + (high - low) / 2);  % Prevent potential overflow

        % Compute distance to the mid point
        dist = euclideanDistance(u, v, lut(mid).u, lut(mid).v);

        % Check if mid is the closest point
        prevDist = inf; 
        nextDist = inf;
        
        if mid > 1
            prevDist = euclideanDistance(u, v, lut(mid-1).u, lut(mid-1).v);
        end
        if mid < numel(lut)
            nextDist = euclideanDistance(u, v, lut(mid+1).u, lut(mid+1).v);
        end

        if (mid == 1 || dist < prevDist) && (mid == numel(lut) || dist < nextDist)
            idx = mid;
            return;
        end

        % Navigate based on proximity
        if mid > 1 && prevDist < dist
            high = mid - 1;
        else
            low = mid + 1;
        end
    end

    % If no valid point is found, return first index as fallback
    idx = 1;
end

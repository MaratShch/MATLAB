function normalized_XYZ_image = normalize_XYZ(XYZ_image)
    % Function to normalize XYZ values of an image
    
    [M, N, ~] = size(XYZ_image);
    normalized_XYZ_image = zeros(M, N, 3);
    
    for i = 1:M
        for j = 1:N
            X = XYZ_image(i, j, 1);
            Y = XYZ_image(i, j, 2);
            Z = XYZ_image(i, j, 3);
            
            % Sum of XYZ values
            sum_xyz = X + Y + Z;
            
            % Avoid division by zero
            if sum_xyz == 0
                normalized_XYZ_image(i, j, :) = [0, 0, 0];
            else
                % Normalize XYZ values
                normalized_XYZ_image(i, j, 1) = X / sum_xyz;
                normalized_XYZ_image(i, j, 2) = Y / sum_xyz;
                normalized_XYZ_image(i, j, 3) = Z / sum_xyz;
            end
        end
    end
end

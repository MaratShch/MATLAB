function Ldiff = polinomial_compute_duv (u_prime, v_prime)

    u_diff = u_prime - 0.292;
    v_diff = v_prime - 0.240;
    Lfp = sqrt(u_diff.^2 + v_diff.^2);
    a = acos(u_diff ./ Lfp);

    k = [-0.471106, 1.925865, -2.4243787, 1.5317403, -0.5179722, 0.0893944, -0.00616793]; % k0 to k6

    Lbb = 0.0;
    for i = 1:length(k)
        Lbb = Lbb + k(i) * a.^(i-1);
    end

    Ldiff = Lfp - Lbb;

end
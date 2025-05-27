function [u,v,cct,duv] = ChromaticityPoints (Wavelengths, observer, CCTlengths)
  
  u = zeros(size(Wavelengths)); 
  v = zeros(size(Wavelengths)); 
  cct = zeros(size(Wavelengths));
  duv = zeros(size(Wavelengths));
  
  numElements = length(CCTlengths);
  for i = 1:numElements
      ct = CCTlengths(i);
      spd = Planck(Wavelengths, ct);
      
      X_vector = spd'.* observer(:,1);
      Y_vector = spd'.* observer(:,2);
      Z_vector = spd'.* observer(:,3);
      
      X = sum(X_vector);
      Y = sum(Y_vector);
      Z = sum(Z_vector);
      
      [u_prime, v_prime] = XYZ2uv_1960 (X, Y, Z);
      Duv = polinomial_compute_duv(u_prime, v_prime);
      
      u(i)   = u_prime;
      v(i)   = v_prime;
      cct(i) = ct;
      duv(i) = Duv;      

  end
  
end

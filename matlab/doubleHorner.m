function q = doubleHorner(p,rho,mu)

grootteP = size( p );
grootteP = grootteP(2);
% De eerste twee speciale gevallen doen
    
    q(1) = p(1);
    q(2) =  p(2) + q(1) * rho;

    % De eerste keer dubbelrijig horner ( b's berekenen)

    for graad = 3:(grootteP-2)
    
      %Dubbelrijig horner
    
       q(graad) = p(graad) + q(graad - 1) * rho - q(graad - 2) * mu;
    
    end
    
end

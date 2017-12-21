function q = doubleHorner(p,rho,mu)
%Dubbelrijige horner voert 2 deflatie stappen uit op p zodat p 2 graden 
%lager wordtdoor de factor x^2 + rho*x +mu  weg te delen via 
%de methode van Horner.
%  
%   Signatuur: q = doubleHorner( rho, mu)
%
%   @param p
%       De veelterm die de deflatie ondergaat, voorgesteld door zijn
%       coëfficiënten als vector, met de hoogste graad term als eerste
%       element enzovoort. Dit is een 1 x n vector.
%
%   @param rho
%       de coëfficiënt van x in de term die zal worden weggedeelt.
%   @param mu
%       de coëfficiënt in de term die zal worden weggedeelt.
%
%   @result q
%       De veelterm die het resultaat is van de deflatie van p, voorgesteld
%       door zijn coëfficiënten als vector, met de hoogste graad term als 
%       eerste element enzovoort. Dit is een 1 x n vector.
%
grootteP = size( p );
grootteP = grootteP(2);
% De eerste twee speciale gevallen doen
    
    q(1) = p(1);
    q(2) =  p(2) + q(1) * rho;

    for graad = 3:(grootteP-2)
    
      %Dubbelrijig horner
    
       q(graad) = p(graad) + q(graad - 1) * rho - q(graad - 2) * mu;
    
    end
    
end

function y = my_polyval( p, x, m)
%my_polyval Geeft de functiewaarde in c van de eerste m afgeleiden van p
%terug, via het uitgebreid schema van Horner.
%   
%   Signatuur: y = my_polyval( p, x, m)
%
%   @param p
%       De veelterm die geevalueerd zal worden, voorgesteld door zijn
%       coefficienten als vector, met de hoogste graad term als eerste
%       element enzovoort. Dit is een 1 x n vector.
%
%   @param x
%       Het punt waarin de functies zullen geevalueerd worden.
%
%   @param m
%       Het aantal keer dat p moet afgeleid worden.
%
%   @return y
%       De vector die de functiewaarden in x van de 0'de tot de m'de
%       afgeleide van p bevat.
%




graadStartPlusEen = size( p );
graadStartPlusEen = graadStartPlusEen(2);

% Kijk of er niet teveel afgeleid wordt.
if graadStartPlusEen <= m
    disp("m is groter of gelijk aan de graad van de veelterm + 1");
    y = NaN;
    return
end


y = zeros( m + 1, 1);

% p gebruiken, want minder geheugen gebruikt (call by value)


for afgeleide = 0:m
    
    % 1ste niet kopieren want die zit al in p.
    
    for coefficient = 2:(graadStartPlusEen - afgeleide)
        
        %De coefficienten aanpassen. Alle ellementen van p voor 
        %p(coefficient) zijn al aangepast, dus de 2de term
        %in onderstaande formule ook.
        
        p(coefficient) = p(coefficient) + p(coefficient - 1)*x;
        
    end
    
    %De functiewaarde in x van deze afgeleide berekenen en opslaan.
    %y begint bij 1 en eindigt bij m + 1, dus 1 verder zetten.
    
    y(afgeleide + 1) = factorial(afgeleide) * p(graadStartPlusEen - afgeleide);
    
    
    
end
end


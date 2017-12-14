function q = horner( p, x)
%horner Voert een deflatie stap uit op p zodat p een graad lager word en
%door de factor met nulpunt x, en indien x complex is ook zijn complex 
%toegvoegde, weg te delen via de methode van Horner.
%  
%   Signatuur: q = horner( p, x)
%
%   @param p
%       De veelterm die de deflatie ondergaat, voorgesteld door zijn
%       coefficienten als vector, met de hoogste graad term als eerste
%       element enzovoort.
%
%   @param x
%       Het nulpunt die zal weggedeeld worden in p.
%
%   @result q
%       De veelterm die het resultaat is van de deflatie van p, voorgesteld
%       door zijn coefficienten als vector, met de hoogste graad term als 
%       eerste element enzovoort.
%

%INDIEN X COMPLEX IS MOET JE ZIJN COMPLEX TOEGEVOEGDE OOK VERWIJDEREN.

% Initialiseer q.
grootteP = size(p);
grootteP = grootteP(2);
q = zeros( (grootteP - 1), 1);

%Stop als p te klein is.

if grootteP <= 1
   disp("Graad p is te laag!"); 
   q = NaN;
   return
end

if grootteP <= 2 && not( isreal(x) )
   disp("Graad p is te laag voor een complex getal!"); 
   q = NaN;
   return
end

% Coefficienten van de hoogste graad termen van p en q zijn gelijk.

q(1) = p(1);

% Start en eindwaarde for loop elk 1 hoger voor gemak in matlab (rest niet 
% nodig).
for coefficient = 2:(grootteP - 1)

   q(coefficient) = p(coefficient) + q(coefficient - 1)*x;
    
end



% Complex toegevoegde ook wegdelen indien x complex is.
if not( isreal(x) )

    % Kopieer q om verder te kunnen werken ermee.
    
    a = q;
    
    % q nog een graad lager initialiseren.
    
    q = zeros( grootteP - 2, 1);
    
    % Coefficienten van de hoogste graad termen van p en q zijn gelijk.
    
    q(1) = a(1);
    
    % Start en eindwaarde for loop elk 1 hoger voor gemak in matlab (rest niet 
    % nodig).
    for coefficient = 2:(grootteP - 2)

      q(coefficient) = a(coefficient) + a(coefficient - 1)*x;
    
    end
    
end


end


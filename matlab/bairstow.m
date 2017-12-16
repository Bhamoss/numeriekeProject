function ws = bairstow( p, start, tol)
%bairstow Geeft 2 nulpunten van de functie p aan de hand van de startwaarde
% met een gegeven tolerantie, gevonden met de methode van bairstow.
%   
%   Signatuur: ws = bairstow( p, start, tol)
%
%   @param p
%       De veelterm die geevalueerd zal worden, voorgesteld door zijn
%       coefficienten als vector, met de hoogste graad term als eerste
%       element enzovoort. Dit is een 1 x n vector.
%
%   @param start
%       De startwaarde nodig om Bairstow aan te vatten.
%
%   @param tol
%       De tolerantie van de fout, indien niet meegegeven 10^-6.
%
%   @return ws
%       De 2 nulpunten gevonden aan de hand van de starwaarde binnen de
%       tolerantie tol.
%

% Grootte van p bepalen.

grootteP = size( p );
grootteP = grootteP(2);


% Kijken of p minstens 2de graads is.

if grootteP < 2
   
    disp("De meegegeven veelterm moet minstens van graad 2 zijn.");
    ws = NaN;
    return
    
end


% Vector initialeseren om mee te werken.

werkVector = zeros ( 1, grootteP);



end


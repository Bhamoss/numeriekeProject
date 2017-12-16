function w = newtonraphson( p, start, tol)
%newtonraphson Geeft het nulpunt van p terug die gevonden word via de
%startwaarde start met fouten tolerantie tol (standaard 10^-6), 
%via de methode van Newton-Raphson.
%
%   Signatuur: w = newtonraphson( p, start, tol)
%
%   @param p
%       De veelterm die geevalueerd zal worden, voorgesteld door zijn
%       coefficienten als vector, met de hoogste graad term als eerste
%       element enzovoort. Dit is een 1 x n vector.
%
%   @param start
%       De startwaarde nodig om Newton-Raphson aan te vatten.
%
%   @param tol
%       De tolerantie van de fout, indien niet meegegeven 10^-6.
%
%   @return w
%       Het nulpunt gevonden aan de hand van de starwaarde binnen de
%       tolerantie tol indien de fouttolerantie van de gevonden waarden
%       kleiner of gelijk is aan tol, anders NaN.
%
%
%


% p mag geen 0de graads zijn.
s = size(p);
s = s(2);
if s <= 1
    disp("Functie moet minstens graad 1 zijn!");
    w = NaN;
    return
end

%Check of tol gegeven is.

if nargin == 2
    tol = 10^(-6);
end

% Initialiseer de startwaarden.

vorigeX = start;
huidigeX = start;

% De fout benadering initialiseren zodat deze in de while geraakt.

foutAprox = tol + 1;

iterator = 0;
while foutAprox > tol && iterator < 10000
    
    vorigeX = huidigeX;
    
    % Bereken p(vorigeX).
    
    px = my_polyval( p, vorigeX, 0);
    
    % Bereken p'(vorigeX).
    
    afgpx = my_polyval( p, vorigeX, 1);
    afgpx = afgpx(2);
    
    % Bereken de huidigeX
    
    huidigeX = vorigeX - (px/afgpx);
    
    
    foutAprox = abs(huidigeX - vorigeX);
    iterator = iterator + 1;
end

% Checken of de fout benadering kleiner is dan tol.
if abs(huidigeX - vorigeX) > tol
    w = NaN;
    return
end

w = huidigeX;

end


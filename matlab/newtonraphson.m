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
%       element enzovoort.
%
%   @param start
%       De startwaarde nodig om Newton-Raphson aan te vatten.
%
%   @param tol
%       De tolerantie van de fout, indien niet meegegeven 10^-6
%
%   @return w
%       Het nulpunt gevonden aan de hand van de starwaarde binnen de
%       tolerantie tol indien de fouttolerantie van de gevonden waarden
%       kleiner of gelijk is aan tol, anders NaN.
%
%
%

%BOUW BEVEILIGING ONEIDNIGE LUS: AKA MAX AANTAL ITERATIES

end


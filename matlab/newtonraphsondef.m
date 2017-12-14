function ws = newtonraphsondef( p, start, tol)
%newtonraphsondef Geeft alle nulpunten van de veelterm p terug met fouten
%tolerantie tol (standaard 10^-6).
%
%   Signatuur: ws = newtonraphsondef( p, start, tol)
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
%   @return ws
%       de nulpunten gevonden aan de hand van de starwaarde binnen de
%       tolerantie tol indien de fouttolerantie van de gevonden waarden
%       kleiner of gelijk is aan tol, anders NaN.
%


%ZORG DAT JE ALLES VIND, DOE DIT DOOR NIEUWE STARTWAARDEN TE DOEN INGEVEN
%INDIEN NIET ALLES WERD GEVONDEN, DOE DIT ZOALS AANGEGEVEN IN DE OPGAVE

%zeg dat ze desnoods een complexe startwaarde moeten geven,
%want enkel zo kun je complexe nulpunten vinden.

end


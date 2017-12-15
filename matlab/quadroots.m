function ws = quadroots( p, tol)
%quadroots Berekent de nulpunten van de 2de graads functie met de gekende
%formules en gebruikt deze als startwaarden voor newton rhapson om het
%nulpunt naar de gewenste tolerantie te brengen.
%
%   Signatuur: ws = quadroots( p, tol)
%
%   @param p 
%       De 2de graads veelterm die geevalueerd zal worden, voorgesteld door
%       zijn coefficienten als vector, met de hoogste graad term als eerste
%       element enzovoort.
%
%   @param tol
%       De tolerantie van de fout, indien niet meegegeven 10^-6.
%
%   @return ws
%       De 2 nulpunten van de p.


if nargin == 1
    tol = 10^(-6);
end

%Er wordt niet veel rekening gehouden met conditie en stabiliteit hier
%omdat er toch nr achter volgt.
% Anders zou een kleine a en gelijke termen bij het aftrekken voor slechte
%stabiliteit zorgen.

%ALS A KLEIN IS, VERMENIGVULDIG DAN DE TELLER EN NOEMER MET 100 OFZO

xEen = ( -p(2) + sqrt(p(2)^2 - 4*p(1)*p(3)) ) / 2 * p(1) ;
xEen = newtonraphson( p, xEen, tol);

if isnan(xEen)
    xEen = ( -p(2) + sqrt(p(2)^2 - 4*p(1)*p(3)) ) / 2 * p(1) ;
end

if xEen > 1
    xTwee = p(3) / ( p(1) * xEen );
else
    xTwee = ( -p(2) - sqrt(p(2)^2 - 4*p(1)*p(3)) ) / 2 * p(1) ;
end
xTwee = newtonraphson( p, xTwee, tol);



ws = [ xEen xTwee ];

end


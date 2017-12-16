function ws = quadroots( p)
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
%
%   @return ws
%       De 2 nulpunten van de p.


%!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
% ALS JE HIER EEN PARAMETER BIJ WIL GEVEN KUN JE DE WAARDE
% VOOR STABILITEITSVERHOGER DOEN KIEZEN, GROTER VOOR KLEINE A
% EN KLEINER ALS DE VERWACHTE NULPUNTEN KLEIN ZULLEN ZIJN
%!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

% Indien a klein is, wordt de noemer en teller met 100 vermenigvuldigt voor
% een verbetering in de stabiliteit


if p(1) < 1
    
    % 128 is 2^7, die normaal goed is voor de stabiliteit, want dit is
    % de basis voor floats volgens de IEEE standaard, dus zorgt dit voor
    % zo min mogelijk nauwkeurigheidsverlies.
    
    stabiliteitsVerhoger = 128;
else
    stabiliteitsVerhoger = 1;
end

xEen = ( -p(2) + sqrt(p(2)^2 - 4*p(1)*p(3)) ) / ( 2 * p(1) * stabiliteitsVerhoger );

% Teller nu verhogen, niet ervoor want dan wordt teller groter voor er 
% gedeeld wordt, wat een slechtere stabiliteit geeft.

xEen = xEen * stabiliteitsVerhoger;


% Volgens de stabiele methode berekenen als xEen niet te dicht van 0 ligt,
% anders de gewone formule toepassen.

if xEen > 0.0000000005
    
    % Opnieuw eerst de stabiliteitsVerhoger aanpassen
    
    if xEen < 1
       stabiliteitsVerhoger = 128;
    else
       stabiliteitsVerhoger = 1;
    end
    
    xTwee = p(3) / ( p(1) * xEen * stabiliteitsVerhoger);
    xTwee = xTwee * stabiliteitsVerhoger;
    
else
    
    % stabiliteitsVerhoger heeft hier al de juiste waarde
    
    xTwee = ( -p(2) - sqrt(p(2)^2 - 4*p(1)*p(3)) ) / ( 2 * p(1) * stabiliteitsVerhoger );
    xTwee = xTwee * stabiliteitsVerhoger;
    
end



ws = [ xEen xTwee ];

end


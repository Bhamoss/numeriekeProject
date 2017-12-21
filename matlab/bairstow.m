function ws = bairstow( p, start, tol)
%bairstow Geeft 2 nulpunten van de functie p aan de hand van de startwaarde
% met een gegeven tolerantie, gevonden met de methode van bairstow.
%   
%   Signatuur: ws = bairstow( p, start, tol)
%
%   @param p
%       De veelterm die geevalueerd zal worden, voorgesteld door zijn
%       coëfficiënten als vector, met de hoogste graad term als eerste
%       element enzovoort. Dit is een 1 x n vector.
%
%   @param start
%       De 2 startwaarden nodig om Bairstow aan te vatten.
%       Dit is een 1 x 2 vector met [ a b ]
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


% Kijken of p minstens 3de graads is.

if grootteP < 3
   
    disp("De meegegeven veelterm moet minstens van graad 2 zijn.")
    ws = NaN;
    return
    
end


%Check of tol gegeven is.

if nargin == 2
    tol = 10^(-6);
end


% Werk vector initialiseren.


% Fout initialiseren.

fout = tol + 1;

iterator = 0;
mu = start(1)+ start(2);
rho = start(1)*start(2);
while fout > tol && iterator < 10000

    werkVector(1) = p(1);
    werkVector(2) =  p(2) + werkVector(1) * rho;

    % De eerste keer dubbelrijig horner ( b's berekenen)

    for graad = 3:grootteP
    
      %Dubbelrijig horner
    
       werkVector(graad) = p(graad) + werkVector(graad - 1) * rho + werkVector(graad - 2) * mu;
    
    end
    
    % Het 2 x 2 stelsel oplossen om delta p en delta u te vinden
    dbNaardrho(1) = 0;
    dbNaardrho(2) = werkVector(1);
    dbNaardmu(1) = 0;
    dbNaardmu(2) = 0;
     for graad = 3:grootteP
         dbNaardmu(graad) = dbNaardrho(graad-1);
         dbNaardrho(graad) = werkVector(graad-1) + rho*dbNaardrho(graad-1) + mu*dbNaardrho(graad-2);
     end
    D =dbNaardrho(grootteP-1)*dbNaardmu(grootteP) - dbNaardrho(grootteP)*dbNaardmu(grootteP-1);
    
    deltaRho = -1/D *(werkVector(grootteP-1)*dbNaardmu(grootteP) - werkVector(grootteP)*dbNaardmu(grootteP-1));
    deltaMu = -1/D * (werkVector(grootteP)*dbNaardrho(grootteP-1) - werkVector(grootteP-1)*dbNaardrho(grootteP));  

    fout =  max(abs(werkVector(grootteP)),abs(werkVector(grootteP-1)));
    
    if fout > tol
        rho = rho + deltaRho;
        mu = mu + deltaMu;
    end
    iterator = iterator + 1;
end

ws = quadroots( [1,-rho,-mu] );

end


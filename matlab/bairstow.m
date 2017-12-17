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
%       De 2 startwaarden nodig om Bairstow aan te vatten.
%       Dit is een 1 x 2 vector met [ p u ]
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

if grootteP < 4
   
    disp("De meegegeven veelterm moet minstens van graad 3 zijn.");
    ws = NaN;
    return
    
end


%Check of tol gegeven is.

if nargin == 2
    tol = 10^(-6);
end


% Werk vector initialiseren.

werkVector = zeros( 1, grootteP);


% Fout initialiseren.

fout = tol + 1;

iterator = 0;
while fout > tol && iterator < 10000

    % De eerste twee speciale gevallen doen
    
    werkVector(1) = p(1);
    werkVector(2) = werkVector(1) + p(2) * start(1);

    % De eerste keer dubbelrijig horner ( b's berekenen)

    for graad = 3:grootteP
    
      %Dubbelrijig horner
    
       werkVector(graad) = p(graad) + werkVector(graad - 1) * start(1) + werkVector(graad - 2) * start(2);
    
    end

    
    % b1 en b0 opslaan
    
    b1 = werkVector( grootteP - 1 );
    b0 = werkVector( grootteP );
    

    % Partiele afgeleiden berekenen.
    
    % De eerste twee speciale gevallen doen
    
    werkVector(2) = werkVector(1) + werkVector(2) * start(1);

    % De tweede keer dubbelrijig horner 

    for graad = 3:(grootteP - 1)
    
      %Dubbelrijig horner
    
       werkVector(graad) = werkVector(graad) + werkVector(graad - 1) * start(1) + werkVector(graad - 2) * start(2);
    
    end
    
    
    % Het 2 x 2 stelsel oplossen om delta p en delta u te vinden
    
    opl = linsolve( [ werkVector(grootteP - 2) , werkVector(grootteP - 3) ; werkVector(grootteP - 1) , werkVector(grootteP - 2) ], [ -b1 ; -b0 ]);
    
    pVorig = start(1);
    uVorig = start(2);
    
    start(1) = start(1) + opl(1);
    start(2) = start(2) + opl(2);
    
    pFout = abs( start(1) - pVorig );
    uFout = abs( start(2) - uVorig );
    
    if pFout > uFout
        fout = pFout;
    else 
        fout = uFout;
    end
    
    iterator = iterator + 1;
end

ws = quadroots( [1 start(1) start(2)] );

end


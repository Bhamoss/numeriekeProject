function ws = newtonraphsondef( p, start, tol)
%newtonraphsondef Geeft alle nulpunten van de veelterm p terug met fouten
%tolerantie tol (standaard 10^-6).
%
%   Signatuur: ws = newtonraphsondef( p, start, tol)
%
%   @param p
%       De veelterm die geevalueerd zal worden, voorgesteld door zijn
%       co�ffici�nten als vector, met de hoogste graad term als eerste
%       element enzovoort. Dit is een 1 x n vector.
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


% p mag geen 0de graads zijn.

grootteP = size(p);
grootteP = grootteP(2);
if grootteP <= 1
    disp("Functie moet minstens graad 1 zijn!");
    ws = NaN;
    return
end

% Check of tol gegeven is.

if nargin == 2
    tol = 10^(-6);
end

% Initialiseer ws.

ws = zeros( 1, grootteP - 1);

% Maak de arrays aan om te plotten indien geen nulpunt gevonden word.
plotGrootte = 5000;
startPlot = -500;
eindPlot = 500;
X = zeros( plotGrootte, 1);
Y = zeros( plotGrootte, 1);
stapGrootte = (abs(startPlot) + abs(eindPlot)) / plotGrootte;

% Itereer aan de hand van het aantal gevonden nulpunten.

nbGevondenNulpunten = 0;

while nbGevondenNulpunten ~= grootteP - 1

    if(size(p,2) > 2)
        huidigNulpunt = newtonraphson( p, start, tol);
    else
        huidigNulpunt = -p(2)/p(1);
    end
    if (abs(imag(huidigNulpunt)) < tol)
        huidigNulpunt = real(huidigNulpunt);
    end
    
    if ~isnan(huidigNulpunt)
        %Nulpunt gevonden binnen de tolerantie:
        %Deel nulpunt weg en voeg nulpunt toe aan ws
        
        nbGevondenNulpunten = nbGevondenNulpunten + 1 ;
        
        
        p = horner( p, huidigNulpunt);
        
        
        ws(nbGevondenNulpunten) = huidigNulpunt;
        
        %Indien het nulpunt complex is werd zijn toegevoegde ook
        %weggedeelt:
        if not(isreal(huidigNulpunt))
            nbGevondenNulpunten = nbGevondenNulpunten + 1 ;
            ws(nbGevondenNulpunten) = conj(huidigNulpunt);
        end
        
    else
        % Geen nulpunt gevonden, laad nieuwe startwaarde
        
        % Maak arrays om te plotten.
        
        xWaarde = startPlot;
        
        huidigeGrootteP = size(p);
        huidigeGrootteP = huidigeGrootteP(2);
        
        % Bereken alle koppels om te plotten.
        for i = 1:plotGrootte
            
            yWaarde = 0;
            exponent = 0;
            
            % Bereken de y waarde.
            % Begin achteraan de lijst, dus met de constante.
            for j = huidigeGrootteP:-1:1
               
                yWaarde = yWaarde + p(j) * xWaarde^(exponent);
                
                exponent = exponent + 1;
                
            end
            
            X(i) = xWaarde;
            Y(i) = yWaarde;
            
            xWaarde = xWaarde + stapGrootte;
        end
        
        % Plot de functie.
        
        plot(X,Y);
        
        % Vraag om juiste input
        
        input_hf = str2double(input('Geen nulpunt gevonden, geef nieuwe (misschien complexe) startwaarde: ','s'));
        while isnan(input_hf) || fix(input_hf) ~= input_hf
            input_hf = str2double(input('Geef een getal in: ','s'));
        end
        
        start = input_hf;
        
    end
    
    
end
end


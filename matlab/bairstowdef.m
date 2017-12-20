function ws = bairstowdef( p, start, tol)
%bairstowdef Berekent alle nulpunten van p met de methode van Bairstow.
%   
%   Signatuur: ws = bairstowdef( p, start, tol)
%
%   @param p
%       De veelterm die geevalueerd zal worden, voorgesteld door zijn
%       coefficienten als vector, met de hoogste graad term als eerste
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
%       De gevonden nulpunten.
%


% Bairstow tot graad kleiner is dan drie, dan quadroots of gewoon lineair
%ZORG DAT JE ALLES VIND, DOE DIT DOOR NIEUWE STARTWAARDEN TE DOEN INGEVEN
%INDIEN NIET ALLES WERD GEVONDEN, DOE DIT ZOALS AANGEGEVEN IN DE OPGAVE

%zeg dat ze desnoods een complexe startwaarde moeten geven,
%want enkel zo kun je complexe nulpunten vinden.


% p mag geen 0de graads zijn.

grootteP = size(p);
grootteP = grootteP(2);
if grootteP <= 3
    disp("Functie moet minstens graad 3 zijn!");
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

    if(grootteP - 1 - nbGevondenNulpunten == 1)
        huidigNulpunt = -p(2)/p(1);
    else
        huidigNulpunt = bairstow( p, start, tol);
    end
    
    huidigeGrootteNulpunt = size(huidigNulpunt);
    huidigeGrootteNulpunt = huidigeGrootteNulpunt(2);
    
    if ~isnan(huidigNulpunt(1))
        %Nulpunt gevonden binnen de tolerantie:
        %Deel nulpunt weg en voeg nulpunt toe aan ws
        
        nbGevondenNulpunten = nbGevondenNulpunten + huidigeGrootteNulpunt;
        
        if(huidigeGrootteNulpunt > 1)
            p = horner(p, huidigNulpunt(1));
            p = horner(p, huidigNulpunt(2));
            %p = doubleHorner( p, huidigNulpunt(1),huidigNulpunt(2));
            ws(nbGevondenNulpunten-1) = huidigNulpunt(2);
        end
        start = 0.9 * huidigNulpunt;
        ws(nbGevondenNulpunten) = huidigNulpunt(1);
        
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
        
        input_hf = str2double(input('Geen nulpunt gevonden, geef 2 nieuwe (misschien complexe) startwaarden: ','s'));
        while isnan(input_hf(1)) || fix(input_hf(1)) ~= input_hf(1) || isnan(input_hf(2)) || fix(input_hf(2)) ~= input_hf(2)
            input_hf = str2double(input('Geef 2 getallen in: ','s'));
        end
        
        start = input_hf(1);
    end
    
    
end

end


function convplotnr(p, x0, a, b, tol)
    % function convplot(p, x0, a, b, tol)
    %   Deze functie maakt een plot die aangeeft welke startwaarden naar
    %   welk nulpunt convergeren.
    %
    % Inputs
    %   p   : Vector met de co�ffici�nten van de veelterm
    %   x0  : Een startwaarde voor het vinden van alle nulpunten
    %   a   : Een vector met alle waardes voor het re�le deel van de
    %           startwaarde die gebruikt moeten worden
    %   b   : Een vector met alle waardes voor het imaginaire deel van de
    %           startwaarde die gebruikt moeten worden
    %   tol : Een gewenste tolerantie
    
    %Check of tol gegeven is.

    if nargin == 4
        tol = 10^(-6);
    end
    
    % Zoek alle nulpunten van de veelterm en plot deze
    styles = {'b', 'k', 'c', 'm', 'g', 'y'};
    ws = newtonraphsondef(p, x0, tol);
    if size(ws, 2) < size(p, 2)-1
        error('not all zeros found')
    end
    figure
    for j = 1:size(ws, 2)
        plot(real(ws(j)), imag(ws(j)), [styles{j} '*'], 'MarkerSize', 20, 'Linewidth', 5)
        prepleg{j} = num2str(ws(j));
        hold on
    end
    legend(prepleg{:}, 'Location', 'EastOutside')
    
    
    for k = a
        for l = b
            
            huidigNulpunt = newtonraphson( p, k + 1i*l);
            
            if isnan(huidigNulpunt)
                plot( k, l, ['r' '.'], 'MarkerSize', 20, 'Linewidth', 5)
            else
                
                kleur = 0;
                
                for j = 1:size(ws, 2)
                    
                    % Kijken of het nulpunt hetzelfde is
                    verschil = abs( ws(j) - huidigNulpunt );
                    
                    if verschil  <=  tol
                        kleur = j;
                    end
                    
                end
                
                if kleur == 0
                    error("Nulpunten komen niet overeen");
                end
                
                plot( k, l, [styles{kleur} '.'], 'MarkerSize', 20, 'Linewidth', 5)
            end
        end
    end
    axis([min(a), max(a), min(b), max(b)])
    print('nrPlot','-depsc');
end


function convplotbr(p, x0, a, b, tol)
    % function convplot(p, x0, a, b, tol)
    %   Deze functie maakt een plot die aangeeft welke startwaarden naar
    %   welk nulpunt convergeren.
    %
    % Inputs
    %   p   : Vector met de co�ffici�nten van de veelterm
    %   x0  : Een startwaarde voor het vinden van alle nulpunten Dit is
    %   een 1 x2 vector[ a b]
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
    ws = bairstowdef(p, x0, tol);
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
            
            huidigNulpunt = bairstow( p, [k + 1i*l,k - 1i*l]);
            
            if isnan(huidigNulpunt(1))
                plot( k, l, ['r' '.'], 'MarkerSize', 20, 'Linewidth', 5)
            else
                
                kleur1 = 0;
                
                for j = 1:size(ws, 2)
                    
                    % Kijken of het nulpunt hetzelfde is
                    verschil1 = abs(ws(j) - huidigNulpunt(1));
                    
                    if verschil1  <= tol
                        kleur1 = j;
                    end
                    
                end
                
                if kleur1 == 0
                    error("Nulpunten komen niet overeen" + huidigNulpunt(1));
                end
                
                plot( k, l, [styles{kleur1} '.'], 'MarkerSize', 20, 'Linewidth', 5)
                if(size(huidigNulpunt,2) > 1)
                    kleur2 = 0;
                
                    for j = 1:size(ws, 2)
                    
                        % Kijken of het nulpunt hetzelfde is
                        verschil2 =  abs(ws(j) - huidigNulpunt(2));
                    
                        if verschil2  <= tol
                            kleur2 = j;
                        end
                    
                    end
                
                    if kleur2 == 0
                        error("Nulpunten komen niet overeen" + huidigNulpunt(2));
                    end
                
                    plot( k, -l, [styles{kleur2} '.'], 'MarkerSize', 20, 'Linewidth', 5)
                end
            end
        end
    end
    axis([min(a), max(a), min(b), max(b)])
    print('brPlot','-depsc');
end


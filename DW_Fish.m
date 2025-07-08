%------------------------------------------------------------------------------------------------
%GENERACIÓN DE UNA VARIABLE ALEATORIA SEGÚN LA DISTRIBUCIÓN DIMROTH-WATSON (DW)
%USANDO EL METODO DE FISH
%-----------------------------------------------------------------------------------------------

clear all

gamma = 5; % Parámetro de concentración, puede ser cualquier valor de R
n = 25000; % Número de muestras a generar

X=[]; %Inicializamos un vector vacío donde guardaremos las muestras

if gamma > 0 % Bipolar
     C=1/(exp(gamma)-1); % Constante normalizadora

    while length(X)< n
        U1 = rand(n,1); U2 = rand(n,1);
        X0 = log(U1/C+1)/gamma;
        X1 = X0(U2 <= exp(gamma*(X0.^2-X0))); %Criterio de aceptación-rechazo
        U = rand(length(X1),1);
        X1 = X1.*((U<1/2)-(U>=1/2)); %Simetria respecto al ecuador
        X = [X; X1]; % Añadir las muestras aceptadas al conjunto X
    end

else %Girdle
     c1 = sqrt(abs(gamma)); % Constantes normalizadoras
     c2 = atan(c1);
    while length(X)< n
        U1 = rand(n,1); U2 = rand(n,1);
        X0 = tan(c2*U1)/c1;
        X1 = X0(U2 <= (1-gamma*X0.^2).*exp(gamma*X0.^2)); %Criterio de aceptación-rechazo
        U = rand(length(X1),1);
        X1 = X1.*((U<1/2)-(U>=1/2)); %Simetria respecto al ecuador
        X = [X; X1]; %  Añadir las muestras aceptadas al conjunto X
    end
end

%Corresponde al cos(polar)
X = X(1:n); % Asegurar que solo tenemos exactamente n muestras

%Construimos el vector final Y
phi = 2*pi*rand(n,1);
sx=sqrt(1-X.^2); %Corresponde al sin(polar)
Y=[cos(phi).*sx,sin(phi).*sx,X];

    % Graficar las muestras en una esfera (S_{2})
    figure;
    x=Y(:,1); y=Y(:,2); z=Y(:,3); 
    plot3(x,y,z,'bo')
    title('Distribución DF-Fish sobre la Esfera')
    hold on
    [x2,y2,z2] = sphere;
    obj= surf(x2,y2,z2);
    set(obj,'FaceAlpha',0.2)
    axis equal;
    grid on;
    hold off
    %print(gcf, 'DW-Fish16', '-dpng', '-r300')

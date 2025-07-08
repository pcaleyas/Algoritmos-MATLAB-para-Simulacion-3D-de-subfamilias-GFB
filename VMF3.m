%------------------------------------------------------------------------------------------------
%GENERACIÓN DE UNA VARIABLE ALEATORIA SEGÚN LA DISTRIBUCIÓN VON
%MISES-FISHER (vMF) EN LA ESFERA S_{2} USANDO EL METODO DE INV
%-----------------------------------------------------------------------------------------------
clear all

kappa = 3; % Parámetro de concentración, puede ser cualquier valor de R
n = 1000; % Parámetro que representa el número de muestras

   % 1. Generación de matriz nxn de variables uniformes independientes en (0,1)
    U1=rand(n,1); U2=rand(n,1);
   % 2. Calcular X = cos(Theta) usando
    X = log(2 .* U1 * sinh(kappa) + exp(-kappa)) / kappa;
   % 3. Calcular la longitud Φ (Phi) en el rango [0, 2π]
    Phi = 2 * pi .* U2;
   % 4. Calcular las coordenadas esféricas (S_{2})
    %Y_tilde = [(ones(n,1) - X.^2).^(1/2) .* cos(Phi),(ones(n,1) - X.^2).^(1/2) .* sin(Phi), X];
    Sx=(1-X.^2).^(1/2);
    Y_tilde = [Sx.* cos(Phi),Sx.* sin(Phi), X];

    % Graficar las muestras en una esfera (S_{2})
    figure;
    x=Y_tilde(:,1); y=Y_tilde(:,2); z=Y_tilde(:,3); 
    plot3(x,y,z,'bo')
    title('Distribución VMF-Inv sobre la Esfera')
    hold on
    [x2,y2,z2] = sphere;
    obj= surf(x2,y2,z2);
    set(obj,'FaceAlpha',0.2)
    axis equal;
    grid on;
    hold off
    %print(gcf, 'VMFinv16', '-dpng', '-r300')
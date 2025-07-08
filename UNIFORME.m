clear all

n = 10000; % Parámetro que representa el número de muestras, para hacer los resultados del ejemplo repetibles
rng(0,'twister')
%Genera un ángulo polar para cada punto en la esfera. 
%Estos valores están en el intervalo abierto $(-\pi/2,\pi/2)$, pero no están distribuidos uniformemente.
valores = 2*rand(n,1)-1;
polar = asin(valores);
%Genera un ángulo azimutal para cada punto en la esfera. 
%Estos valores están distribuidos uniformemente en el intervalo abierto %$(-\pi/2,\pi/2)$.
azimutal = 2*pi*rand(n,1);
%Genera un valor del radio para cada punto en la esfera. 
%Estos valores están en el intervalo abierto $(0,3)$, pero no están distribuidos uniformemente.
radio=ones(n,1);

%Convertir a coordenadas cartesianas 
    [x,y,z] = sph2cart(azimutal,polar,radio);   

% Graficar las muestras en una esfera (S_{2})
    plot3(x,y,z,'bo')
    title('Distribución Uniforme sobre la Esfera')
    hold on
    [x2,y2,z2] = sphere;
    obj= surf(x2,y2,z2);
    set(obj,'FaceAlpha',0.2)
    axis equal;
    grid on;
    hold off

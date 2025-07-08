%------------------------------------------------------------------------------------------------
%GENERACIÓN DE UNA VARIABLE ALEATORIA SEGÚN LA DISTRIBUCIÓN
%FISHER-BINGHAM4(GFB_4,beta)
%-----------------------------------------------------------------------------------------------
clear all

beta= 5;
n= 25000;

c_menos= integral(@(x)(exp(-beta*x.^2)),-1,1);
c_mas= integral(@(x)(exp(beta*x.^2)),-1,1);
c= exp(beta)*c_menos + exp(-beta)*c_mas;
p1 = exp(beta)*c_menos/c;

X=[];
while length(X)<n
    %Generamos dos uniformes
    U1 = rand(n,1); U2= rand(n,1);
    %Generamos dos variables independientes por DW con parametros beta y n
    V1 = Variable_DW_LW(beta,n);
    V2 = Variable_DW_LW(-beta,n);
    %Garantizamos su simetria
    V = (U1<p1).*V1+(1-(U1<p1)).*V2;
    %Criterio de aceptación-rechazo
    X1 = V(U2 <= besseli(0,beta*(1-V.^2))./cosh(beta*(1-V.^2)));
    X = [X;X1];
end
% Nos asegurarmos que solo tenemos exactamente n muestras
X = X(1:n);

kappa= beta*(1-X.^2);
Phi = Variable_Phi_Vmf(kappa); %Azimutal en (0,2pi)

sx = sqrt(1-X.^2);  %Corresponde al sin(polar)
% Construimos el vector final Y en la esfera (S_{2})
Y = [cos(Phi).*sx,sin(Phi).*sx,X];

% Graficar las muestras en una esfera (S_{2}) 
    x=Y(:,1); y=Y(:,2); z=Y(:,3); 
    plot3(x,y,z,'bo')
    title('Distribución GFB_{4,beta} sobre la Esfera')
    hold on
    [x2,y2,z2] = sphere;
    obj= surf(x2,y2,z2);
    set(obj,'FaceAlpha',0.2)
    axis equal;
    grid on;
    hold off

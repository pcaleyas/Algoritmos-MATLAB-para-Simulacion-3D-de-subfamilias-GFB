%------------------------------------------------------------------------------------------------
%GENERACIÓN DE UNA VARIABLE ALEATORIA SEGÚN LA DISTRIBUCIÓN
%FISHER-BIRGHAM6(GFB_6) 
%-----------------------------------------------------------------------------------------------
clear all

%Si anulamos alguno o varios de los parametros llegamos al resto de distribuciones
n=25000;
kappa=-5; 
beta=5;
gamma=-3;

%kappa debe ser positivo
signo_kappa = sign(kappa);
kappa = abs(kappa);

c_menos= integral(@(x)(exp(kappa*x+(gamma-beta)*x.^2)),-1,1);
c_mas= integral(@(x)(exp(kappa*x+(gamma+beta)*x.^2)),-1,1);
c= exp(beta)*c_menos + exp(-beta)*c_mas;
p1 = exp(beta)*c_menos/c;


X=[]; V1=[]; V2=[];
while length(X)<n
    %Generamos dos uniformes
    U1 = rand(n,1); U2= rand(n,1);
    %Generamos dos variables independientes por GFB4 con parametros kappa,gamma y n
    V1 = Variable_GFB_4(kappa,gamma-beta,n);
    V2 = Variable_GFB_4(kappa,gamma+beta,n);
    %Garantizamos su simetria
    V = (U1<p1).*V1+(1-(U1<p1)).*V2;
    %Criterio de aceptación-rechazo
    X1 = V(U2 <= besseli(0,beta*(1-V.^2))./cosh(beta*(1-V.^2)));
    X = [X;X1];
end
X = X(1:n);
kappa= beta*(1-X.^2);
Phi = Variable_Phi_Vmf(kappa);

sx = sqrt(1-X.^2); 
Y = [cos(Phi).*sx,sin(Phi).*sx,X];

% Graficar las muestras en una esfera (S_{2}) 
    figure;
    x=Y(:,1); y=Y(:,2); z=Y(:,3); 
    plot3(x,y,z,'bo')
    title('Distribución GFB_{6} sobre la Esfera')
    hold on
    [x2,y2,z2] = sphere;
    obj= surf(x2,y2,z2);
    set(obj,'FaceAlpha',0.2)
    axis equal;
    grid on;
    hold off
    %print(gcf, 'FB6_16', '-dpng', '-r300')
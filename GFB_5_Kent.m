%------------------------------------------------------------------------------------------------
%GENERACIÓN DE UNA VARIABLE ALEATORIA SEGÚN LA DISTRIBUCIÓN
%DE KENT(GFB_5,K)
%-----------------------------------------------------------------------------------------------
clear all

%Si ambos son 0 estamos ante una uniforme, con beta igual a cero a VMF y
%con kappa igual a cero a GFB_4,beta
n=25000;
kappa=5; %Los valores deben ser 2*beta<=kappa
beta=2;%Tiene que ser >= 0


%kappa debe ser positivo
signo_kappa = sign(kappa);
kappa = abs(kappa);

if 2*beta > kappa
    disp("Los valores de kappa y beta no verifica 2*beta<=kappa");
    return
end

a= 4*kappa-8*beta; b= 4*kappa+8*beta; c= b/(8*kappa);
gamma= 8*beta;
lambda1= sqrt(a+2*sqrt(gamma)); lambda2= sqrt(b); 
X1 = []; X2 = [];

while length(X1) < n
    U1 = rand(n,1);  U2 = rand(n,1); 
    R1 = exprnd(1/lambda1,n,1);  
    R2 = exprnd(1/lambda2,n,1);  
    %Criterio de aceptación-rechazo
    R1= R1(U1 <= exp(-(a*R1.^2+ lambda1*R1.^4)./(2+lambda1*R1-1)));
    R2= R2(U2 <= exp(-(b*R2.^2- gamma*R2.^4)./(2+lambda2*R2-c)));
    %Guardamos aquellos que lo verifiquen
    X1 = [X1;R1]; 
    X2 = [X2;R2]; 
    %Para la ultima condición tienen que tener el mismo numero de valores
    minimo = min(length(X1),length(X2));
    X1_min = X1(1:minimo); X2_min=X2(1:minimo);
    %Ultimo criterio de aceptación
    X1 = X1((X1_min.^2+X2_min.^2)<1);   
    X2 = X2((X1_min.^2+X2_min.^2)<1);
     
end
%Nos aseguramos que tengan exactamente n valores
X1 = X1(1:n);
X2 = X2(1:n);
%Hacemos las simetrias de las variables
U3 = rand(n,1); 
X1 = ((U3<1/2)-(U3>=1/2)).*X1;
U4 = rand(n,1); 
X2 = ((U4<1/2)-(U4>=1/2)).*X2;

X= 1-2*(X1.^2+X2.^2); %cos theta
sx = sqrt(1-X.^2); %sen theta

coseno= X1./sqrt(X1.^2+X2.^2); %cos phi
seno= X2./sqrt(X1.^2+X2.^2); %sen phi

Y= [sx.*coseno, sx.*seno, X];
Y = signo_kappa*Y;

% Graficar las muestras en una esfera (S_{2}) 
    figure;
    x=Y(:,1); y=Y(:,2); z=Y(:,3); 
    plot3(x,y,z,'bo')
    title('Distribución GFB_{5,K} sobre la Esfera')
    hold on
    [x2,y2,z2] = sphere;
    obj= surf(x2,y2,z2);
    set(obj,'FaceAlpha',0.2)
    axis equal;
    grid on;
    hold off
    print(gcf, 'FB5_16', '-dpng', '-r300')




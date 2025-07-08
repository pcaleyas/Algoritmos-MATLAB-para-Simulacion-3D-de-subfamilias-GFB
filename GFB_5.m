%------------------------------------------------------------------------------------------------
%GENERACIÓN DE UNA VARIABLE ALEATORIA SEGÚN LA DISTRIBUCIÓN
%DE KENT(GFB_5,K) 
%-----------------------------------------------------------------------------------------------
clear all

%Si ambos son 0 estamos ante una uniforme, con beta igual a cero a VMF y
%con kappa igual a cero a GFB_4,beta
n=25000;
kappa=2; 
beta=2;%Tiene que ser >= 0


%kappa debe ser positivo
signo_kappa = sign(kappa);
kappa = abs(kappa);
X1 = []; X2 = [];

if 2*beta <= kappa % Caso unimodal
    alpha1 = kappa-2*beta;
    alpha2 = kappa+2*beta;
    sigma1 = 1/(4*alpha1+ sqrt(8*beta)); %A lo mejor tengo q poner la raiz
    sigma2 = 1/(4*kappa);
    
    while length(X1) < n 
    U1 = rand(n,1);  U2 = rand(n,1); 
    Z1 = normrnd(0,sqrt(sigma1),n,1);  
    Z2 = normrnd(0,sqrt(sigma2),n,1);  
    %Criterio de aceptación-rechazo
    Z1= Z1(U1 <= exp(-(2*alpha1*Z1.^2+ 4*beta*Z1.^4)-1/2+(2*alpha1+sqrt(8*beta))*Z1.^2));
    Z2= Z2(U2 <= exp(-(2*alpha2*Z2.^2+ 4*beta*Z2.^4)+(2*alpha2-4*beta)*Z2.^2));
    %Guardamos aquellos que lo verifiquen
    X1 = [X1;Z1]; 
    X2 = [X2;Z2]; 
    %Para la ultima condición tienen que tener el mismo numero de valores
    minimo = min(length(X1),length(X2));
    X1_min = X1(1:minimo); X2_min=X2(1:minimo);
    %Ultimo criterio de aceptación
    X1 = X1((X1_min.^2+X2_min.^2)<1);   
    X2 = X2((X1_min.^2+X2_min.^2)<1);
        
    end
else % Caso bimodal
    alpha1 = kappa-2*beta;
    alpha2 = kappa+2*beta;
    eta= 1-kappa/(2*beta);
    y0= sqrt(eta/2);
    py0= (beta/2)*eta^2;
    sigma1= 1/(2*eta*beta);
    sigma2 = 1/(4*kappa);

    while length(X1) < n 
    U1 = rand(n,1);  U2 = rand(n,1); 
    Z1 = normrnd(y0,sqrt(sigma1),n,1);  
    Z2 = normrnd(py0,sqrt(sigma2),n,1);  
    %Criterio de aceptación-rechazo
    Z1= Z1(U1 <= exp(-(2*alpha1*Z1.^2+ 4*beta*Z1.^4)+ beta*eta*(Z1-y0).^2- 2*py0));
    U=rand(length(Z1),1);
    Z1= Z1.*((U<1/2)-(U>=1/2));
    Z2= Z2(U2 <= exp(-(2*alpha2*Z2.^2+ 4*beta*Z2.^4)+(2*alpha2-4*beta)*Z2.^2));
    %Guardamos aquellos que lo verifiquen
    X1 = [X1;Z1]; 
    X2 = [X2;Z2]; 
    %Para la ultima condición tienen que tener el mismo numero de valores
    minimo = min(length(X1),length(X2));
    X1_min = X1(1:minimo); X2_min=X2(1:minimo);
    %Ultimo criterio de aceptación
    X1 = X1((X1_min.^2+X2_min.^2)<1);   
    X2 = X2((X1_min.^2+X2_min.^2)<1);
        
    end
end

%Nos aseguramos que tengan exactamente n valores
X1 = X1(1:n);
X2 = X2(1:n);

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

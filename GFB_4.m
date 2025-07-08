%------------------------------------------------------------------------------------------------
%GENERACIÓN DE UNA VARIABLE ALEATORIA SEGÚN LA DISTRIBUCIÓN
%FISHER-BINGHAM4(GFB_4)
%-----------------------------------------------------------------------------------------------
clear all

%Si ambas son 0 entonces es la uniforme, si kappa=0 entonces DW y si
%gamma=0 entonces VMF.
kappa= 5;
gamma= 5; 
n=1000;
X=[];

if gamma>0

    p1= (kappa+gamma)/(2*kappa);

     while length(X) < n
        U=rand(n,1); U1=rand(n,1);
        X1 = Variable_VMF_Wood(kappa-gamma,n); 
        X2 = Variable_VMF_Wood(kappa+gamma,n); 

        X0=  X1.* (U1 <= p1)+ X2.* (1-(U1 <= p1));
        %Criterio de aceptación-rechazo
        X3= X0(U<=((1+exp(-2*gamma))*exp(gamma*(X0.^2)))./(exp(gamma*X0)+exp(-gamma*X0)));
        X=[X;X3];
     end

elseif gamma<0
    if (0  <= kappa) && (kappa <= -2*gamma)

        while length(X)< n
            Z= normrnd(-kappa/(2*gamma),sqrt(-1/(2*gamma)),n,1);
            X1= Z(Z>=-1 & Z<=1);
            X=[X;X1];
        end
    
    else
        while length(X)<n
            U=rand(n,1);
            X0= Variable_VMF_Wood(kappa+2*gamma,n);
            X1= X0(U <= exp(gamma)*exp(-2*gamma*X0+gamma*X0.^2));
            X=[X;X1];
        end
    end
end

X=X(1:n);
Phi= 2*pi*rand(n,1);
sx = sqrt(1-X.^2); 
Y = [cos(Phi).*sx,sin(Phi).*sx,X];

% Graficar las muestras en una esfera (S_{2}) 
    figure;
    x=Y(:,1); y=Y(:,2); z=Y(:,3); 
    plot3(x,y,z,'bo')
    title('Distribución GFB_4 sobre la Esfera')
    hold on
    [x2,y2,z2] = sphere;
    obj= surf(x2,y2,z2);
    set(obj,'FaceAlpha',0.2)
    axis equal;
    grid on;
    hold off

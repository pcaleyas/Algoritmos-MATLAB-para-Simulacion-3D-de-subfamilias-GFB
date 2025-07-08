function Y= Variable_DW_LW(gamma,n)


X=[]; %Inicializamos un vector vacío donde guardaremos las muestras
phi=[];

if gamma >0  % Bipolar
    rho = (4*gamma) / (2*gamma + 3 + sqrt((2*gamma + 3)^2 - 16*gamma));
    r = (3*rho/(2*gamma))^3 * exp(-3 + 2*gamma/rho);
    while length(X)< n
        U1=rand(n,1); U2=rand(n,1);
        S0= U1.^2./(1-rho*(1-U1.^2)); 
        V=r*U2.^2./((1-rho*S0).^3);

        S1= S0(V<=exp(2.*S0*gamma));%Criterio de aceptación-rechazo
        theta= acos(sqrt(S1));
        U3=rand(length(S1),1);
        X1= cos(pi-theta);
        X1 = X1.*((U3<1/2)-(U3>=1/2)); %Simetria respecto al ecuador
        phi0 = 4*pi.*U3.*(U3<1/2)+2*pi.*(2.*U3-1);
        X = [X; X1]; % Añadir las muestras aceptadas al conjunto X
        phi=[phi; phi0]; 
    end
    phi=phi(1:n);

else %Girdle
     b=exp(2*gamma)-1;
        while length(X) < n
        U1= rand(n,1); U2= rand(n,1);
        V=log(1+U1*b)/gamma;
        xi=2*pi*U2;
        c=cos(xi);
        S1=V.*c.^2;      S2=V-S1;

        Aux=logical((S1<=1).*(S2<=1)); %Criterio de aceptación-rechazo
        S1=S1(Aux);      S2=S2(Aux);
        X1=sqrt(V).*c;   X2=sin(xi);
        X3=[X1(Aux);X2(Aux)];
        X=[X;X3(:)]; % Añadir las muestras aceptadas al conjunto X
        end
    phi=2*pi*rand(n,1);

end
%Corresponde al cos(polar)
% Asegurar que solo tenemos exactamente n muestras
X = X(1:n);

%Construimos el vector final Y
sx=sqrt(1-X.^2); %Corresponde al sin(polar)
Y=[cos(phi).*sx,sin(phi).*sx,X];

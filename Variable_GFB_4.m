function Y = Variable_GFB_4(kappa,gamma,n)

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


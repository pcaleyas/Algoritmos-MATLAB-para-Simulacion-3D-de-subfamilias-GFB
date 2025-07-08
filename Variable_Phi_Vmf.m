function Phi= Variable_Phi_Vmf(kappa)

d = 2; % Parametro que establece la dimension
n = length(kappa); % Deberia ser el tamaño de beta(1-X^2)
X=[];%Inicializamos un vector vacío donde guardaremos las muestras

% Calculamos los siguientes constantes
b = (-2*kappa + (4*(kappa.^2) + (d-1)^2).^(1/2)) / (d-1);
x0 = (1 - b) ./ (1 + b);
c = kappa .* x0 + (d-1) * log(1 - (x0).^2);

while length(X)<n
    % Generamos B de Beta(α, β) con α = (d-1)/2 y β = (d-1)/2 inicial 
    B = betarnd((d-1)/2, (d-1)/2, n,1);
    % Calcular X inicial
    X0 = (1 - (1 + b) .* B)./ (1 -(1 - b) .* B);
    % Generrmos una variable uniforme(0,1)
    U0 = rand(n,1);
    % Vemos que se verifica el criterio de aceptación
    X1= X0(kappa .* X0 + (d-1) * log(1 - x0 .* X0) - c >= log(U0)); 
    % Añadir las muestras aceptadas al conjunto X
    X = [X; X1]; 
end
X = X(1:n);

U = randi(4,n,1);
phi1 = acos(X)/2; % Se trata de una función de X=cos(2phi)
%Se aplica la siguiente trasnformacion para extender al soporte [0,2pi] 
% y garantizar simetria
Phi = ((U==1)+(U==3)).*phi1 + ((U==2)+(U==3))*pi - ((U==2)+(U==4)).*phi1 + (U==4)*2*pi; 

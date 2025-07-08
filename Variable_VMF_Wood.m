function Y = Variable_VMF_Wood(kappa,n)

d = 3; % Parametro que establece la dimension
X=[];%Inicializamos un vector vacío donde guardaremos las muestras

% Calculamos los siguientes constantes
b = (-2*kappa + sqrt(4*kappa^2 + (d-1)^2)) / (d-1);
x0 = (1 - b) / (1 + b);
c = kappa * x0 + (d-1) * log(1 - x0^2);

while length(X)<n
    % Generamos B de Beta(α, β) con α = (d-1)/2 y β = (d-1)/2 inicial 
    B = betarnd((d-1)/2, (d-1)/2, n,1);
    % Calcular X inicial
    X0 = (1 - (1 + b) .* B)./ (1 -(1 - b) .* B);
    % Generrmos una variable uniforme(0,1)
    U = rand(n,1);
    % Vemos que se verifica el criterio de aceptación
    X1= X0(kappa * X0 + (d-1) * log(1 - x0 * X0) - c >= log(U)); 
    % Añadir las muestras aceptadas al conjunto X
    X = [X; X1]; 
end
    %Corresponde al cos(polar)
    X = X(1:n); % Asegurar que solo tenemos exactamente n muestras

    phi = 2*pi*rand(n,1); %azimutal en (0,2pi)

    %Corresponde al sin(polar)
    SE=(1 - X.^2).^(1/2);
   % Construimos el vector final Y en la esfera (S_{2})
    Y = [SE.* cos(phi),SE.* sin(phi), X];

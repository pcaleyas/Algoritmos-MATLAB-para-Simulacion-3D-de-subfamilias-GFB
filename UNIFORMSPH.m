clear all
n=1;
m=100; % n�mero de valores aleatorios de la muestra uniforme
A=0; % extremo inferior del intervalo de la uniforme
B= pi; % extremo superior del intervalo de la uniforme
theta=unifrnd(A,B,m,n); %generaci�n de una rejilla de 100 nodos en intervalo [0,\pi] de n�meros pseudoaleatorios independientes uniformes
plot(theta)
%%%%%%%%%%%DOCUMENTAR%%%%%%%%%%%%%%%%%%
q=1;
C=0; % extremo inferior del intervalo de la uniforme
D=2*pi; % extremo superior del intervalo de la uniforme
p=100; % n�mero de valores aleatorios de la muestra uniforme
varphi=unifrnd(C,D,p,q); %generaci�n de una rejilla de 100 nodos en intervalo [0,2\pi] de n�meros pseudoaleatorios independientes uniformes
plot(varphi)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%GENERACI�N DE VALORES ALEATORIOS UNIFORMEMENTE DISTRIBUIDOS EN LA ESFERA
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
VS=[sin(theta).*cos(varphi),sin(theta).*sin(varphi), cos(theta)]';
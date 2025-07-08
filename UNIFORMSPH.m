clear all
n=1;
m=100; % número de valores aleatorios de la muestra uniforme
A=0; % extremo inferior del intervalo de la uniforme
B= pi; % extremo superior del intervalo de la uniforme
theta=unifrnd(A,B,m,n); %generación de una rejilla de 100 nodos en intervalo [0,\pi] de números pseudoaleatorios independientes uniformes
plot(theta)
%%%%%%%%%%%DOCUMENTAR%%%%%%%%%%%%%%%%%%
q=1;
C=0; % extremo inferior del intervalo de la uniforme
D=2*pi; % extremo superior del intervalo de la uniforme
p=100; % número de valores aleatorios de la muestra uniforme
varphi=unifrnd(C,D,p,q); %generación de una rejilla de 100 nodos en intervalo [0,2\pi] de números pseudoaleatorios independientes uniformes
plot(varphi)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%GENERACIÓN DE VALORES ALEATORIOS UNIFORMEMENTE DISTRIBUIDOS EN LA ESFERA
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
VS=[sin(theta).*cos(varphi),sin(theta).*sin(varphi), cos(theta)]';
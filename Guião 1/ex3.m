%% Ex3
% Usando a função stem, faça o gráfico dos vectores x e y obtidos
% anteriormente

clear; clc;

% precisa dos valores dos exercicios anteriores
run ex1.m;
run ex2.m;

% stem( vector das abcissas, vector das coordenadas )
fig = stem(x, y)

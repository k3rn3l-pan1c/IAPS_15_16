%% Ex5
% TAG: Quantizar, arredondar gráficos, ondas quadradas
% Faça o gráfico do sinal retangular (onda quadrada de periodo 1 e
% amplitude 1)

clear; clc;

% gerar 1000 elementos entre os intervalos no eixo das abcissas
t = linspace(-1.5, 1.5, 1000);

% usar a função sign para quantizar a função sin com argumento multiplo de 2pi. 
% Para x = -1.5, -1, 0.5, 0, 0.5, 1, 1.5 a função tem ordenada nula
% sign(x)
% se x > 0, -> x = 1
% se x = 0, -> x = 0
% se x < 0, -> x = -1
x = sign( sin(2.*pi.*1.*t));    

plot(t, x)


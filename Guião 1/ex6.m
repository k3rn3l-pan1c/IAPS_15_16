%% Ex6
% Faça o gráfico da função sin(pi*x)/(pi*x), para x pertencente a [-5, 5].
% Determine os zeros desta função

clear; clc;

% gerar o array das abcissas e definir a função como inline
xx = linspace(-5, 5, 1000);
f = inline('sin(pi.*x)./(pi.*x)', 'x')      % sinc(x)

% gerar a reta y = 0
yy = zeros(1, 1000);

plot(xx, f(xx), xx, yy)

% Os zeros ocorrem em +-k, onde k é um inteiro no intervalo [-5, 5], como
% seria de esperar pela definção da função sinc



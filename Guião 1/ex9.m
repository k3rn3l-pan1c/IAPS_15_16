%% Exercicio 9
% Faça o gráfico do sinal f(t) = SUM[k = 1, M]( (2*(-1)^(k+1)/(pi*k))*sin(2pi*k*y)
% para M = 2, 4, 10, 50, 1000, com t pertencente a [0, 3], Use pelo menos
% 1000 pontos para contruir o vetor t. Comente os resultados, indicando
% qual o sinal lhe parece ser f(t) quando M -> + INF

clear; clc;

% Variáveis do problema
N = 1000;
t = linspace(0, 3, N);
M = [ 2 4 10 50 100 ];

figure(1);

for m = 1 : 5            % para cada valor de M
    y = zeros(1, N);     % criar um vetor para armazenar os dados
    
    % calcular o valor da função (efetuar o somatório)
    for k = 1 : M(m)
        y = y + 2*(-1)^(k+1)/(pi*k) * sin(2*pi*k*t);
    end;
    
    % dar plot ao resultado
    subplot(1, 5, m);
    plot(t, y);
end;

% P: Comente os resultados, indicando qual o sinal lhe parece ser f(t) quando M -> + INF
% R: Quando M tende para infinito, a função toma a forma de um sinal dente
% de serra

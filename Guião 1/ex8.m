%% Exercicio 8 
% Faça o gráfico do sinal: f(t) = SUM[k = 1, M]( 4/(pi*(2k -1))*sin(2pi*(2k-1)*t)
% para M = 2, 4, 10, 50, 100, com t pertencente a [0, 3]
% Use pelo menos 1000 pontos para construir o vetor t. Comente, comparando
% os resultados obtidos com o sinal apresentado no ponto 5

% Nota: estamos a usar calculo vetorial em desprezo de calculo simbólico
% TAG: soma de sinusoides
clear; clc;

% Variáveis do porblema
N = 1000;               
t = linspace(0, 3, N);
M = [ 2 4 10 50 100];  

figure(1);              % criar uma figura

for m = 1 : 5           % para cada valor de M
    y = zeros(1, N);    % criar um vetor para alojar os dados
    
    % calcular o valor da função (efetuar o somatório)
    for k = 1 : M(m)    
        y = y + 4/(pi*(2*k-1))*sin(2*pi*(2*k-1)*t);    
    end;
    
    % dar plor à função
    subplot(1, 6, m); 
    plot(t, y)
end;

%para comparar com o exercicio 5
subplot(1, 6, 6)
run ex5.m

% P: Comente, comparando os resultados obtidos com o sinal apresentado no ponto 5
% R: A função aproxima-se do sinal da onda quadrada à medida que o valor de M
% aumenta, ou seja, à medida que se se somam mais dados


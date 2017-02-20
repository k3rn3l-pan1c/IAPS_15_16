%% Ex2
% Gere um vector y com uma sequência aleatória de 100 valores uniformente
% distribuídos no inertvalo [-2pi, 2pi]

% -> Inicialmente gera-se 100 numeros aleatorios no intervalo [0, 1], usando
% rand(numero de linhas, numero de colunas). O intervalo fica [0, 1]
% -> De seguida faz a transposição para a amplitude do intervalo pretendido, 
% ao multiplicar por 4*pi. O intervalo fica [0, 4pi]
% -> o proximo passo é centrar o intervalo no valor pretendido, subtraindo
% 2pi. O intervalo fica [-2pi, 2pi].

clear; clc;

y = rand(1, 100) * 4 * pi - 2 * pi 

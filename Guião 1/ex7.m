%% Ex7 
% Usando a função subplot, faça o gráfico simultaneo dos sinais
% (4/(pi*(2K -1))*sin(2pi*(2k-1)*t) para k = 1, 2, 3 e t pertencente a 
% [0, 3]. Assim como o gráfico resultante da soma destes 3 sinais.
% Se continuasse a adicionar mais sinais deste tipo, o que acha que iria obter?

% Nota: a abordagem vai passar por trabalhar com os dados vetorialmente invés de usar inline e sym
% USAGE: subplot(l,c,p) -> numero de (l)inhas, (c)olunas e indice do (p)lot

clear; clc;

% Definir as variáveis
k = 1:3;
t = linspace(0, 3, 1000);

% vetor para guardar a sobreposição dos sinais
s = zeros(1, length(t));   

figure(1);          % criar uma figura

for k = 1 : 3       % para cada valor de k
    % calcular o resultado da função
    x = 4 / (pi*(2*k-1)) * sin(2*pi*(2*k-1)*t);
    
    % selecionar o subplot e efetuar o plot nesse subplot
    subplot(1,4,k)  
    plot(t, x)    
    
    s = s + x;      % somar as contribuiçoes de cada um dos sinais
end;
    
    % resultado da sobreposição
    subplot(1, 4, 4) 
    plot(t, s)

% P: Se se continuasse a adicionar sinais?
% R: obteria-se um função quadrada

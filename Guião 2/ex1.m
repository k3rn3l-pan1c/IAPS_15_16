%% Exercicio 1
% Gere, em MATLAB, um sinal de tempo discreto sinusoidal com 100 amostras,
% frequência 5 Hz, duração igual a meio segundo e gama de variação entre
% -2 e 1

clear; clc;

f0 = 5;       % frequencia do sinal
N = 100;      % numero de amostras
T = 0.5;      % duração do sinal
T0 = 1/f0;    % periodo do sinal

n = linspace(0, T, N);     % 100 amostras

% Definir o sinal
y = 1.5 * sin(2*pi*f0*n) - 0.5;   

subplot(2, 1, 1);      
plot(n, y)

subplot(2,1,2);         
stem(n, y)

%% Alinea A
% P: Quantos períodos estão representados nesse segmento de sinal?
% R: O numero de periodos é dado por duração sinal/tempo de cada periodo
numT = T/T0


%% Alinea B
% P: Qual é o período de amostragem?
% R: O período de amostragem é dado por periodo do sinal / numero de
% amostras do sinal
Ta = T0/N

% P: Qual é a frequência de amostragem usada? 
% R: A frequencia de amostragem é dada por: 1/Periodo de amostragem
fa = 1/Ta       

%% Alinea C
% P: Qual é o valor médio do sinal? Calcule também o valor teórico da energia
% do sinal em estudo e compare-o com o valor obtido diretamente através da
% sua representação discreta.
% R: USAGE: mean(x), onde x é um vetor de dados
v_medio = mean(y)


%% Alinea D
% A energia de um sinal x(t) é dada por int(abs(x(t)).^2). Calcule o valor
% teórico da energia do sinal em estudo e compare-o com o valo obtido
% diretamente através da sua representação discreta

% definir o sinal usando simbólicos
syms t
x = (1.5.*sin(2.*pi.*f0.*t) - 0.5)^2; % nao e necessario usar o abs -> a expressao e real

% Energia do sinal
Energia_Sinal = int(x, t , 0, T0)    


%Duvidas 
%Alinea C -> perguntar prof se é suposto da !=
%Alinea D -> é suposto usarmos a função int para calcular os integrais?

% Ey = sum(abs(y).^2) 









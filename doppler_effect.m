%% Efeito de Doppler
% Determinar a velocidade do carro obtendo a variação na frequencia

clear; clc;
Fa = 8000;

x = wavread('Sons/doppler1.wav');       % sinal para processar

N = length(x);                          % numero de amostras do sinal
n = 0 : N - 1;                       

% plot do sinal
figure(1);
plot(n, x)
title('Sinal Original: Doppler1.wav')


CONST = 10;                            % numero de porções do sinal pretendidas
idx = N/CONST;                         % indice do 2º bloco do sinal

% Porção do sinal antes de passar pelo obstáculo
x1 = x(2 * idx : 4*idx );              % porção do sinal
N1 = length(x1);                       % numero de elementos
n1 = 0 : N1 - 1;

figure(2)                               
plot(n1 , x1)

% Porção do sinal depois de atravessar o obstáculo
x2 = x(end - 4*idx: end - 2*idx);      % porção do sinal
N2 = length(x2);                       % numero de elementos
n2 = 0 : N2 - 1;                        

figure(3)
plot(n2, x2)


% DFT da primeira porção do sinal
X1 = fft(x1);

figure(4)
stem(n1, abs(X1))
[y , idx1]  = max(X1(1:end/2))

f1 = N1/Fa * idx1

% DFT da segunda porção do sinal
X2 = fft(x2);

figure(5)
stem(n2, abs(X2))
[y, idx2] = max(X2(1:end/2))

f2 = N2/Fa * idx2

% Calcular a velocidade
v_m = - 346 * (f2 - f1) / f2
V_Km = v_m * 3600 / 1000


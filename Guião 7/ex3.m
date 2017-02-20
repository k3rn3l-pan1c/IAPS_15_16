%% Exercicio 3

clear; clc;
x = load('../Sinais txt/mistura1.txt');

Fa = 22050;                 % frequencia de amostragem
Ta = 1/Fa;                  % periodo de amostragem
Fmax_ecg = 500;             % frequencia máxima do sinal ecg
Tmax_exg = 1/Fmax_ecg;      % frequencia máxima do sinal ecg
Fmax_audio = 3000;          % frequencia máxima do sinal de audio
Fp = 4000;                  % Frequencia da onda portadora

N = length(x);              % Numero de amostras do sinal
n = 0 : N - 1;              % Indices arbitrarios
f = n * Fa/N;               % Indices em frequencias

% Obter so o aúdio -> Filtro passa Alto

% Filtro passa alto
% fir1(N, Wn) onde N é a ordem do filtro e Wn é a frequencia de corte. 
% Quanto maior o N, mais vertical é a tansição do filtro, ou seja, maior a
% taxa de rejeição. Wn está no intervalo [0, 1], onde 1 representa a metade
% da frequencia de amostragem (ou seja, a frequencia máxima)
h1 = fir1(50, Fmax_ecg/(Fa/2), 'High');

% sem argumentos o freqz dá plot a dois graficos:
% modulo em DB
% fase em graus
figure(1)
freqz(h1, 1, 1024, Fa)

% filtra o vector x usando o sistema h1
x1 = filter(h1, 1, x);

% Desmodulação do sinal, para obter o sinal na banda base
t = n * Ta;
x2 = x1 .* cos(2.*pi.*Fp*t');

% Obter só o audio na banda base -> Filtro passa baixo
% Filtro Passa Baixo
h2 = fir1(50, Fmax_audio/(Fa/2), 'Low');

figure(2)
freqz(h2, 1, 1024, Fa);

y = filter(h2, 1, x2);

sound(y, Fa)




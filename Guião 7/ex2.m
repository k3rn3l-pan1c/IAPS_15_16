%% Exercício 2

clear; clc;
x = load('../Sinais txt/mistura1.txt');

Fa = 22050;                 % frequencia de amostragem
Ta = 1/Fa;                  % periodo de amostragem
Fmax_ecg = 500;             % frequencia máxima do sinal ecg
Fmax_audio = 3000;          % frequencia máxima do sinal de audio
Fp = 4000;                  % Frequencia da onda portadora

N = length(x);              % Numero de amostras do sinal
n = 0 : N - 1;              % Indices arbitrarios
f = n * Fa/N;               % Indices em frequencias

X = fft(x);                 % DFT of signal

angles = angle(X);          % fase da dft em radianos

figure(1);
stem(f, angles)             % mostrar as fase em função da frequencia

% para o valor de frequencia igual à frequencia da portadora, obter o
% indice no vetor das fases
fase_idx = find(f == Fp);    
fase_rad = angles(fase_idx);        % obter a fase em radianos
fase_degree = fase_rad * 180 / pi   % converter para graus







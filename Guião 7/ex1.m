%% Exercício 1

clear; clc;
x = load('../Sinais txt/mistura1.txt');

Fa = 22050;                 % frequencia de amostragem
Ta = 1/Fa;                  % periodo de amostragem
Fmax_ecg = 500;             % frequencia máxima do sinal ecg
Tmax_exg = 1/Fmax_ecg;      % frequencia máxima do sinal ecg
Fmax_audio = 3000;          % frequencia máxima do sinal de audio
Fp = 4000;                  % Frequencia da onda portadora

N = length(x);              % Numero de amostras do sinal
n = 0 : N - 1;

figure(1)                   % Sinal original
plot(n, x)

X = fft(x);                 % DFT do sinal original
f = n * Fa/N;               % indices da frequencia

figure(2)                   % plot da DFT do sinal completo
stem(f, abs(X))

% Indice até onde existem componentes em frequencia do ECG
k = Fmax_ecg * N / Fa;      

% Eliminar as componentes que não pertencem ao ECG
X( k + 1 : end - (k-1) ) = 0;

% DFT do ECG
figure(3)
stem(f, abs(X))

% Reverter para o dominio do tempo
ecg = ifft(X);              % transformada inversa
N_ecg = length(ecg);        % Numero de elementos no ecg
n_ecg = 0 : N_ecg - 1;      % indices

%% Obter o batimento cardiaco
t = n * Ta;                 % indices no tempo

figure(4)
plot(t, ecg)                
[xx, yy] = ginput(5);       % obter 5 pontos

n_bat = (mean(diff(xx)))/2; % numero de batimentos por segundo
n_bat = n_bat * 60          % numero de batimentos por minuto       


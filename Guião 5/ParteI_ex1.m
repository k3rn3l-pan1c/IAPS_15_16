%% Parte I - Exercício 1
% Gere um sinal digital resultante de uma mistura aditiva de duas
% sinusoides de frequencias 15 Hz e 40 Hz, respetivamente, com 1000
% amostras e duração igual a 2 segundos. Usando a série de Fourier discreta
% (FFT), confirme as frequencias associadas às duas sinusoides

clear; clc;

fa = 500;           % frequencia de amostragem
Ta = 1/fa;          % tempo de amostragem
N = 1000;           % numero de amostras

n = 0:N-1;          % indices das amostras [0, 1, ..., N - 1]

% Sinal -> cos(2*pi*f*t), onde t = nTa, correspondendo à amostragem
x = cos(2.*pi.*15.*n.*Ta) + cos(2.*pi.*40.*n.*Ta);     

% Aplicar a transformada de Fourier discreta ao sinal
X = fft(x);         % fft de x

% Converter os indices das amostras para o dominio das frequencias. Deste
% modo as abcissas passam a ser valores de frequencia, com a resolução
% minima entre eles de fa/N

f = (0:N-1)/N.*fa;     % vetor de frequencias

% Gráfico
figure(1);
stem(f, abs(X));   


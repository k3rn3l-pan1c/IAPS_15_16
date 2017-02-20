%% Parte I - ex2
% Calcule a série de Fourier discreta do sinal "ecg1" e faça o gráfico do
% seu módulo.

clear; clc;

x = load('../Sinais txt/ecg1.txt');    % Carregar o sinal

X = fft(x);             % aplicar a transformada de Fourier Discreta ao sinal

Fa = 250;               % frequencia de amostragem
N = length(x);          % Numero de amostras do sinal
n = 0:N - 1;            % indice das amostras [0 N - 1]

% vetor de frequencias. Obtem-se multiplicando o indice das amostras pela
% frequencia de amostragem e dividindo pelo numero de amostras. Obtém se
% assim um intervalo [0, Fa - Fa/N]
f = n.*Fa./N;  

stem(f, abs(X))

% A frequencia de amostragem e 250. Logo, existem 250 amostras por segundo
% A frequencia do sinal pode ser obtida por

%% Alinea a
% Com base neste gráfico, tente descobrir qual é a "periodicidade" do sinal,
% isto é, qual é o período do batimento cardíaco

% A frequencia fundamental do sinal, pode ser determinada verificando o
% espaçamento entre as riscas com elevada amplitude. A segunda dessas
% riscas (lembrar que a 1ª risca é a componente DC ou média do sinal) é a
% frequencia fundamental

% Obter o módulo da DFT para os valores de k menores que N/2 ou de f < fa/2
halfX = abs(X(1:(end/2)));

% Obter um vetor com os indices dos valores das frequencias com um valor em
% modulo elevado (permite excluir o ruido). 
bigX = find(halfX > 5);      % Usar 5 com valor para diferenciar o ruido do sinal periodico

% calcular a media das diferenças progressivas, de modo a obter o
% espaçamento medio entre os harmonicos (relembrar que estamos a trabalhar
% no espaço dos k)
k0 = mean(diff(bigX));

f0 = Fa/N*k0      % Converter o valor dos indices da DFT (k) para frequencia

T0 = 1/f0         % Periodo fundamental do sinal (periodo do batimento cardiaco

%% Alinea b

% A largura de banda pode ser obtida subtraindo a frequencia minima do
% sinal à frequencia maxima do sinal

% Obter uma copia mais susceptivel a ruido... já nao queremos so eliminar
% as frequencias que tem modulo superior a 5, mas sim mais sensivel. Modulo
% inferior a 1 parece ser um valor reduzido para pertencer ao sinal sem ser
% ruido
X1 = find(halfX > 1);

% Multiplicando a resolução em frequencia com os indices no espaço k
% (relembrar que o harmonico fundamental é a 2 risca)
fmin = Fa/N * X1(2)
fmax = Fa/N * X1(end)

% A largura de banda é
BW = fmax - fmin

%% Alinea c

% A frequencia de amostragem minima tem de ser duas vezes superior à
% frequencia máxima presente no sinal. Se considerarmos que as frequencias
% cujo valor do modulo é inferior a 1
Fa_min = fmax * 2

% Podemos assim usar uma frequencia de amsotragem inferior aos fa = 250 Hz


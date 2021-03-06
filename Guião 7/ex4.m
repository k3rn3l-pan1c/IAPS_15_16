%% Exercicio 4

clear; clc;
x = load('../Sinais txt/mistura1.txt');

Fa = 22050;                 % frequencia de amostragem
Ta = 1/Fa;                  % periodo de amostragem
Fmax_ecg = 500;             % frequencia máxima do sinal ecg
Tmax_ecg = 1/Fmax_ecg;      % frequencia máxima do sinal ecg
Fmax_audio = 3000;          % frequencia máxima do sinal de audio
Fp = 4000;                  % Frequencia da onda portadora

N = length(x);              % Numero de amostras do sinal
n = 0 : N - 1;              % Indices arbitrarios
f = n * Fa/N;               % Indices em frequencias
t = n * Ta;                 % Indices em tempo

fase = [-pi/6, 0 , pi/6, pi/4];  % fases da cosseno na desmodulação

% Obter so o aúdio -> Filtro passa Alto
% De seguida desmodular
% fir1(N, Wn) onde N é a ordem do filtro e Wn é a frequencia de corte. 
% Quanto maior o N, mais vertical é a tansição do filtro, ou seja, maior a
% taxa de rejeição. Wn está no intervalo [0, 1], onde 1 representa a metade
% da frequencia de amostragem (ou seja, a frequencia máxima)

% sem argumentos o freqz dá plot a dois graficos:
% modulo em DB
% fase em graus

% Filtro passa alto
h1 = fir1(50, Fmax_ecg/(Fa/2), 'High');

figure(1)
freqz(h1, 1, 1024, Fa)

% Filtro Passa Baixo
h2 = fir1(50, Fmax_audio/(Fa/2), 'Low');

figure(2)
freqz(h2, 1, 1024, Fa);


% filtra o vector x usando o sistema h1
x1 = filter(h1, 1, x);

for k = 1 : length(fase)
    % Desmodulação do sinal, para obter o sinal na banda base
    x2 = x1 .* cos(2.*pi.*Fp*t' + fase(k));

    % Obter só o audio na banda base -> Filtro passa baixo
    % Aplicar o filtro descrito pelo sistema h2
    y = filter(h2, 1, x2);
    
    % plot dos espectros de áudio
    figure(k + 2);
    plot(t, y);
    title(['Fase = ' num2str(fase(k)*180/pi)])     % mostrar a fase em graus
    
    % uniformizar os eixos, para se visualizar melhor as alterações na
    % amplitude do sinal na banda base 
    axis([0 t(end) -0.6 0.6])                      
end;

% P: Observe o espectro do sinal desmodulado para os vários valores de teta
% e comente os resulatdos obtidos
% R: Quando mais proxima da fase usada na modulação for a fase usada na
% desmodulação, maior a amplitude

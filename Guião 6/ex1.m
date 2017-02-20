%% Exercício 1
% Uma das formas utilizadas pelas redes telefónicas para a transmissão de
% sinalização (por exemplo, o número do telefone a chamar) baseia-se em
% códigos multi-frequência (DTMF). Neste sistema de codificação, os números
% são enviados à central usando pares de frequências, de acordo com a
% seguinte tabela:
%
%                 Hz  | 1209 | 1336 | 1477 | 1633 
%                ---------------------------------
%                 697 |   1      2      3      A
%                 770 |   4      5      6      B
%                 852 |   7      8      9      C
%                 941 |   *      0      #      D
% 
% Por exemplo, o dígito "5" é representado através da soma de duas
% sinusóides, uma com frequência 770 Hz e outra com frequência 1336 Hz
%

clear; clc;
%% Alinea a
% Gere um sinal que codifique a sequência "0471", sendo a duração de cada
% dígito igual a 100 ms e a separação entre dígitos igual a 50 ms. A
% frequência de amostragem deve ser igual a 8 KHz, a variação pico a pico
% do sinal deve ser igual a 2 e a sua média deve ser zero.

Fa = 8000;      % frequencia de amostragem
Ta = 1/Fa;      % período de amostragem

% Duração de cada dígito e do silencio
dur_digito = 100 * 10^-3;
dur_silencio = 50 * 10^-3;

% Amplitude do sinal
A = 2;

% Sequencia
seq = '0471';
% seq = '915725360';

DTMF.F1 = [ 697, 697, 697, 697, 770, 770, 770, 770, 852, 852, 852, 852, 941, 941, 941, 941 ];
DTMF.F2 = [ 1209, 1209, 1209, 1209, 1336, 1336, 1336, 1336, 1477, 1477, 1477, 1477, 1633, 1633, 1633, 1633 ];
DTMF.SYM = [ '1'; '2'; '3'; 'A'; '4'; '5'; '6'; 'B'; '7'; '8'; '9'; 'C'; '*'; '0'; '#'; 'D' ];

% A duração do sinal é dada por N*Ta, logo N = duração / Ta
Nsinal = dur_digito / Ta;

% Indices 
nsinal = 0:Nsinal - 1;

% Comprimento do vetor com a sequencia do numero telefónico
Nseq = length(seq);

% O numero de amostras do silencio é dado por N = duração_silencio / Ta
Nsil = dur_silencio / Ta;

f = zeros(Nseq, 2);             % vetor para armazenar as DMFT dos numeros
x = zeros(length(seq), Nsinal); % vetor para armazenar os sinais
sil = zeros(1, Nsil);           % vetor de zeros (silencio)
y = [];                         % vetor vazio para armazenar o sinal de saida

for k = 1 : Nseq        % para cada dígito a discar
    
    % obter o indice na estrutura que corresponde as duas frequencias na
    % DMFT do dígito a discar
    index = find(DTMF.SYM == seq(k));
    
    % Armazenar as frequencias que compoem um digito
    f(k, 1) = DTMF.F1(index);
    f(k, 2) = DTMF.F2(index);
    
    % Gerar o sinal com a informação de cada dígito
    x(k,:) = A.*cos(2.*pi.*f(k, 1).*nsinal.*Ta) + A.*cos(2.*pi.*f(k, 2).*nsinal.*Ta);
    
    % Concatenar o dígito com o silencio de forma a gerar o sinal anterior
    y = [y x(k, :) sil];

end;

sound(y)    % reproduzir o sinal

%% Alinea b

% Gerar o ruido uniformemente distribuido no intervalo [-0.5, 0.5]
r = rand(1, length(y)) - 0.5;       

y_r = y + r;            % sinal afetado de ruido

sound(y_r)              % reproduzir o som

Ey = sum(abs(y).^2)     % energia do sinal original
Er = sum(abs(r).^2)     % energia do ruido

SNR = 10.* log10(Ey/Er) % SNR

%% Alinea c
%

% A resoluçao minima corresponde à diferença minima de frequencias que é
% preciso distinguir. Assim:

resF = abs(697 - 770)       % Resolução minima em frequencia necessaria

NFFT = Fa / resF            % Numero de amostras necessarias para a resolução em frequencias

% Indexar os sinais
I = [ 1 1201 2401 3601 ]

% usando a resolução minima em frequencia, obter os vetor de indices
f_new = (0:NFFT - 1) * Fa/NFFT;     

figure(1);

for k = 1 : length(I)                       % Por cada digito inserido
    Y = fft( y(I(k) : I(k) + NFFT - 1) );   % Calcular a fft da porção do sinal
    
    % plot
    figure(1);
    subplot(4, 1, k)
    plot(f_new, abs(Y));        
    
    % stem
    figure(2);
    subplot(4, 1, k)
    stem(f_new, abs(Y));
end;

% Na pratica, devido ao sinal estar afetado de ruido, não devemos usar a
% frequencia minima, mas sim uma frequencia superior










%% Exercício 2
% Gere, em MATLAB, cinco ciclos de um sinal de tempo discreto sinusoidal,
% x(n), de 50 Hz e com fase igual a pi/3. Considere que a frequência de
% amostragem é fa = 1 kHz

clear; clc;

f0 = 50;        % Frequencia do sinal analogico
fase = pi/3;    % Fase inicial do sinal
fa = 1*10^3;    % Frequencia de amostragem
N = 5;          % Numero de ciclos
T0 = 1/f0;      % Periodo do sinal analogico
Ta = 1/fa;      % Periodo de amostragem

n = 0:Ta:N*T0;  % Vetor com os pontos para a amostragem 


y = sin(2*pi*f0*n - fase);              % plot do sinal amostrado
stem(n, y)

%% Alinea A
% Quantize o sinal de forma a que cada amostra possa ser representada em 4
% bits. Sugestão: use a função round do MATLAB para efetuar essa operação,
% não se esquecendo que o sinal resultante deve ser o mais "parecido"
% possível com o original

b = 4;                                  % numero de bits;
delta = 2/2^b                           % intervalos de quantização 

% Quantização: Dividir o valor do sinal por delta para obter um sinal onde
% o arredondamento produza 2^b níveis de quantização. Após o
% arredondamento, multiplicar por delta para restaurar a magnitude do sinal
% original
q = round(y/delta)*delta;               % quantização

% Como só podem existir 2^b -1  níveis de arrendondamento, é necessário
% eliminar um nível. A quantização é feita  com um numero par de bits. 
% Para o numero de niveis de quantização ser igual para > 0 e < 0, 
% considerando um nivel = 0, precisava-se de um numero impar de bits. Como
% pretendemos manter o nível 0, descartamos o nível 1 (em conformidade com
% os uso dos computadores porque usam complemento para 2
% Criamos um vetor de indices booleanos, que têm valor 1 quando q == 1 e
% valor zero nos outros casos. Usando esse vetor para indexar o vetor
% quantizado, descemos os pontos no nível de quantização 1 para o nível de
% quantização inferior (1 -delta)
q(q == 1) = 1 - delta;                  

% plots para o sinal amostrado e quantizado
% Em cima -> amostrado. Em baixo -> quantizado
% o plot faz a interpolação polinomial de grau 1
% Só amostrado
figure(1);
subplot(2, 2, 1);                       
stem(n, y);                             
subplot(2, 2, 2);                       
plot(n, y);            

% Amostrado e Quantizado
subplot(2, 2, 3);
stem(n, q);
subplot(2, 2, 4);
plot(n, q);


% Usando a função quantiaps
q = quantiaps(y, b); 

% plots para o sinal amostrado e quantizado
% Em cima -> amostrado. Em baixo -> quantizado
% o plot faz a interpolação polinomial de grau 1
% Só amostrado
figure(1);
subplot(2, 2, 1);                       
stem(n, y);                             
subplot(2, 2, 2);                       
plot(n, y);            

% Amostrado e Quantizado
subplot(2, 2, 3);
stem(n, q);
subplot(2, 2, 4);
plot(n, q);

%% Alinea b
% Calcule a energia do sinal de erro (ou ruído), isto é, do sinal que é
% obtido subtraindo o sinal quantizado do sinal original
r = y - q;                  % Sinal de ruído: Sinal Amostrado - Sinal Quantizado
E_r = sum(abs(r).^2)        % energia ruido
figure(3);
plot(n, r)

%% Alinea c
% Sabendo que a relação sinal ruído (SNR - Signal to Noise Ratio) é dada
% por SNR = 10*log10(Es/Er) (dB) em que Es e Er são, respetivamente, a
% energia do sinal e do ruído, calcule a SNR do sinal quantizado

E_y = sum(abs(y).^2)        % energia sinal original

SNR = 10*log10(E_y/E_r)

%% Alinea D
% Repita as alíneas (b)-(d), para 6, 8 e 10 bits. Com os valores obtidos,
% trace um gráfico da SNR em função do número de bist. Comente os
% resultados.

% Varíáveis do Problema
bi = [ 4 6 8 10 ];             % numero de bits pretendidos

v_SNR = zeros(1, length(bi));               % reset ao valores dos SNR
vq = zeros(length(bi), length(n));          % linhas -> 1 por cada bit ;  colunas -> uma por cada amostra

for k = 1 : length(bi)                      % para cada valor de bits
    
    vdelta = (max(y) - min(y))/2^bi(k);     % calcular o espaçamento entre as linhas de decisão para cada numero de bits
   
    % Quantização: Dividir o valor do sinal por delta para obter um sinal onde
    % o arredondamento produza 2^b níveis de quantização. Após o
    % arredondamento, multiplicar por delta para restaurar a magnitude do sinal
    % original
    vq(k,:) = round(y/vdelta)*vdelta;             

    % Como só podem existir 2^b -1 níveis de arrendondamento, é necessário
    % eliminar um nível. A quantização é feita  com um numero par de bits. 
    % Para o numero de niveis de quantização ser igual para > 0 e < 0, 
    % considerando um nivel = 0, precisava-se de um numero impar de bits. Como
    % pretendemos manter o nível 0, descartamos o nível 1 (em conformidade com
    % os uso dos computadores porque usam complemento para 2
    % Criamos um vetor de indices booleanos, que têm valor 1 quando q == 1 e
    % valor zero nos outros casos. Usando esse vetor para indexar o vetor
    % quantizado, descemos os pontos no nível de quantização 1 para o nível de
    % quantização inferior (1 - delta)
    vr = y - vq(k,:);   
    
    E_vr = sum(abs(vr).^2);                 % energia do ruído
    v_SNR(k) = 10*log10(E_y/E_vr);          % SNR para cada numero de bits
    
    subplot(length(bi) + 1, 1, k);          % dar plot ao ruido
    plot(n, vr)
end;

subplot(k, 1, k);                           % dar plot aos vários SNR
plot(bi, v_SNR)

% Comente os resultados: 
% Á medida que o numero de bits aumenta, a energia do ruído diminui e o SNR
% aumenta

%% Alinea E
% Sobreponha ao gráfico anterior a relação SNR ~ 6.02b que se obtem para
% sinais uniformemente distribuídos, onde b é o número de bits usado para
% representar o sinal. Faça um histograma dos valores de x(n) e comente o
% resultado

% impedir a destruição do plot anterior, de modo a acrescentar mais dados
hold on;                        

xx = linspace(0, 10, 1000);     % gerar xx e yy
yy = 6.02 .* xx;

plot(xx, yy);                   % plot 
% permitir a destruição do gráfico pelo proximo plot (voltar ao estado normal)
hold off;                      

figure(4);                      % criar um novo figure handler, para impedir a destruição da anterior

% Para cada valor de bits. criar um histograma para cada sinal quantizado
% usando esse numero de bits na quantização
for k = 1 : length(bi)         
    subplot(length(bi), 1, k);
    hist(vq(k,:), 10);
end;

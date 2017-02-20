%% EXERCICIO 1
% Obtenha, no moodle, o ficheiro "ecg1.txt". Este ficheiro contém um
% segmento de sinal de electrocardiograma (ECG), obtido através de
% amostragem do sinal analógico (fa = 250 Hz). Para carregar este ficheiro
% para o MATLAB, execute "load ecg1.txt", sendo então criado um vetor com o
% nome "ecg1.txt" contendo os dados.

clc; clear;

load ecg1.txt               % load signal
Fa = 250;                   % Frequencia de amostragem 
Ta = 1/Fa;                  % Periodo de amostragem

N = length(ecg1);           % Comprimento do vetor
t = (0 : N -1) * Ta;        % array de valores para a amostragem espaçados Ta

%% Alinea a 
% Calcule a duração do sinal, em segundos, e a frequencia aproximada do
% batimento cardíaco, em pulsações por minuto

% mostrar o sinal
figure(1); plot(t, ecg1);   

% ginput(n) -> permitir obter n pontos no grafico ao clicar com o ponteiro
[x, y] = ginput(5)

% Usando os 5 pontos, calcular a media das diferenças consecutivas dos
% valores obtidos
% USAGE: diff(x) -> Calcula as diferenças consecutivas entre o valor do 
% indice atual e o próximo ([x(2) - x(1), x(3) - x(2), ...]
Tc = mean(diff(x))         

Fc = 1/Tc                   % Frequencia cardiaca

Nbat = 60*Fc                % Numero de batimentos por minuto

%% Alinea b
% Usando a função "conv" do MATLAB, processe o sinal ECG com o sistema h1
% h1 = { 0.5, n = 0,1
%      { 0,   caso contrário
% Visualize o sinal resultante e compare-o com o original. Comente o
% resultado

h1 = [0.5 0.5];             % sistema
                            
y1 = conv(h1, ecg1);        % convulsão entre h1 e ecg1 

% plot do sinal original do ecg1 e o sinal processado com o filtro h1
figure(2);                  
plot(t, ecg1, 'r', t, y1(1:length(t)),'b')  

% P: Comente o resultado
% R: O sinal foi passado po um filtro passa baixo  (filtro média de 2), que 
% corta as oscilações abruptas no sinal (elevadas frequencias)

%% Alinea c
% Processe agora o mesmo sinal com o sistema h2
% h2 = { 0.25, n = 0, 1, 2, 3
%      { 0,    caso contrário
% Visualize o sinal resultante, compare-o com o sinal original, com o sinal
% obtido na alinea anterior e comente o resultado

h2 = [0.25 0.25 0.25 0.25]; % sistema
                           
y2 = conv(h2, ecg1);        % convulsao entre h2 e ecg1

% plot do sinal original do ecg1 e o sinal processado com o filtro h2
figure(3);
plot(t, ecg1, 'r', t, y1(1:length(t)), 'b', t, y2(1:length(t)), 'g')

% P: Comente o resultado
% R: O sinal foi passado por um filtro passa baixo (filtro média de 4), que 
% corta as oscilações abruptas no sinal (elevadas frequencias). Como o
% filtro é mais sensível (possui 4 elementos em vez de 2) a filtragem é
% mais eficaz em h2 do que h1

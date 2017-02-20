%% Exercicio 2
% Obtenha agora o ficheiro "ecgDrift.txt". Este ficheiro contém também um
% segmento de sinal de ECG, o qual foi afetado por uma flutuação de nível
% zero

clc; clear;

load('ecgDrift.txt');       % obter o sinal ecgdrift.txt
Fa = 250;                   % usar uma frequencia de amostragem de 250 Hz
Ta = 1/Fa;                  % periodo de amostragem

N = length(ecgDrift);       % numero de amostras
t = (0 : N - 1) * Ta;       % gerar o vetor de tempo discreto espaçado por Ta

%% Alinea a
% Processe esse sinal com o sistema h3
%      {  0.5, n = 0
% h3 = { -0.5, n = 1
%      {  0,   caso contrário
% Visualize o sinal resultante e compare-o com o sinal original. Consegue
% imaginar alguma utilização para o sistema em causa?

h3 = [ 0.5 -0.5];         % Resposta impulsional

y1 = conv(h3, ecgDrift);  % h3(n)*ecgDrift(n)

% verificar que foi corrigido o drift presente no ecg
plot(t, ecgDrift, 'r', t, y1(1:length(t)), 'b');   

% P: Consegue imaginar alguma utilização para o sistema em causa?
% R: O sistema original é um filtro passa-alto. O sistema corta todas as
% contribuições DC ( f = 0 ) para o sinal, que são responsáveis pelo drift
% e atenua de forma significativa todas as frequencias baixas. Uma
% utilização deste sistema é para cortar as componentes DC de sinais e
% eliminar drifts

%% Alinea b
% Produza algumas variações na resposta impulsional do sistema, e tente
% interpretar o resultado que obtem quando o utiliza para processar o sinal
% do ECG

% Varias respostas impulsionais
h4 = [0.25 0.25 -0.25 -0.25];
h5 = [0.125 0.125 0.125 0.125 -0.125 -0.125 -0.125 -0.125];
h6 = [0.0625 0.0625 0.0625 0.06225 0.0625 0.0625 0.0625 0.0625 -0.0625 -0.0625 -0.0625 -0.0625 -0.0625 -0.0625 -0.0625 -0.0625];
h7 = [-0.25 -0.25 0.25 0.25];
h8 = [-0.125 -0.125 -0.125 -0.125 -0.125 -0.125 -0.125 -0.125];

% Calcular a convulução
y4 = conv(ecgDrift, h4);
y5 = conv(ecgDrift, h5);
y6 = conv(ecgDrift, h6);
y7 = conv(ecgDrift, h7);
y8 = conv(ecgDrift, h8);

plot(t, ecgDrift, 'r', t, y4(1:length(t)), 'b', t, y5(1:length(t)), 'y', t, y6(1:length(t)), 'g',  t, y7(1:length(t)), 'k', t, y8(1:length(t)), 'c');
legend('ecg', 'h4', 'h5', 'h6','h7', 'h8');

% Quanto maior o número de amostras seguindo o esquema de um passa alto
% (h4, h5, h6), melhor é a correção do drift. Se invertermos o sinal no 
% filtro, o sistema continua a efetuar um passa alto, mas inverte o sinal
% (h7). No h8, um filtro passa baixo invertido inverte o sinal e corta as
% altas frequencias


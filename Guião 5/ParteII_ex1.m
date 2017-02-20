%% Parte II
% A partir do moddle, obtenha o ficheiro "ecgNoise.txt". Este ficheiro
% contém um segmento de electrocardiograma (ECG) obtido através da
% amostragem do sinal analógico (fa = 250 Hz ), o qual foi afetado por um
% ruído sinusoidal aditivo. O ficheiro sem ruído encontra-se no ficheiro
% "ecg1.txt"

clear; clc;

Fa = 250;       % frequencia de amostragem

% carregar o sinal original, sem ruído
x = load('../Sinais txt/ecg1.txt');       

% carregar o sinal com influência do ruido aditivo
xr = load('../Sinais txt/ecgNoise.txt');   

N = length(x);  % numero de amostras
n = 0:N - 1;

% Graficamente
figure(1);
plot(n, x, n, xr);
legend('ECG', 'ECG com ruido');

%% Exercício 1
% Calcule a série de Fourier discreta do sinal "ecgNoise" e faça o gráfico
% do seu módulo com a função stem

X = fft(x);             % fft do sinal original
XR = fft(xr);           % fft do sinal com ruido

% vetor de frequencias. Obtem-se multiplicando o indice das amostras pela
% frequencia de amostragem e dividindo pelo numero de amostras. Obtém se
% assim um intervalo [0, Fa - Fa/N]
f = n.*Fa./N;      
                        
% Visualizar o módulo da fft
% Se a fft for para apresentar com o eixo em frequencia, usar f = n.*Fa./N;    
% Se for para apresentar com o eixo em indices do vetor, usar n+1
figure(2);              
stem(f, abs(XR))

%% Alinea A
% P: Observe a primeira risca do gráfico. Qual é o seu significado?
% R: A primeira risca do gráfico é o número de pontos multiplidos pela
% média do sinal. Corresponde ao valor médio do sinal
N * mean(xr)

%% Alinea B
% Coloque a zero essa risca da série de Fourier discreta, reconstrua o
% sinal usando a série de Fourier inversa, e observe de novo o sinal.
% Comente o resultado

% Eliminar sinais à frequência 0 (DC)
XR_novo = XR;
XR_novo(1) = 0;

% Reconstruir o sinal usando a série de fourier inversa
xr_novo = ifft(XR_novo);

% Média dos valores -> ~0, indica que estão igualmente espaçados em torno
% de zero
mean(xr_novo)

% Graficamente
figure(3);
plot(n, xr, n, xr_novo)
legend('ECG com ruído original', 'ECG com ruído com drift corrigido');

% P: Comente o resultado
% R: Ao eliminar os sinais à frequencia de 0 Hz, efetua-se a correção do
% drift, pois o sinal deixa de ser afetado por uma componente puramente DC,
% estando agora centrado na origem.

%% Alinea C
% Olhando para o gráfico do módulo da série de Fourier discreta do sinal
% "ecgNoise" é capaz de dizer quantas são as componentes sinusoidais
% responsáveis pela distorção deste sinal (Se achar necessário, observe
% também o sinal sem ruído, isto é, "ecg1.txt")

% Transformada de Fourier discreta ao sinal sem ruído
X = fft(x);

% Graficamente
figure(4);
subplot(1, 2, 1)
stem(f, abs(XR))
subplot(1, 2, 2)
stem(f, abs(X))

% R: Relembrando que o gráfico é simétrico para k = N/2 = 500, detetamos
% que existem três frequencias

%% Alínea D
% Determine as frequencias associadas as estas sinusoides

% Subtraindo as duas séries obtemos as frequencias que não estão
figure(5);
stem(f, abs(XR) - abs(X))

% Usando o data cursor, obtemos os valores das abcissas
% 15, 15.5, 16
freq = [ 15 15.5 16 ];
%% Alinea E
% P: Proponha um método para atenuar a distorção e aplique-o ao sinal
% R: O método proposto tem de eliminar os ruídos. Para isto basta eliminar
% as frequencias indesejadas da série de Fourier discreta e fazer a
% passagem para a série de Fourier no domínio temporal

XR_corrigido = XR;

% Sabemos que a relação entre o indice na série de Fourier discreta e a 
% frequencia é dado por f = Fa / N * k. É necessário somar 1 porque os
% indices começam em 1 e não 0
k = freq * N / Fa;

% É necessário ter em conta as frequencias refletidas, por isso
k = [k+1 1000-k+1]

% Para corrigir o sinal, basta eliminar estas frequencias e as suas
% refletidas
XR_corrigido(k) = 0;

% Aplicando a transformada de Fourier Inversa
xr_corrigido = ifft(XR_corrigido);

% Graficamente
figure(6);
plot(n, x, n, xr_corrigido)
legend('ECG', 'ECG filtrado')


%% Alinea f
% Calcule a relação sinal ruido (SNR) associada ao sinal distorcido e ao
% sinal filtrado

% A energia do sinal é dada por: Ex = sum(abs(x).^2)
% Considerando o sinal como o ecg1
Ex = sum(abs(x).^2)

% A energia do ruído é dada por: Er = sum(abs(x - q).^2)

% Considerando o sinal de ruído o ecgNoise original
Er1 = sum(abs(x - xr).^2)

% O SNR = 10 log10(Ex/Er)
SNR1 = 10* log10(Ex/Er1)

% Considerando o sinal de ruído o ecgNoise filtrado
Er2 = sum(abs(x - xr_corrigido).^2)

SNR2 = 10* log10(Ex/Er2)





















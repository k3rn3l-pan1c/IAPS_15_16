%% Trabalho 8 - Filtros Digitais e Medição da Distorção Harmónica
% Pedro Miguel Simões Bastos Martins
% 76374

%% Trabalho Preliminar
clear; clc;
close all;

%% Ex 1 - Alinea A
% Função de transferência dos sistema
% H(z) = 1./ (1 - a*z.^-1);         

a = [ 0.5 0.9 1 1.5 -1 -0.9 -0.5 ];         % valores do polos

% vetor que simula um impulso de Dirac (1 elemento a 1, 100 elementos a
% zero)
x = [ 1 zeros(1, 100) ];                    

B = [1 0];              % polinomio dos zeros da função de transferência

for k = 1 : length(a)
    A = [1 -a(k)];      % polinomio dos polos
    
    figure(2*k - 1);    % usando a função impz
    impz(B, A);         
    title(['H(z) = 1/ (1 - (' num2str(a(k)) ')*z^-1)']) 
    
    figure(2*k)         % mapa de polos e zeros    
    zplane(B, A);
    title(['Diagrama de polos e zeros. Polo =  ' num2str(a(k))]);
    
    % Alternativa: usando a função freqz e filter
    % Nao permite observar tão bem os resultados pretendidos...
    % y = filter(B, A, x);
    % freqz(B, A); 
end;

% P: Relacione o que observa com a posição do pólo de H(z) no plano z e
% conclua quanto à estabilidade dos sistemas
% R: Verificamos que se |a| < 1, o sistema é estável pois a sua a amplitude
% decresce à medida que se aumenta o numero de amostras. Se |a| = 1, a
% amplitude mantem-se constante ao longo do tempo, portanto o sistema nao é
% estável. Se |a| > 1, a amplitude aumenta à medida que aumentam o numero
% de amostras, logo o sistema é instável. Se a > 0, a amplitude mantem o
% sinal. Se a < 0, a amplitude muda o sinal oscilando entre amplitudes
% positivas e negativas. A relação entre os resultados observados entre a
% função impz e zplane estão de acordo com os resultados esperados
% teoricamente, pois um sistema só é estável quando os seus polos possuem
% valor em módulo menor que 1.

%% Ex2
clear; clc;
close all;

% Função de transferencia
% H(z) = (1-bZ^-1)(1-b*^-1)/((1-az^-1)(1-a*z^-1))

ecgNoise = load('../Sinais txt/ecgNoise.txt');     % Obter o sinal ecgNoise
ecg = load('../Sinais txt/ecg1.txt');              % Obter o sinal ecg sem ruido

N = length(ecgNoise);      % numero de amostras do ecg
n = 0:N - 1;               % indices das amostras


% No diagrama de zeros e polos, o zero tem amplitude 1 e o polo tem
% amplitude inferior a 1. A fase dos polos é igual à fase dos zeros e são
% ambos numeros complexos conjugados
% Definimos a as amplitudes como
r_z = 1;        % amplitude dos zeros
r_p = 0.9;      % amplitude dos polos

% e a fase como
fase =  pi/8;

% Analiticamente obtemos os polinomios dos polos e dos zeros
B = [ 1 -2*r_z*cos(fase) r_z^2 ];       % Zeros
A = [ 1 -2*r_p*cos(fase) r_p^2 ];       % Polos

% Diagrama de polos e zeros
figure(1)
zplane(B, A);
title('Diagrama de polos e zeros');

% Resposta em frequencia do sistema (módulo e fase)
figure(2)
freqz(B, A, 50);
title('Resposta em frequencia do sistema (módulo e fase)');

% Aplicando o filtro constituido pela resposta H(z) = A(z)/B(z)
ecgClean = filter(B, A, ecgNoise);

% Plot dos três sinais: Ecg filtrado, ecg com ruido e ecg sem ruido
figure(3)
plot(n, ecgClean, n, ecgNoise, n, ecg)

title('Sinais Ecg');
legend('ecgClean', 'ecgNoise', 'ecg');
xlabel('Numero de amostras');
ylabel('Amplitude');

%% Trabalho Experimental
clear; clc;
close all;

%% Exercício 1
f0 = 1000;          % frequencia central dos filtros
BW = 200;           % largura de banda dos filtros
Fa = 44100;         % frequencia de amostragem


% Gama de frequencias normalizada
Wn = [f0 - BW/2 f0 + BW/2]/(Fa/2);

% Filtro Passa banda, de ordem 2*4 = 8 (maior ordem possivel sem o filtro
% se tornar instavel para frequencias proximas de 0 e 1.
[FPB_B, FPB_A] = butter(4, Wn, 'bandpass');

figure(1)
freqz(FPB_B, FPB_A, Fa)
title('Filtro Passabanda [900 1100] Hz');

% Filtro rejeita banda de ordem 2*2 = 4 (ordem necessária para que a
% atenuação do harmonico fundamental(f0) seja pelo menos de 60 dB
[FRB_B, FRB_A] = butter(2, Wn, 'stop');

figure(2)
freqz(FRB_B, FRB_A, Fa)
title('Filtro Rejeitabanda [900 1100] Hz');

%% Exercício 2
[y_dist_50, Fa] = audioread('y_dist_50.wav');       % Sinal com 50% de distorção

N_y = length(y_dist_50);                % numero de amostras do sinal
nn_y = 0:N_y - 1;                       % indices

Y_DIST_50 = fft(y_dist_50);             % DFT do sinal com 50% de distorção

figure(3)                               % plot da dft do sinal com 50% de distorção
stem(nn_y.*Fa./N_y, abs(Y_DIST_50))
title('DFT do sinal y dist 50 com 50% de distorção');

% Filtrar o sinal com o sistema passa banda
y_FPB = filter(FPB_B, FPB_A, y_dist_50);

Y_FPB = fft(y_FPB);                     % DFT do sinal filtrado com passa banda

figure(4)                               % gráfico da DFT do passa banda
stem(nn_y.*Fa./N_y, abs(Y_FPB))
title('DFT do sinal y dist 50 filtrado pelo filtro passa banda [900 1100] Hz');

% filtrar o sinal com o sistema rejeita banda
y_FRB = filter(FRB_B, FRB_A, y_dist_50);

Y_FRB = fft(y_FRB);                     % DFT do sinal filtrado com rejeita banda

figure(5)                               % gráfico da DFT do rejeita banda
stem(nn_y.*Fa./N_y, abs(Y_FRB)) 
title('DFT do sinal y dist 50 filtrado pelo filtro rejeita banda [900 1100] Hz');


y_FRB_rms = rms(y_FRB);         % valor RMS do sinal com as frequencias de distorção
y_FPB_rms = rms(y_FPB);         % valor RMS do sinal com frequencia f0

THD = y_FRB_rms/y_FPB_rms * 100;    % Distorção harmónica
disp(['Distorcao harmonica do sinal y dist 50: ' num2str(THD) ' %']);

%% Usando a função mede distorção

% A distorçao do sinal y_dist_50 corresponde aproximadamente ao esperado,
% 50%
thd_y = mededistorcao(y_dist_50, 1000, 44100, 200);
disp(['Distorcao harmonica do sinal y dist 50 usando a funcao mededistorçao: ' num2str(thd_y) ' %']);

%% Exercicio 3
% Não vao ser adquiridas amostras usando o kit amplificador, pois o unico
% dia que tinha disponivel para obter as amostras (8 Junho) decorria o
% Students@DETI & Teachers@DETI, nao estando o kit disponivel

%% Exercicio 3e)

% Obter os ficheiros de teste
[teste1, Fa1] = audioread('teste1_ref.wav');
[teste2, Fa2] = audioread('teste2_ref.wav');

% Medir a distorçao em cada um dos ficheiros
thd_teste1 = mededistorcao(teste1, 1000, Fa1, 200);
thd_teste2 = mededistorcao(teste2, 1000, Fa2, 200);

disp(['A distorçao no ficheiro teste1 e: ' num2str(thd_teste1) ' %']);
disp(['A distorçao no ficheiro teste2 e: ' num2str(thd_teste2) ' %']);

%% Exercicio 4

% Os filtros nao apresentarem uma atenuaçao infinita na banda de rejeiçao
% significa que o filtro passa banda deixa passar outras frequencias para
% alem de f0 e que o filtro rejeita banda atenua outras frequencias sem
% serem f0 e nao atenua f0 com atenuaçao infinita. Se os filtros tivessem
% uma atenuação infinita na banda de rejeição, seria possível medir
% qualquer valor de distorção, por mais pequeno que fosse. No caso real da
% atenução na banda de rejeição nao ser infinita, o valor minimo de
% distorçao que e possivel medir e dado pelo atenuaçao que o filtro efetua
% no harmonico fundamental (f0), pois o valor rms deste filtro vai conter
% outras componentes do harmónico fundamental e o valor rms do filtro passa
% banda vai conter componentes de distorção

%% Exercicio 5

% Obter os indices com conteudo espectral relevantes -> são todos
% aproximadamente multiplos de kf0
k = find(abs(Y_FRB) > 500);             

figure(6)                              
stem(nn_y, abs(Y_FRB))              % dft do sinal filtrado com rejeita banda

hold on
stem(k, abs(Y_DIST_50(k)), 'x');    % plot dos valores dos indices
hold off

title('FFT do sinal filtrado por um filtro rejeita banda');
legend('DFT do sinal filtrado com rejeita banda', 'Valores dos indices multiplos do harmonico fundamental');
xlabel('Indices das amostras');
ylabel('|Y DIST 50(f)|');

% obter o valor correpondente aos indices no dominio do tempo (normalizados)
yy = ifft(Y_DIST_50(k)./N_y);       

% calculo do valor da distorção do sinal usando apenas os harmonicos e não
% o ruído
thd_harmonicos = abs(sum(yy))*length(yy)/sqrt(length(yy))/y_FPB_rms * 100;
disp(['Distorcao harmonica do sinal y dist 50 considerando so os harmonicos: ' num2str(thd_harmonicos) ]);



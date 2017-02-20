%% Função que calcula a distorção harmónica de um sinal
% Pedro Miguel Simões Bastos Martins
% 76374

function thd = mededistorcao(y, f0, Fa, BW)
% y  -> sinal de entrada
% f0 -> frequencia central dos filtros
% Fa -> frequencia de amostragem
% BW -> largura de banda dos filtros

% thd -> percentagem de distorção no sinal y

% Gama de frequencias normalizada
Wn = [f0 - BW/2 f0 + BW/2]/(Fa/2);

% Filtro Passa banda, de ordem 2*4 = 8 (maior ordem possivel sem o filtro
% se tornar instavel para frequencias proximas de 0 e 1.
[FPB_B, FPB_A] = butter(4, Wn, 'bandpass');

% Filtro rejeita banda de ordem 2*2 = 4 (ordem necessária para que a
% atenuação do harmonico fundamental(f0) seja pelo menos de 60 dB
[FRB_B, FRB_A] = butter(2, Wn, 'stop');

% Filtrar o sinal com o sistema passa banda
y_FPB = filter(FPB_B, FPB_A, y);

% filtrar o sinal com o sistema rejeita banda
y_FRB = filter(FRB_B, FRB_A, y);

y_FRB_rms = rms(y_FRB);        % valor RMS do sinal com as frequencias de distorção
y_FPB_rms = rms(y_FPB);        % valor RMS do sinal com frequencia f0

thd = y_FRB_rms/y_FPB_rms * 100; % Distorção harmónica em percentagem



%% relações que possa eventualmente precisar

omega = 2*pi*(f/fa);    % frequencia angular  do sinal amostrado

x = A*sen(omega*n);     % sinal

Ta = dur/N;             % periodo de amostragem

fa = N*f;               % frequencia de amostragem

n= 0:N-1;               % indices do sinal

dur = N/fa;             % duração do sinal

nT = dur/T;             % numero de periodos

f = fa/N * k;           % Frequencia de um indice da fft

delta_f = fa/N;         % Resolução em frequencia



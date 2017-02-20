%% Exercicio 7
% Utilizando o conceito de resposta impulsional equivalente resultante da
% associação em série de sistemas (convolução das respostas implusionais),
% teste, por exemplo, o resultado da associação em série de sistemas
% (convolução das respsostas impulsionais) e paralelo (adição das respostas
% impulsionais), teste, por exemplo o resultado da associação em série de
% um filtro passa.baixo com um filtro passa alto

clear; clc;

omega = linspace(0, pi, 1000);    % vetor de frequencias

% Filtro passa baixo e respetiva resposta em frequencia
h1 = [0.5 0.5]; 
H1 = H_FIR(h1, omega);

% Filtro passa alto e respetiva resposta em frequencia
h2 = [0.5 -0.5];          
H2 = H_FIR(h2, omega);

%% Usando a convuloção
serie = conv(h1, h2);      % convulução das respostas impulsionais
paralelo = h1 + h2;        % soma das respostas impulsionais

% obter as respostas em frequencia para cada filtro
SERIE = H_FIR(serie, omega);
PARALELO = H_FIR(paralelo, omega);

% graficamente
figure(1);
plot(omega, H1, omega, H2, omega, SERIE, omega, PARALELO)
legend('h1 - Passa Baixo', 'h2 - Passa Alto', 'Associação em série - Passa Banda', 'Associação em paralelo - Passa Tudo');


%% Usando a resposta em frequencia
% A resposta em frequencia de dois sistemas em série corresponde à
% multiplicação da resposta me frequencia de cada um em separado
Hserie = (H1.*H2);

% A resposta em frequencia de dois sistemas em paralelo corresponde à soma
% das repostas em frequencia de cada um em separado
Hparalelo = (H1 + H2);

% Graficamente
figure(2);
plot(omega, H1, omega, H2, omega, Hserie, omega, Hparalelo);
legend('h1 - Passa Baixo', 'h2 - Passa Alto', 'Associação em série - Passa Banda', 'Associação em paralelo - Passa Tudo');

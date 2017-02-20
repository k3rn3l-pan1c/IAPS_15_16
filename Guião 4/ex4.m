%% Exercicio 4
% Determine, analiticamente, a resposta em frequencia dos sistemas h1 e h3,
% isto é, das funções H1(exp(j*omega)) e H3(exp(j*omega))

clear; clc;

h1 = [0.5 0.5];
h3 = [0.5 -0.5];

% Resposta em frequencia do sistema h1
% H1 = exp(-j.*omega./2).* cos(omega./2);   

% Resposta em frequencia do sistema h3
% H3 = j.*exp(-j.*omega./2) .* sin(omega./2);    

%% Alinea a
% Usando o MATLAB, visualize o módulo (abs) e a fase (angle) dessas
% funções, usando 256 pontos no intervalo omega pertencente a [0, 2*pi].
% Interprete o resultado e relacione-o com o que obteve nas questões 1 e 2

% gerar 256 pontos igualmente espaçados no intervalo [0,2pi]
omega = linspace(0, 2*pi, 256);         

% Resposta em frequencia do sistema h1
H1 = exp(-j.*omega./2).* cos(omega./2);   

% Resposta em frequencia do sistema h3
H3 = j.*exp(-j.*omega./2) .* sin(omega./2); 


% Efetuar os plot
% abs(H1) angle(H1)
% abs(H3) angle(H3)

subplot(2,2,1);
plot(omega, abs(H1));
subplot(2,2,2);
plot(omega, angle(H1));
subplot(2,2,3);
plot(omega, abs(H3));
subplot(2,2,4);
plot(omega, angle(H3));

%% Alinea b
% Se colocar à entrada do sistema h1 um sinal sinusoidal com amplitude
% unitária e frequencia pi/4, qual irá ser a amplitude do sinal à saída (dê
% uma estimativa para esse valor com base nos gráficos) ?

freq = pi/4;

% O sinal sinusoidal pode ser escrito como exp(j*omega*n) e assim podemos
% usar  resultado do ex 3. Deste modo, a resposta será dada por
% c*exp(j*omega*n), onde c = H(exp(j*omega)). O módulo deste sinal fica
% abs(exp(j*omega)*H) <=> 1 * abs(H)
amp = 1 * abs(exp(-j.*freq./2).* cos(freq./2))



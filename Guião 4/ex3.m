%% Exercicio 3
% Usando o MATLAB, verifique que a resposta destes sistemas ao sinal
% exp(j*omega*n) é o sinal c*exp(j*omega*n), onde  c = H(exp(j*omega)) é a
% resposte me frequencia do sistema. Faça essa verificação para um dos
% sistemas à sua escolha, para omega = 0, pi/4, pi/2, 3pi/4 e pi, e n = 0,
% 1,..., 49

clc; clear;

omega = [0 pi/4 pi/2 3*pi/4 pi ];       % valores da frequencia
n = 0:49;                               % valores das abcissas

% sistemas - Todos os usados até ao momento
h1 = [0.5 0.5];
h2 = [0.25 0.25 0.25 0.25];
h3 = [0.5 -0.5];

% célula com todos os sistemas
h = cell(1,3);
h{1, 1} = h1;
h{1, 2} = h2;
h{1, 3} = h3;


for c = 1 : length(h)       % para cada sistema
    figure(c);              % gerar uma imagem
    
    for k = 1 : length(omega)    % por cada valor de omega
        x = exp(j.*omega(k).*n);  % gerar o sinal de entrada
       
        N = length(h{1,c});      % length dos elementos do sistema
        nn = 0:N - 1;            % indices do somatório, [0, ..., N-1]
        
        % calcular a resposta em frequencia do sistema
        H = sum( h{1,c} .* exp(-j.*omega(k).*nn));    
                     
        % calcular a convulução entre o sinal de entrada e a resposta 
        % impulsional do sistema selecionado
        y = conv(x, h{1,c});        

        % sinal de entrada muliplicado pela resposta em frequencia do sistema
        z = x * H;             
        
        % um subplot para cada valor de omega diferente
        subplot(length(omega), 1, k);   
        plot(n, y(1:length(n)),'r', n, z , 'b', 'LineWidth', 2);   
    end;
end;

%% Exercicio 6
% Usando a função que desenvolveu, observe o módulo da resposta em
% frequencia do sistema h2 e compare com o do sistema h1. Teste ambos os
% filtros em sinais de áudio e comente as diferenças. Experimente também
% outras variações de filtros deste tipo, comparando o resultado audivel
% com a forma do módulo da resposta em frequencia desses filtros

clear; clc;

omega = linspace(0, 2*pi, 1000);        % gerar as frequencias

h1 = [0.5 0.5];                         % Definir os sistemas
h2 = [0.25 0.25 0.25 0.25];

% Resposta em frequencia do filtro h1
H1 = H_FIR(h1, omega);               

% Resposta em frequencia do filtro h2
H2 = H_FIR(h2, omega);                

% Gráfico das respostas em frequencia dos filtros
plot(omega, abs(H1), omega, abs(H2))            
legend('H1', 'H2');

addpath('../Sons/');                    % adicionar à path a pasta dos sons
sound_dir = dir('../Sons/*.wav');       % obter o path dos sons

% criar uma celula para armazenar as wave
wav = cell(length(sound_dir), 4);      

% celula para a resposta impulsional dos sistemas. Guardar os sistemas e
% string com o respetivo nome
h = cell(2, 2);                         

h{1, 1} = h1;  h{2, 1} = 'h1';          
h{1, 2} = h2;  h{2, 2} = 'h2';


for c = 1 : length(h)                   % para cada sistema
    for k = 1 : length(sound_dir)       % para cada sample
        
        % obter as waves 
        [x, Fa] = wavread(sound_dir(k).name);    
        
        % sinal original na coluna 1
        wav{k, 1} = x;      
        
        % frequencia de amostragem na coluna 2
        wav{k, 2} = Fa;            
        
        % convulução aplicada ao left
        wav{k, 3} = conv(h{1, c}, wav{k,1}(:,1)); 
        
        % verificar se é stereo -  ver numero de colunas na matriz de audio
        stereo = size(wav{k, 1});                 
        if ( stereo(2) == 2 )
            % convulução aplicada ao right
            wav{k, 4} = conv(h{1, c}, wav{k,1}(:,2));  
            wav{k, 3} = [ wav{k,3} wav{k, 4} ];   % stereo sound
        end;

        % gravar o som -> sinal, frequencia de amostragem, nº de bits e nome
        wavwrite(wav{k, 3}, wav{k, 2}, 16,  strcat(sound_dir(k).name(1:end-4), '_', h{2, c}, '.wav')); 
    end;
end;







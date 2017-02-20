%% Exercicio 3
% TAG; wave, wav, musica, música
% No moodle, pode encontrar um conjunto de sete segmentos de aúdio em 
% formato WAV, “sample01”, . . . , “sample07”. Use a função wavread do 
% MATLAB para os ler. Calcule e visualize os histogramas dos vários 
% segmentos de aúdio e compare-os com a distribuição uniforme. Comente
% o que observa.

clc; clear;
%path = '/media/martinspedro/DATA/UA/2º Ano/4º Semestre/Introdução à Análise e Processamento de Sinal/Aulas Práticas/Sons';

tree = dir('../Sons/sample*.wav');  % obter os ficheiros sample....wav no diretorio 
addpath('../Sons');                 % precisa de estar no diretorio do matlab -> adicionar

n = length(tree);                   % numero de samples

for k = 1 : length(tree)            % por cada sample     
    
      figure(1);                    % figura 1 -> histogramas
      subplot(1, n, k);             % selecionar o subplot
      wave = wavread(tree(k).name); % ler a wave
      hist(wave)                    % dar plot ao histograma      
      
      figure(2);                    % figura 2 -> plot das waves
      subplot(n, 1, k);             % selecionar o subplot
      plot(wave);                   % dar plot à wave
end;



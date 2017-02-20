%% Exercicio 3
% No moodle, pode encontrar um conjunto de sete segmentos de aúdio em 
% formato WAV, “sample01”, . . . , “sample07”. Use a função wavread do 
% MATLAB para os ler. Calcule e visualize os histogramas dos vários 
% segmentos de aúdio e compare-os com a distribuição uniforme. Comente
% o que observa.

clc; clear;
%path = '/media/martinspedro/DATA/UA/2º Ano/4º Semestre/Introdução à Análise e Processamento de Sinal/Aulas Práticas/Sons';

tree = dir('../Sons/');           % obter a estrutura de dados
addpath('../Sons');              % precisa de estar no diretorio do matlab -> adicionar


count = 0;    % numero de ocorrencias de ficheiros 'sample'

for k = 1 : length(tree)
     if(length(strfind(tree(k).name, '.wav')) == 1) % procurar no nome do ficheiro por 'sample' -> so uma ocorrencia, ou seja, length desse vetor == 1
         count = count + 1;
     end;
end;

n = 1;      %indice inicial do subplot
for k = 1 : length(tree)
   if(length(strfind(tree(k).name, 'sample')) == 1)   % procurar no nome do ficheiro por 'sample' -> so uma ocorrencia, ou seja, length desse vetor == 1
     
      figure(1);                    % figura 1 -> histogramas
      subplot(1, count, n);         % selecionar o subplot
      wave = wavread(tree(k).name); % ler a wave
      hist(wave)                    % dar plot ao histograma      
      
      figure(2);                    % figura 2 -> plot das waves
      subplot(count, 1, n);         % selecionar o subplot
      plot(wave);                   % dar plot à wave
      
      n = n + 1;                    % incrementar o indice

   end;
end;



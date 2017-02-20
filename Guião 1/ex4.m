%% Ex4
% TAG: sequencia, replicar vetores
% Construa um vetor y com 256 elementos de acordo com a sequencia 
% 0, 1, 0, -1, 0, 1, 0, -1, ...

clear; clc;

%% Primeira posibilidade
% Usar a função sin com argumento multiplo de pi/2. Deste modo é possivel
% oscilar entre 1, 0, -1 conforme o pretendido

f = inline('sin(pi./2*n)', 'n'); 

% Gerar um vetor com 256 elementos (Note que varia de 0 a 255, porque o
% primeiro elemento da sequencia tem de ser nulo
vv = 0:1:255;

% Amostrar o sin
v = f(vv)

stem(vv, v)

%% Segunda possibilidade
% Criar um vetor com 256 zeros e substituir periodicamente os valores que
% se pretende que não sejam zeros

v = zeros(1, 256);   % vetor de zeros

% O periodo de repetição dos valores é de 4 amostras
v(2:4:end) = 1;      % o primeiro 1 ocorre na segunda posição (os indices começa em 1)
v(4:4:end) = -1;     % o primeiro -1 ocorre no indice 4. 


%% Terceira possibilidade
% Criar um vetor com a repetição e ir concatenando o vetor a si mesmo
% Se as dimensoẽs do vetor pretendido nao puderem ser diretamente obtidas
% pela concatenação é necessário realizar mais operações

v = [ 0 1 0 -1]     %criar um vetor com a repetição 

% usar um ciclo for para concatenar o vetor a si mesmo
for i = 1 : 6
    v = [ v v ];
end;

disp(v)

%% Quarta Possibilidade
% Criar o vetor com a repetição e usar a função repmat para replicar o
% vetor passando como argumento o indice do 1º elemento e o numero de vezes
% a replicar
% vector destino = repmat(vector origem, indice do 1º elemento, numero de repetições)

% criar um vetor com a o que se pretende repetir 
v = [ 0 1 0 -1];       

% Começa no 1º elemento e repete o numero de elementos pretendidos/numero
% de elementos no vetor a repetir
v = repmat(v, 1, 256/4)    

%% Quinta Possibilidade
% Usar a multiplicação entre vectores linha e coluna para obter o vector pretendido

% Definir o padrão
v = [ 0 1 0 -1 ];           

% Multiplicar v' com uma vector coluna de nº elementostotal /nº de elementos no vetor com o padrão
v = v' * ones(1, 64);

% Concatenar coluna a coluna todos os elementos da matriz, para criar um
% vetor coluna
v = v(:)

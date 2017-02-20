%% Exercicio 2
% Compare o numero de bytes ocupado por cada um dos ficheiros JPEG (Tc,
% tamanho comprimido) com o numero de bytes indicado pela função whos (Td,
% tamanho descomprimido), e calcule a taxa de compressão de cada imagem,
% isto é, Td/Tc. Sugira razões para a variação verificada na taxa de
% compressão de imagem para imagem.

clear; clc;

% adicionar ao path o diretorio onde estão guardadas as imagens
addpath('../Imagens');     

% ler ficheiros *.jpg do path
imagdir = dir('../Imagens/*.jpg');              

% criar uma célula de arrays com um numero de linhas igual ao numero de
% imagens e 1 coluna
imag = cell(length(imagdir), 1);    

% Criar vetores coluna de zeros
Tc = zeros(length(imagdir),1);
Td = zeros(length(imagdir),1);

for k = 1: length(imagdir)          % para cada imagem      
    % ler as matrizes(imagens) para um array num indice da célula
    imag{k,1} = imread(imagdir(k).name);    

    Tc(k,1) = imagdir(k).bytes;         % numero de bytes comprimido
    
    % obter as dimensões das matrizes das imagens através do size. Efetuar  
    % o seu produto para obter o numero de células da matriz... cada  
    % elemento ocupa um byte (uint8), logo obtemos o numero de bytes   
    Td(k,1) = prod(size(imag{k,1}));         
    
    % Mostrar a informação
    disp(strcat(imagdir(k).name, '| Comprimida: ', int2str(Tc(k,1)), ' | Descomprimida: ', int2str(Td(k,1))));      % alternativa para verificar
    disp('Td/Tc:');
    disp(Td(k,1)/Tc(k,1))
end;

% P: Sugira razões para a variação verificada na taxa de compressão de imagem para imagem.
% R: Podemos observar que para as imagens a cores(europe e news), a taxa de
% compressão permite ocupar aproximadamente 3 vezes menos espaço do que
% ocupa a imagem descomprimida. 
% Nas imagens a preto e branco, todas têm o mesmo numero de pixeis, pelo
% que o seu tamanho descomprimido é igual. No entanto, a sua relação entre
% o seu tamanho comprimido e descomprimido é diferente, ou seja, a taxa de
% compressão não é igual para todas. Tal pode se dever às diferentes
% tonalidade presente nas imagens... (?)

%% Exercício 1
% Usando a função whos, obtenha o número de bytes ocupado por cada uma das
% imagens
clear; clc;

% adicionar ao path o diretorio onde estão guardadas as imagens
addpath('../Imagens');          

% ler ficheiros *.jpg do path
imagdir = dir('../Imagens/*.jpg');             

% criar uma célula de arrays com um numero de linhas igual ao numero de
% imagens e 1 coluna
imag = cell(length(imagdir), 1);               

for k = 1: length(imagdir)      % para cada imagem
        
    disp(imagdir(k,1).name);    % nome da imagem 

    % ler as matrizes(imagens) para um array da célula
    imag{k,1} = imread(imagdir(k,1).name);    
    
    figure(k);          % criar uma figura
    imshow(imag{k,1});  % mostrar a imagem
    
    aux = imag{k,1};
    whos aux                               
end;

%% Alinea a
% P: Repare que a variável onde ficam armazenadas duas delas é
% tridimensional. Porque?
% R: São imagens RGB. Uma dimensão para cada uma das componentes da cor

%% Alinea b
% Visualize cada uma dessas três dimensões (planos) em separado e tente
% interpretar o que vê

% sabemos que existem 2 imagens.. Assim vamos criar uma celula com 2 linhas 
% (1 para cada imagem) e 3 colunas ( uma para cada componente(R, G, B) )
RGB = cell(2, 3);       

n = 1;                  % indice das célula 
                        
for k = 1:  length(imagdir)     % para cada imagem
    % o size(imag{k,1}) indica a dimensão de cada um dos "eixos" da matriz
    % Como são imagens, têm no minimo 2 (comprimento e largura). No
    % entanto, se forem RGB, existem a sobreposição de 3 planos (R, G, B),
    % Assim, length(size(imag{k,1})) indica se a matriz é bidimensional
    % (preto e branco) ou se é tridimensional (cores)
    if( length(size(imag{k,1})) == 3 )  
        
        % obter a componente de cada uma das cores
        RGB{n, 1} = imag{k,1}(:,:,1);           % R
        RGB{n, 2} = imag{k,1}(:,:,2);           % G
        RGB{n, 3} = imag{k,1}(:,:,3);           % B
        
        % criar a figura e mostrar a imagem so com essa cor (matriz
        % bidimensional)
        figure(n*1); imshow(RGB{n,1});
        figure(n*2); imshow(RGB{n,2});
        figure(n*3); imshow(RGB{n,3});
        
        pause;
        
        n = n + 1; 
    end;
end;

%% Alinea C
% Para transformar uma imagem a cores numa de niveis de cinzento (preto e
% branco), usa-se a seguinte relação c = 0.299r + 0.587g + 0.144b, onde r,
% g e b são as intensidades de vermelho, verde e azul, respetivamente e c o
% nível de cinzento correspondente. Usando esta relação, crie imagens a
% preto e branco a partir das imagens a cores. Nota: para poder realizar
% algumas das operações poderá ter que utilizar as funções double e uint8

n = 1;          % reset index

for k = 1: length(imagdir)
    % o size(imag{k,1}) indica a dimensão de cada um dos "eixos" da matriz
    % Como são imagens, têm no minimo 2 (comprimento e largura). No
    % entanto, se forem RGB, existem a sobreposição de 3 planos (R, G, B),
    % Assim, length(size(imag{k,1})) indica se a matriz é bidimensional
    % (preto e branco) ou se é tridimensional (cores)
    if( length(size(imag{k,1})) == 3 )  
        % calcular a conversão para níveis de cinzento. É necessário
        % converter os valores da imagem para double e de seguida converter
        % o resultado novamente para uint8
        c = uint8(0.299.*double(RGB{n,1}) + 0.587.*double(RGB{n, 2}) + 0.144.*double(RGB{n, 3}));  %% convert to Black and White
        
        figure(n);      % criar nova figura e mostrar imagem
        imshow(c);
        n = n + 1;      % increment index
    end;
end;

%% Alinea D
% Obtenha o negativo das várias imagens e visualize-as

% Cria uma celula para guardar os negativos
neg = cell(length(imagdir), 1);         

for k = 1 : length(imagdir)            % para cada imagem
    % calcular o negativo. subtrair o valor da imagem ao máximo valor
    % possível que esta pode tomar (uint8 => 2^(8-1)-1 = 255)
    neg{k, 1} = 255 - imag{k,1};      
    
    figure(k);              % mostrar o negativo                         
    imshow(neg{k,1});
end;
        
        
        
        
        
        
        
        
        
        
        
        
        
        

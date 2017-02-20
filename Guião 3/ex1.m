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

for k = 1: length(imagdir)
    if(length(imagdir(k).name) > 3)             % se a length dos ficheiros for maior que 3 
                                                % -> nao e necessario devido à forma como o dir esta definido
        if( strcmp(imagdir(k).name(end-3 : end),'.jpg') )   % verificar se os ficheiros são ficheiros .jpg 
                                                            % nao e necessario devido à definição do dir
                                                            
            disp(strcat(imagdir(k).name, ' -> ', int2str(imagdir(k).bytes)));      % alternativa para verificar 
                                                % o numero de bytes de cada ficheiro -> usar o whos
             
            figure(k);      % criar uma figura
            
            imag{k,1} = imread(imagdir(k).name);    % ler as matrizes(imagens) para um array num indice da célula
                 
            imshow(imag{k,1});                      % mostrar a imagem
            %title(imagdir(k).name);                % adicionar o nome da imagem
            
            whos imag                               % info
        end;
    end;
end;

%% Alinea a
% Teorica

%% Alinea b

RGB = cell(2, 3);       % sabemos que existem 2 imagens.. Assim vamos criar uma celula com 
                        % 2 linhas (1 para cada imagem) e 3 para cada componente(R, G, B) 
n = 1;                  % indice das célula 
                        
for k = 1:  length(imagdir)
    if( length(size(imag{k,1})) == 3 )
        RGB{n, 1} = imag{k,1}(:,:,1);           %R
        RGB{n, 2} = imag{k,1}(:,:,2);           %G
        RGB{n, 3} = imag{k,1}(:,:,3);           %B
        
        figure(n*1); imshow(RGB{n,1});
        figure(n*2); imshow(RGB{n,2});
        figure(n*3); imshow(RGB{n,3});
        pause;
        n = n +1;
    end;
end;

%% Alinea C

n = 1;          % reset index

for k = 1: length(imagdir)
    if( length(size(imag{k,1})) == 3 )          % check if is RGB
        c = uint8(0.299.*double(RGB{n,1}) + 0.587.*double(RGB{n, 2}) + 0.144.*double(RGB{n, 3}));  %% convert to Black and White
        
        figure(n);      % new figure and show image
        imshow(c);
        n = n + 1;      % increment index
    end;
end;

%% Alinea D

neg = cell(length(imagdir), 1);         % cell of arrays with negative of images

for k = 1 : length(imagdir)             % for all the images
    neg{k, 1} = 255 - imag{k,1};        % calculate negative (uint8 -> max value = 2^(8-1)-1 = 255
    figure(k);                          
    imshow(neg{k,1});
end;

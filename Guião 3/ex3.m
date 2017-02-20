%% Exercício 3
% Como se pode ver através da informaçao disponibilizada pela função whos,
% as variáveis onde se encontram guardadas as imagens são do tipo uint8
% (inteiros positivos de 8 bits)

clear; clc;

addpath('../Imagens');                          % adicionar ao path o diretorio onde estão guardadas as imagens
imagdir = dir('../Imagens/lena.jpg');           % obter a lena

lena = cell(6, 1);                              % criar celula para as varias versões da lena.
lena{6,1} = imread(imagdir(1).name);            % ordenada de forma decresecente
                                                % lena{6,1} -> 8 bits
                                                % lena{5,1} -> 7 bits
                                                % ....
                                                % lena{1,1} -> 3 bits
                                                
%% Alinea a
% Usando a operação de arredondamento, crie versões da imagem "lena" para
% 7, 6, 5, 4 e 3 bits. Para que número de bits começa a notar diferenças
% visuais entre a imagem original e a imagem arredondada?

% criar um figura para a imagem original. 
% O numero da figura indica o numero de bits
figure(8);                                      
imshow(lena{6,1})                               % mostrar original

for k = 7 : -1 : 3                              % de forma decrescente, quantizar para 7, 6, 5, 4 e 3 bits
    % Usando a função QuantImag, obter a imagem lena com o numero de bits
    % pretendidos. Notar que os indices do for e da célula estão desfasados -2
    lena{k-2, 1} = QuantImag(lena{6,1}, k);     % Quantizar
    
    figure(k);                                  % mostrar a figura 
    imshow(lena{k-2,1})
end;

% P: Para que número de bits começa a notar diferenças visuais entre a 
% imagem original e a imagem arredondada?
% R: 4 bits

%% Alinea a2
% Mostrar os resultados da alínea a na mesma imagem usando subplot
figure(1);

subplot(3,2,1);
imshow(lena{6,1})                               % mostrar original

title('lena 8 bits');

for k = 7 : -1 : 3                              % de forma decrescente, para cada imagem
    subplot(3,2,9-k);                           % mostrar a figura ( os indices do for e da célula estão desfasados -2)
    imshow(lena{k-2,1})
    title(strcat('lena ', int2str(k), ' bits'));
end;
    
%% Alinea b
% P: Calcule a taxa de de compressão que conseguiria obter por este processo,
% compare-a com as que determinou no número 2, e comente.

% array com os sizes das imagens
Size_lena = [];         

% array com os fatores de compressão
Compress_Factor = [];                           

% tamanho da original (tem de se multiplicar pelo numero de bits que cada 
% célula do array ocupa
Size_lena(6) = prod(size(lena{6,1})) * 8;       

for k = 7 : -1 : 3      % para cada imagem
    % tamanho da imagem quantizada. É necessario multiplicar pelo numero de
    % bits que cada elemento do array ocupa senão só se obtem o numero de 
    % elementos do array
    Size_lena(k-2) = prod(size(lena{k-2,1})) * k;
    
    % Calculo do factor de Compressão: Tamanho_Original/Tamanho_Comprimida
    Compress_Factor(k-2) = Size_lena(6)/Size_lena(k-2);  
    
    % Mostrar resultados
    disp(strcat('lena', int2str(k), 'bits ', ' - Compress Factor: '));
    disp(Compress_Factor(k-2))
    
end;

% R: Usando este método para comprimir é necessário descartar informação da
% imagem, o que reduz a sua qualidade, enquanto que a compressão JPEG usada
% no ex2 consegue taxas de compressão equivalentes (1.0909, 1.4223, 2.5888)
% sem alterar significativamente a qualidade de imagem (não é perceptível a
% compressão). 
% Para obter uma compressão semelhante à de 2.5888 verificada no exercício
% 2, temos de reduzir para menos de metade o número de bits da imagem
% original, o que origina uma enorme perda de qualidade de imagem
% Concluimos assim que os algoritmos de compressão JPEG efetuam compressão
% de uma forma que não envolve a quantização "crua" da imagem

%% Alinea c
% Trace um gráfico da SNR em função do número de bits. Comente os
% resultados

% Amplitude Máxima do sinal -> max(max(lena{6,1})), max para o maximo por linhas e depois por colunas
A = double(max(max(lena{6,1})));  

% Vetores vazios para guardar dados
Er = [];
PSNR = [];

for k = 7 : -1 : 3      % para cada imagem
    % Calcular o erro do ruido
    Er(k-2) = sum(sum((lena{6,1} - lena{k-2,1}).^2))/prod(size(lena{k-2,1}));   
    
    % Calcular o PSNR do sinal
    PSNR(k-2) = 10*log10(A^2/Er(k-2));                                           
end;

% plot dos PSNR para o numero de bits
figure(1);
plot([3 4 5 6 7], PSNR);       

% P: Comente os resultados
% R: Á medida que o numero de bits aumenta, o PSNR aumenta







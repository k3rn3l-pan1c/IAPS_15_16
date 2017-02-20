function Q = QuantImag(Imag,bits)
% Quantiza uma imagem para um numero de bits 
% Imag corresponde à matriz com os dados da imagem
% bits é o numero de bits pretendido por pixel


% numero de niveis de quantização
N = 2^bits;             

% intervalo entre os níveis de quantização (delta)
% delta = A/N, onde A é o intervalo de valores possiveis no intervalo
% A = Amax - AMin
delta = 256/N;      

% Quantização: Dividir o valor da imagem por delta para obter um sinal onde
% o arredondamento produza 2^b níveis de quantização. Após o
% arredondamento, multiplicar por delta para restaurar a magnitud da imagem
% original
Q = round(Imag/delta)*delta;    % quantização

% Como só podem existir 2^b -1  níveis de arrendondamento, é necessário
% eliminar um nível. A quantização é feita  com um numero par de bits. 
% Para o numero de niveis de quantização ser igual para > 0 e < 0, 
% considerando um nivel = 0, precisava-se de um numero impar de bits. Como
% pretendemos manter o nível 0, descartamos o nível 1 (em conformidade com
% os uso dos computadores porque usam complemento para 2
% Criamos uma matriz de indices booleanos, que têm valor 1 quando q == 1 e
% valor zero nos outros casos. Usando essa matriz para indexar o vetor de
% quantizado, descemos os pontos no nível de quantização 1 para o nível de
% quantização inferior (1 -delta)
Q (Q == 255) = 256-delta;       



function xq = quantiaps(x, b)
% xq = quantiaps(x, b)
% onde x corresponde ao vetor dos dados, |x| <= 1
% b o numero de bits da quantização
% nos niveis de quantização, o nível 1 nunca é usado 

% numero de niveis de quantização
N = 2^b;             

% intervalo entre os níveis de quantização (delta)
delta = 2/N;         

% Quantização: Dividir o valor do sinal por delta para obter um sinal onde
% o arredondamento produza 2^b níveis de quantização. Após o
% arredondamento, multiplicar por delta para restaurar a magnitud do sinal
% original
xq = round(x/delta)*delta;               % quantização

% Como só podem existir 2^b -1  níveis de arrendondamento, é necessário
% eliminar um nível. A quantização é feita  com um numero par de bits. 
% Para o numero de niveis de quantização ser igual para > 0 e < 0, 
% considerando um nivel = 0, precisava-se de um numero impar de bits. Como
% pretendemos manter o nível 0, descartamos o nível 1 (em conformidade com
% os uso dos computadores porque usam complemento para 2
% Criamos um vetor de indices booleanos, que têm valor 1 quando q == 1 e
% valor zero nos outros casos. Usando esse vetor para indexar o vetor
% quantizado, descemos os pontos no nível de quantização 1 para o nível de
% quantização inferior (1 -delta)
xq(xq == 1) = 1 - delta;                 
                     
               

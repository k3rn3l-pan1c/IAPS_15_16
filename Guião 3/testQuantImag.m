function Q = testQuantImag(bits)
%Função de teste para a QuantImag


x = uint8(rand(1000)*255);          % criar um array random de inteiros entre 0 e 255
aux = unique(QuantImag(x, bits));   % Quantizar e mostrar os niveis de quantização
length(aux)                         % numero de niveis de quantização -> tem de ser = 2^bits

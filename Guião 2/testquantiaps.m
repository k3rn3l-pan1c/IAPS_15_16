function xquant = testquantiaps(b)
% Gerar um sinal de pontos igualmente espaçados no intervalo [-1, 1]
x = linspace(-1, 1, 1000);
xq = quantiaps(x, b);       % quantizar usando a quantiaps

figure(1);      % Mostrar os valores
plot(x, xq);   
grid on

unique(xq)      % Niveis de quantização

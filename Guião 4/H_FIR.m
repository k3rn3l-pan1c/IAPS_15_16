function H = H_FIR(h, omega)
    % Recebendo a resposta impulsional de um sistema, h, e uma gama de
    % valores de frequencia, omega, calcula a sua resposta em frequencia, H
    
    % Numero de elementos do sistema
    n = 0:length(h) - 1;
    
    % Calcular a resposta em frequencia do sistema para a gama de
    % frequencias desejadas
    for k = 1:length(omega)
        H(k) = sum(h .* exp(-j.*omega(k).*n));
    end;
    

% Resolução com produto interno
%
% % Numero de elementos do sistema
% N = length(h);
%
% Numero de frequencias
% M = length(omega);
%
% Gerar um vetor de indices do ciclo for [0, 1, ..., N-1]
% n = 0:N-1;
%
% Para cada valor de frequencia, calcular a resposta em frequencia do
% sistema usando o produto interno
% For k = 1 : M
%   v = exp(j*omega(k)*n);      % gerar o vetor do sinal
%   H(k) = h * v';              % produto interno entre o sinal e a resposta do sistema
% end;
    
        
    
    
    

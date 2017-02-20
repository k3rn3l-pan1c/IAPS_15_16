function H = testeH_FIR()
    % função de teste à função H_FIR

    h1 = [0.5 0.5];                     % Sistemas de teste
    h2 = [0.5 -0.5];
    
    omega = linspace(0, 2*pi, 1000);    % valores da frequencia
    
      
    H1 = H_FIR(h1, omega);              % Resposta em frequencia para o sistema h1
    H2 = H_FIR(h2, omega);              % Resposta em frequencia para o sistema h2
   
    
    figure(1);
    plot(omega, H1, omega, H2);         % dar plot às respostas em frequencias dos sistemas
    legend('H1', 'H2');

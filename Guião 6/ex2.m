%% Exercicio 2

clear; clc;

load('../Sinais txt/dtmf2.txt')         % Sinal DTMF
Fa = 8000;                              % Frequencia de amostragem

% Estrutura com as DTMF
DTMF.F1  = [ 697, 770, 852, 941 ];
DTMF.F2  = [ 1209, 1336, 1477, 1633 ];
DTMF.SYM = [ '1', '2', '3', 'A', '4', '5', '6', 'B', '7', '8', '9', 'C', '*', '0', '#', 'D' ];

%% Alinea a
% 
N = length(dtmf2);          % Numero de amostras do sinal
n = 0:N - 1;

dur = N / Fa                % Duração do sinal

figure(1)                   % Sinal dtmf
plot(n, dtmf2)              
title('Sinal DTMF Original');
xlabel('Indice das amostras');
ylabel('DTMF(t)');

% como se pode verificar pelo plot, o sinal dtmf não é centrado em zero e o
% ruido não ultrapassa o nivel 0. Só os dígitos possuem componentes no
% sinal com amplitude superior a zero. Assim, vamos procurar por picos
% percorrendo o sinal e sempre que encontrarmos um valor superior a 0,
% guardamos e ignoramos até o símbolo terminar. 
% Para obter o indice onde os simbolos terminam, percorremos o vetor ao
% contrario


save_idx = 1;           % flag para controlar se o indice deve ser guardado
start_idx = [];         % vetor com os indices de início do simbolo

for k = n + 1           % para todos os valores do sinal de forma crescente
    % se o valor do sinal for positivo (ou seja, não é ruído) e se for para
    % guardar o indice, adicionar o indice onde o pico ocorre e dar reset à
    % flag
    if (dtmf2(k) > 0 && save_idx)
        start_idx = [ start_idx k ];
        save_idx = 0;
    end;
    
    % precisamos de um valor de controlo e para não usarmos indices
    % negativos quando usamos dados anteriores
    if ( k > 100 )       
        if ( dtmf2(k - 100 : k) < 0 )       % se existerem 100 valores negativos seguidos
            save_idx = 1;                   % pela analise gráfica sabemos que estamos numa
        end;                                % zona de ruido -> dar toggle à flag
    end;
end;

save_idx = 1;           % flag para controlar se o indice deve ser guardado
last_idx = [];          % vetor com os indices de fim de símbolo

for k = N-1 :-1: 1      % decresecente
    % se o valor do sinal for positivo (ou seja, não é ruído) e se for para
    % guardar o indice, adicionar o indice onde o pico ocorre e dar reset à
    % flag
    if (dtmf2(k) > 0 && save_idx)
        last_idx = [ last_idx k ];
        save_idx = 0;
    end;
    
    % precisamos de um valor de controlo e para não usarmos indices
    % negativos quando usamos dados anteriores
    if ( k > 100)
        if ( dtmf2(k-100 : k) < 0 )          % se existerem 100 valores negativos seguidos
            save_idx = 1;                    % pela analise gráfica sabemos que estamos numa
        end;                                 % zona de ruido -> dar toggle à flag
    end;
end;

Nsym = length(last_idx);    % Numero de simbolos

% Organizar os indices: Linha -> diferentes simbolos. 
% Coluna 1: indice de inicio. Coluna 2: indice de fim
sym_idx = zeros(Nsym, 2); 

Mean_elem = 0;

for k = 1 : Nsym
    % Para cada simbolo fica numa linha da célula. A 1ª coluna indica o
    % indice onde começa e a 2ª onde acaba
    sym_idx(k, 1) = start_idx(k)  ;
    sym_idx(k, 2) = last_idx(end + 1 - k);
    
    % Média do numero de elementos
    Mean_elem = Mean_elem + ( sym_idx(k, 2) - sym_idx(k, 1) ) / Nsym;
end;

% Duração média de cada simbolo (média do numero de amostras / Frequencia de amostragem)    
dur_sym = Mean_elem / Fa        

% Como se pretende a duração do espaçamento entre cada dígito, vamos
% ignorar as duas metades de silencio, uma no inicio e outra no fim do
% sinal. Para isso basta somar os intervalos entre os simbolos dos sinais e
% dividir pelos numeros de  - 1
dur_sil = 0;      

% Nos intervalos 
for k = 2 : Nsym
    dur_sil = dur_sil + ( (sym_idx(k, 1) + 1) - (sym_idx(k - 1, 2) - 1) );
end;  

dur_sil = ( dur_sil / (Nsym - 1)) / Fa            % duração do silencio

% Check -> Ok!
4 * (dur_sil + dur_sym)


%% Alinea b

% Inicializações

DIGITO    = cell(Nsym, 1);    % FFT de cada digito
N_DIG     = zeros(Nsym, 1);   % Numero de elementos que conpoem o digito
FFT_index = cell(Nsym, 1);    % Indices da FFT que correspondem às frequencias do DTMF
word      = zeros(1, Nsym);   % Palavra para guardar os dígitos


for k = 1 : Nsym         
    % obter o segmento de audio correspondente ao simbolo
    digito = dtmf2(sym_idx(k, 1) : sym_idx(k,2));      
    
    % Aplicar a DFT ao segmento
    DIGITO{k, 1} = fft(digito);                 
    
    % Numero de amostras da FFT do dígito
    N_DIG(k) = length(DIGITO{k, 1});      
    
    % plot da DFT
    figure(k + 1)                                     
    stem((1:N_DIG(k)) , abs(DIGITO{k, 1}))
    title([' DFT do Simbolo ' num2str(k)])
    xlabel('Frequencia (Hz)');
    ylabel('|X(f)|');        
    
    % Encontrar as duas primeiras frequencias com maior amplitude
    % (escolhemos 80, porque é um valor razoável considerando os plots das
    % FFT) 
    FFT_index{k, 1} = find( DIGITO{k, 1} > 80, 2);            
    
    % converter os indices da FFT para valores de frequencia
    f = FFT_index{k, 1}* Fa/N_DIG(k);              
    
    % obter os indices na estrutura DTMF
    idx1 =  find( ( DTMF.F1 < f(1) + 20 ) & ( DTMF.F1 > f(1) - 20 ) );  
    idx2 =  find( ( DTMF.F2 < f(2) + 20 ) & ( DTMF.F2 > f(2) - 20 ) );
    
    % O indice do simbolo na estrutura DTMF é obtido considerando uma
    % tabela 4x4 onde idx1 é o indice das linhas e idx2 o indice das
    % colunas. Assim, (idx1 - 1) indica qual a linha depois da 1ª onde o
    % simbolo pertence. Se mulitplicarmos por 4, saltamos uma linha inteira
    % da matriz. Somando o valor da coluna pretendida permite-nos obter o
    % indice correspondente ao simbolo
    DTMF_idx = (idx1 - 1) * 4 + idx2;
    
    % Indexar com o indice calculado anteriormente e concatenar para formar
    % a palavra com os digitos DTMF
    word = [ word DTMF.SYM(DTMF_idx) ];
end;
    
    disp([ 'O numero contido no DTMF é: ' word])
    
%% Alinea c
DTMF_clean = zeros(1, N);           % vetor com a mesma dimensão que o DTMF original

for k = 1 : Nsym                    % Por cada simbolo
    % Eliminar as frequencias indesejadas
    aux = zeros(1, N_DIG(k));       % vetor auxiliar com o numero de elementos do digito
    
    % Atribuir para cada simbolo somente as frequencias que compoem a DTMF
    % (usando as frequencias originais dos sinal)
    aux(FFT_index{k, 1}) = DIGITO{k, 1}(FFT_index{k, 1});   % atribuir as frequencias 
    
    % usar também as frequencias geradas devido à reflexão do sinal
    reflected_idx = N_DIG(k) + 1 - (FFT_index{k, 1} - 1);             
    aux(reflected_idx) = DIGITO{k, 1}(reflected_idx);
    
    % Calcular a Transformada inversa de Fourier e atribuir ao sinal DTMF
    DTMF_clean(sym_idx(k, 1) : sym_idx(k, 2)) = ifft(aux);

end;

% dar plot ao sinal
figure          
plot(n ./ Fa, DTMF_clean)
title('DTMF com correção de ruído');
xlabel('Tempo (s)');
ylabel('DTMF(t)');    
















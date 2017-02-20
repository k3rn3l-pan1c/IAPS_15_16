%% GERAL
clc; clear;

fa = 48*10^3;           % frequencia de amostragem
Ta = 1/fa;              % periodo de amostragem
n = 1:Ta:2*pi;          % numero de amostras...

y =  sin(2*pi*n);       % sin amostrado



soundsc(y);
%% 
q = quantiaps(y,12);

soundsc(q);
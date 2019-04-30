clear all;
close all;
clear all;
clc;

SNRdB=10;                            %SNR in dB
SNR=10.^(SNRdB./10);                     %SNR in linear scale   
info_word_length=10000;                 %No. of information words   
nBit=7;k=4;                                 %Parameters of hamming code   
ber=zeros(length(SNR),2);                %Simulated BER   
info_word=floor(2*rand(k,info_word_length));    %Generation of 0 and 1 for infromation bits
code_bit5=xor(info_word(1,:),xor(info_word(2,:),info_word(3,:)));   %First Parity Bit
code_bit6=xor(info_word(1,:),xor(info_word(3,:),info_word(4,:)));   %Second Parity Bit
code_bit7=xor(info_word(1,:),xor(info_word(2,:),info_word(4,:)));   %Third Parity Bit
code_word=[info_word;code_bit5;code_bit6;code_bit7];       %Coded information Word with parity bits
code_word(code_word==0)=-1;              %Converting 0 bits to 1

decoded_bit=zeros(nBit,info_word_length);             %HARD Decoding Output   
decoded_block=zeros(nBit,info_word_length);           %SOFT Decoding Output
H=[1 1 1;1 0 1;1 1 0;0 1 1;1 0 0;0 1 0;0 0 1];     %Parity Check Matrix
C=de2bi((0:2^(k)-1));                       %All bits of length k(Stored in valid code words matrix 'C')
C(1:16,5)=xor(C(:,1),xor(C(:,2),C(:,3)));   %First Parity Bit
C(1:16,6)=xor(C(:,1),xor(C(:,3),C(:,4)));   %Second Parity Bit
C(1:16,7)=xor(C(:,1),xor(C(:,2),C(:,4)));   %Third Parity Bit
EbN0_lin=10.^(0.1*SNR);
h=1/sqrt(2)*(normrnd(0,1)+1i*normrnd(0,1));
%h=1/sqrt(2)*(randn(num_symbols,1)+1i*randn(num_symbols,1)); %N(0,1)
n=1/sqrt(2)*(sqrt(1/EbN0_lin)*randn(info_word_length,1)+1i*sqrt(1/EbN0_lin)*randn(info_word_length,1)); %N(0,sigma^2)
hh=rot90(fliplr(h),-1);
nn=rot90(fliplr(n),-1);
y = (hh.*code_word+(nn));
fh2 = figure;
plot(real(y), imag(y), '.');
plot_lims = [-1.5 1.5];
xlim(plot_lims);
ylim(plot_lims);
title(['Hamming constellation at an SNR of ' num2str(SNRdB) ' dB']);
xlabel('real part');
ylabel('imaginary part');
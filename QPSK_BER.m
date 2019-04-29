%BER
%QPSK BER
clear all;
const=[1 -1];
num_symbols = 1000;
iter_max=1000;
EbN0_min=0;
EbN0_max=100;
SNR=[];BER=[];



for EbN0 = EbN0_min:EbN0_max
    EbN0_lin=10.^(0.1*EbN0);
    noise_var=0.5/(EbN0_lin); % s^2=N0/2
    iter = 0;
    err = 0;
    while (iter <iter_max && err <100)        
        int_symbols = randi([1, 4], 1, num_symbols);
        A = 1/sqrt(2);
        qpsk_symbols = zeros(size(int_symbols));
        qpsk_symbols(int_symbols == 1) =   A + 1i*A;
        qpsk_symbols(int_symbols == 2) =   A - 1i*A;
        qpsk_symbols(int_symbols == 3) = - A + 1i*A;
        qpsk_symbols(int_symbols == 4) = - A - 1i*A;
        tx_sig = qpsk_symbols;
        
         h=1/sqrt(2)*(normrnd(0,1)+1i*normrnd(0,1));
%         h=1/sqrt(2)*(randn(num_symbols,1)+1i*randn(num_symbols,1)); %N(0,1)
        n=1/sqrt(2)*(sqrt(1/EbN0_lin)*randn(num_symbols,1)+1i*sqrt(1/EbN0_lin)*randn(num_symbols,1)); %N(0,sigma^2)
        hh=rot90(fliplr(h),-1);
        nn=rot90(fliplr(n),-1);
        rx_sig = (hh.*tx_sig+nn);
        for r = 1:length(rx_sig)
                image_part_part = 0.7071;
                real_part = 0.7071;
                if(imag(rx_sig(r))>=0 && real(rx_sig(r))>=0)
                    image_part = 0.7071;
                    real_part = 0.7071;
                elseif(imag(rx_sig(r))<0 && real(rx_sig(r))>0)  
                     image_part = -0.7071;
                     real_part = 0.7071;     
                elseif(imag(rx_sig(r))>0 && real(rx_sig(r))<0) 
                    image_part = 0.7071;
                    real_part = -0.7071;
                elseif(imag(rx_sig(r))<0 && real(rx_sig(r))<0)
                    image_part = -0.7071;
                    real_part = -0.7071;
                end

                if((image_part * imag(tx_sig(r))) < 0)
                    err = err + 1;
                end
                if((real_part * real(tx_sig(r))) < 0)

                    err = err + 1;
                end
        end
        iter = iter + 1;
        
    end
    disp(err)
    SNR =[SNR EbN0];
    BER = [BER err/(num_symbols*iter)];
end
semilogy(SNR,BER);
grid;
xlabel('Signal to Noise Ratio');
ylabel('Bit Error Rate');
title('QPSK over AWGN channel');



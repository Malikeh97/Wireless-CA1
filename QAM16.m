clear all;
M = 16;
k = log2(M);
num_symbols = 1000*k
data = randi([0 1],num_symbols,1);
txSig = qammod(data,M,'InputType','bit','UnitAveragePower',true);
scatterplot(txSig)
snrd = 0.1; %// in dB
snrn = 10.^(snrd./10)
h=1/sqrt(2)*(randn(num_symbols,1)+1i*randn(num_symbols,1)); %N(0,1)
%h=1/sqrt(2)*(normrnd(0,1)+1i*normrnd(0,1)); %test
n=1/sqrt(2)*(sqrt(1/snrn)*randn(num_symbols,1)+1i*sqrt(1/snrn)*randn(num_symbols,1)); %N(0,sigma^2)
hh=rot90(fliplr(h),-1);
nn=rot90(fliplr(n),-1);
rxSig = hh.*txSig+nn;

fh2 = figure;
plot(real(rxSig), imag(rxSig), '.');
plot_lims = [-1.5 1.5];
xlim(plot_lims);
ylim(plot_lims);
title(['QPSK constellation at an SNR of ' num2str(snrd) ' dB']);
xlabel('real part');
ylabel('imaginary part');
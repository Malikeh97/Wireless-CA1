num_symbols = 1000;
int_symbols = randi([1, 4], 1, num_symbols);
A = 1/sqrt(2);
qpsk_symbols = zeros(size(int_symbols));
qpsk_symbols(int_symbols == 1) =   A + 1i*A;
qpsk_symbols(int_symbols == 2) =   A - 1i*A;
qpsk_symbols(int_symbols == 3) = - A + 1i*A;
qpsk_symbols(int_symbols == 4) = - A - 1i*A;
tx_sig = qpsk_symbols;

h1 = figure;
plot_lims = [-3 3];
plot(real(qpsk_symbols), imag(qpsk_symbols), '.');
xlim(plot_lims);
ylim(plot_lims);
title('QPSK constellation without noise');
xlabel('real part');
ylabel('imaginary part');
snrd = 10; %// in dB
snrn = 10.^(snrd./10)
% h=1/sqrt(2)*(randn(num_symbols,1)+1i*randn(num_symbols,1)); %N(0,1)
h=1/sqrt(2)*(normrnd(0,1)+1i*normrnd(0,1)); %test
n=1/sqrt(2)*(sqrt(1/snrn)*randn(num_symbols,1)+1i*sqrt(1/snrn)*randn(num_symbols,1)); %N(0,sigma^2)
% rx_sig = awgn(h*tx_sig, snr, 'measured');
hh=rot90(fliplr(h),-1);
nn=rot90(fliplr(n),-1);
rx_sig = hh.*tx_sig+nn;
fh2 = figure;
plot(real(rx_sig), imag(rx_sig), '.');
xlim(plot_lims);
ylim(plot_lims);
title(['QPSK constellation at an SNR of ' num2str(snr) ' dB']);
xlabel('real part');
ylabel('imaginary part');

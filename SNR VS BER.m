clc; clear;
Nbits = 8;                 % PCM bits
Fs = 8000;                % sampling freq
t = 0:1/Fs:0.05;          % time

x = sin(2*pi*100*t);      % 100 Hz sine

L = 2^Nbits;
xq = round((x+1)/2 * (L-1));   % map [-1,1] → [0, L-1]

bitstream = de2bi(xq, Nbits, 'left-msb');
bitstream = bitstream(:);   % column vector

SNR_dB = 0:2:20;   % range
BER = zeros(size(SNR_dB));

for i = 1:length(SNR_dB)

    % Add noise
    noisy = awgn(bitstream, SNR_dB(i), 'measured');

 
    received_bits = noisy > 0.5;

    errors = sum(bitstream ~= received_bits);
    BER(i) = errors / length(bitstream);

end
figure;
semilogy(SNR_dB, BER, 'o-', 'LineWidth', 2);
grid on;
xlabel('SNR (dB)');
ylabel('Bit Error Rate (BER)');
title('BER vs SNR for PCM System');

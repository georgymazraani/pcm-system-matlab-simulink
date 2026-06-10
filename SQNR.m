x = out.sampled_signal;
y = out.quantized_signal;

x = x(:);
y = y(:);

minLen = min(length(x), length(y));
x = x(1:minLen);
y = y(1:minLen);

e = x - y;

signal_power = mean(x.^2);
noise_power  = mean(e.^2);

SQNR_dB = 10 * log10(signal_power / noise_power);

fprintf('SQNR = %.4f dB\n', SQNR_dB);
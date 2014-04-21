function [f power] = AudioToFFT(audio_data)
fs = 8000;
m = length(audio_data);
n = pow2(nextpow2(m));
y = fft(audio_data,n);
f = (0:n-1)*(fs*n);
power = y.*conj(y)/n;
plot(f,power)
title('Frequency vs. Power')
xlabel('Frequency (Hz)');
ylabel('power')
end
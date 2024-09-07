%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FMCW derive the impulse response - simulation
% Welcome to Beamforming world!
% BY ming30032332
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fs = 100000; 
t = 0:1/fs:50e-3;
f0 = 18e3; 
f1 = 22e3;
T = t(end);% stop time
B = f1 - f0; % freq 18k - 22k
t_tau = [t,(50e-3+1/fs:1/fs:100e-3)];

%%
x = cos(2 * pi * (f0 * t + (B / (2 * T)) * t.^2));
x = [x,zeros(1,5000)];
xx = cos(2 * pi * (f0 * t_tau + (B / (2 * T)) * t_tau.^2));
xx(1:5000) = 0;
figure;
subplot(2,1,1);
plot(t_tau,x);
subplot(2,1,2);
plot(t_tau,xx);

%%

%原始訊號
freq_bin1 = ((1:length(x))-1)/length(x)*fs;
power1 = abs(fft(x-mean(x)))/length(x).^2;

%觀察chirp頻譜
% figure;
% plot(freq_bin(1:round(end/2)),power(1:round(end/2)));
% xlabel("frequency");
% ylabel("amplitude");


Xf1 = fft(x);
phase = angle(Xf1);
phase = phase(1:floor(length(x)/2)+1);


figure;
subplot(2,1,1);
plot(freq_bin1(1:round(end/2)),power1(1:round(end/2)));
xlabel("frequency");
ylabel("amplitude");

subplot(2,1,2);
plot(freq_bin1(1:round(end/2)),phase);
%%

%delay訊號
freq_bin2 = ((1:length(xx))-1)/length(xx)*fs;
power2 = abs(fft(xx-mean(xx)))/length(xx).^2;

Xf2 = fft(xx);
phase = angle(Xf2);
phase = phase(1:floor(length(xx)/2)+1);

figure;
subplot(2,1,1);
plot(freq_bin2(1:round(end/2)),power2(1:round(end/2)));
xlabel("frequency");
ylabel("amplitude");

subplot(2,1,2);
plot(freq_bin2(1:round(end/2)),phase);

%%
amplitude = abs(Xf2); %後來的amplitude

%保留linear phase
linear_phase = Xf2/Xf1;

target_signal = amplitude.*linear_phase;
%%
x_phase_removed = real(ifft(target_signal));

figure;
subplot(2,1,1);
plot(t_tau,xx);

subplot(2,1,2);
plot(t_tau, x_phase_removed);


%%
asin(1*8.5/9.8)
asin(1*8.5/9.8)*180/pi
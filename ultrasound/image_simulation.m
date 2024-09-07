%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% beamforming result - simulation
% Welcome to Beamforming world!
% BY ming30032332
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% hyperparameter
fs = 12e5; % sample rate (Hz)
c = 340; % m/s
d = 9.8e-3; %element space(m)
f = 40e3; % Hz
scan_ang = 30:-1:-30; %degree
l = c/f;
emit_pos = [2*d,d,-d,-2*d]; %meter
t_end = 800e-3;
t = 0:1/fs:t_end;
T = 1/f; %period
target_angle = 25; %degree
target_pos = [35*cos(deg2rad(25));(35*cos(deg2rad(25)))*tan(deg2rad(target_angle))]; 
%target_position (x,y)
[b,a] = butter(2,1000/(fs/2),"low");

%each emitter to target distance
%[0,0] to target : 46.6717
% R1:46.6567(R-2dsin(theta)) R2:46.6642(R-dsin(theta))
% R3:46.6792(R+dsin(theta)) R4:46.6867(R+2dsin(theta))
emit2target_dis = sqrt((0-target_pos(1)).^2 + (emit_pos-target_pos(2)).^2);

start_idx = round(sqrt(target_pos(1)^2+target_pos(2)^2)/c*fs);
end_idx = start_idx+round(1*T*fs);

delay_sum_sig1 = zeros(length(scan_ang),length(t));
delay_sum_sig2 = zeros(length(scan_ang),length(t));

window_length = length(t);

tt = repmat(t,4,1);
origin_signal = sin(2*pi*f*(tt-(emit2target_dis/c)'.*ones(1,length(t))));

for i = 1:length(scan_ang)
    if (scan_ang(i)>0)
        time = (tt-(emit2target_dis/c)'.*ones(1,length(t))-(emit_pos.*sin(deg2rad(scan_ang(i)))/c)'.*ones(1,length(t)));
        sig = cos(2*pi*f*time);
    elseif (scan_ang(i)<0)
        time = (tt-(emit2target_dis/c)'.*ones(1,length(t))-(emit_pos.*sin(deg2rad(scan_ang(i)))/c)'.*ones(1,length(t)));
        sig = cos(2*pi*f*time);
    else
        time = (tt-(emit2target_dis/c)'.*ones(1,length(t)));
        sig = cos(2*pi*f*time);
    end
    total_sig_de = filter(b,a,abs(sum(sig)));
    total_sig_org = abs(sum(sig));
    delay_sum_sig1(i,:) = total_sig_org.*masking(total_sig_org,start_idx,end_idx);
    delay_sum_sig2(i,:) = total_sig_de.*masking(total_sig_de,start_idx,end_idx);
end

figure;
imagesc(t.*340,scan_ang,(delay_sum_sig1));
yticks(-30:5:30);
title(sprintf("steering %.f degree(origin)",target_angle));
xlabel("Distance(cm)");
ylabel("Angle(degree)");
xlim([34,36]);
axis xy;

figure;
imagesc(t.*340,scan_ang,(delay_sum_sig2));
yticks(-30:5:30);
title(sprintf("steering %.f degree(demodulation)",target_angle));
xlabel("Distance(cm)");
ylabel("Angle(degree)");
xlim([30,31]);
% axis xy;
% view([0,90]);

%%

function mask1 = masking(sig,starting,ending)
mask1 = zeros(1,length(sig));
mask1(starting:ending) = 1;
end
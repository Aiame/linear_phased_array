%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% beam width - simulation
% Welcome to Beamforming world!
% BY ming30032332
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Input Parameters
N = 4;
d = 9.8;
lambda = 8.5;
theta = -30:1:30;
 
%% Calculate Beamwidths
theta_B = 0.886*lambda./(N*d*cosd(theta));
%% Plot
figure;
plot(theta,theta_B*180/pi,'linewidth',1.5);
grid
xlabel('Scan Angle (Degrees)','fontsize',12,'fontweight','b');
ylabel('Beamwidth (degrees)','fontsize',12,'fontweight','b');
axis xy;
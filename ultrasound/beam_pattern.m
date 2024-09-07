%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% beam steering - simulation
% Welcome to Beamforming world!
% BY ming30032332
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Parameters
v = 340;            % Speed of sound (m/s)
f = 40e3;           % Frequency (Hz)
lambda = v / f;     % Wavelength (m)
theta_target = -25:1:25;   % Target angle (degrees)
theta_scan = -60:0.1:60; % Scanning angles (degrees)
N = 4;              % Number of emitters

% Array of different d values
d = [1.152 * lambda];

% Initialize figure
figure;
% hold on;
videoFile = VideoWriter('array_factor_video', 'MPEG-4');
videoFile.FrameRate = 10;  % Adjust the frame rate as needed
open(videoFile);  % Open the video file for writing
% Loop through different d values
for d_idx = 1:length(theta_target)
    theta_1 = theta_target(d_idx);
    phase_shift_target = 2 * pi * f * (d * sind(theta_1) / v);
    I = zeros(size(theta_scan));
    
    for idx = 1:length(theta_scan)
        theta = theta_scan(idx);
        phase_shift = 2 * pi * f * (d * sind(theta) / v);
        array_factor = sum(exp(1i * ((0:N-1)' * phase_shift_target - (0:N-1)' * phase_shift)));
        I(idx) = abs(array_factor)^2;
    end
    
    % Normalize the array factor and convert to dB scale
    I_dB = 10*log10(I / max(I));
    
    % Plot the results
    plot(theta_scan, I_dB, 'LineWidth', 1.6, 'DisplayName', sprintf('d = %.3f \\lambda', d / lambda));
    % hold on;
    hold on;
    
    % Mark the main lobe position with a vertical line and a marker
    plot([theta_1 theta_1], [-40 0], 'r--', 'LineWidth', 1.2);  % Red dashed line at main lobe position
    plot(theta_1, 0, 'ro', 'MarkerSize', 8, 'LineWidth', 1.5);  % Red circle at the peak (main lobe)
    
    % Formatting the plot
    xlabel('Angle (\circ)');
    ylabel('Amplitude (dB)');
    legend(sprintf('%.0f°', theta_1), 'FontSize', 8);
    grid on;
    ylim([-40 0]);  % Adjusting the y-axis limit to match the example
    xlim([-60 60]); % Adjusting the x-axis limit to match the example
    title('Array Factor at -18 degree and 18 degree');
    
    % Capture the current frame and write it to the video file
    frame = getframe(gcf);
    writeVideo(videoFile, frame);
    
    hold off;  % Clear the figure for the next frame

end
close(videoFile);

disp('Video saved successfully.');

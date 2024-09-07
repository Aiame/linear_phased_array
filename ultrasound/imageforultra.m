%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% reconstruction of the object image(no deconvolution) - real data
% Welcome to Beamforming world!
% BY ming30032332
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% pipeline = [(load_data),(processline),(plot_result)]
data1 = load_data("C:\Users\User\Desktop\meeting\ttt.txt");
% [result,X,Y] = make_interp(data1);

%%
videoFileName = 'ttt.mp4';
[a, b] = make_interp(data1, videoFileName);

%%
function plot_result(re,X,Y,type)
if(type == "3D")
    figure;
    surf(X, Y.*0.017, result);
    xlabel('Angle (degrees)');
    ylabel('Distance(cm)');
    zlabel('Value');
    yticks([0:5:60]);
    title('Interpolated Data');
    shading interp;
    colorbar;
    axis xy;
    view(90,90);
    ylim([10,60]);
else
    figure;
    imagesc(X(1,:), Y(:,1).*0.017, result);
    xlabel('Angle (degrees)');
    ylabel('Distance(cm)');
    zlabel('Value');
    yticks([0:5:60]);
    title('Interpolated Data');
    shading interp;
    colorbar;
    axis xy;
    view(90,90);
    ylim([5,60]);
end
end

% function [a,b]= make_interp(data1)
% current_idx = 1;
% while(current_idx < length(data1(1,:)))
%     % next_idx = current_idx+19;
%     next_idx = min(current_idx + 19, length(data1(1,:)));
%     if next_idx == length(data1(1,:))
%         break;
%     end
%     ip = data1(:,current_idx:next_idx-1);
%     [result,X,Y,a,b] = processline(ip);
% 
%     figure;
%     h = surf(X, Y.*0.017, result);
%     xlabel('Angle (degrees)');
%     ylabel('Distance(cm)');
%     zlabel('Value');
%     yticks([0:5:60]);
%     title('Interpolated Data');
%     shading interp;
%     colorbar;
%     axis xy;
%     view(90,90);
%     ylim([10,60]);
% 
%     set(h, 'XData', X, 'YData', Y .* 0.017, 'ZData', result);
%     pause(1);
% 
%     current_idx = current_idx+19;
% end
% end
% 
% function [result,X,Y,a,b] = processline(data)
% 
% %更多角度
% degree = [-38.65,-31.36,-24.6,-18.2,-16.11,-12.015,-7.977,-5.974,-3.979,0,3.979,5.974,7.977,12.015,16.12,18.2,24.6,31.36,38.65];
% % degree = repmat(degree,280,1);
% %取出各角度的距離
% temp_dis = data(1:2:100,:);
% temp_dis(1,1:end) = 100;
% temp_dis(end,1:end) = 5700;
% distance_for_eachang = temp_dis;
% a = temp_dis;
% 
% %取出各角度的Value
% value_for_eachang = data(2:2:end-1,:);
% b = value_for_eachang;
% %準備內插點
% % 設定 x 和 y 軸的範圍
% x_min = -38.65;
% x_max = 38.65;
% y_min = 100;
% y_max = 5700;
% 
% % 設定內插點的數量
% x_points = 1200; % x 軸內插點數量
% y_points = 4000; % y 軸內插點數量
% 
% % 用 linspace 生成 x 軸和 y 軸的點
% x = linspace(x_min, x_max, x_points);
% y = linspace(y_min, y_max, y_points);
% 
% % 用 meshgrid 生成內插點
% [X, Y] = meshgrid(x, y);
% 
% % 準備好 x, y 的座標網格
% [x_cor, y_cor] = meshgrid(degree, temp_dis(:,1));
% 
% % 使用 interp2 進行內插
% result = interp2(x_cor, y_cor, value_for_eachang, X, Y, 'spline');
% 
% end
% function [a, b] = make_interp(data1)
%     % Define constants
%     degree = [-38.65, -31.36, -24.6, -18.2, -16.11, -12.015, -7.977, -5.974, -3.979, 0, 3.979, 5.974, 7.977, 12.015, 16.12, 18.2, 24.6, 31.36, 38.65];
%     x_min = min(degree);
%     x_max = max(degree);
%     y_min = 100;
%     y_max = 5700;
% 
%     % Set interpolation grid once
%     x_points = 1200;
%     y_points = 4000;
%     [X, Y] = meshgrid(linspace(x_min, x_max, x_points), linspace(y_min, y_max, y_points));
% 
%     % Initialize plot outside the loop
%     figure;
%     h = surf(X, Y .* 0.017, zeros(size(X)));
%     xlabel('Angle (degrees)');
%     ylabel('Distance (cm)');
%     zlabel('Value');
%     yticks(0:5:60);
%     title('Interpolated Data');
%     shading interp;
%     colorbar;
%     axis xy;
%     view(90, 90);
%     ylim([10, 60]);
% 
%     current_idx = 1;
%     while current_idx < length(data1(1, :))
%         % Determine next index
%         next_idx = min(current_idx + 19, length(data1(1, :)));
%         if next_idx == length(data1(1, :))
%             break;
%         end
% 
%         % Extract data segment
%         ip = data1(:, current_idx:next_idx - 1);
% 
%         % Process the data
%         [result, a, b] = processline(ip, degree, X, Y);
% 
%         % Update plot
%         set(h, 'ZData', result);
%         pause(1);
% 
%         % Move to the next segment
%         current_idx = next_idx;
%     end
% end
% 
function [result, a, b] = processline(data, degree, X, Y)
    % Extract distances and values
    temp_dis = data(1:2:100, :);
    temp_dis(1, :) = 100;
    temp_dis(end, :) = 5700;
    distance_for_eachang = temp_dis;
    a = temp_dis;

    value_for_eachang = data(2:2:end-1, :);
    b = value_for_eachang;

    % Perform interpolation
    [x_cor, y_cor] = meshgrid(degree, temp_dis(:, 1));
    result = interp2(x_cor, y_cor, value_for_eachang, X, Y, 'spline');
end
function [a, b] = make_interp(data1, videoFileName)
    % Define constants
    degree = [-38.65, -31.36, -24.6, -18.2, -16.11, -12.015, -7.977, -5.974, -3.979, 0, 3.979, 5.974, 7.977, 12.015, 16.12, 18.2, 24.6, 31.36, 38.65];
    degree = degree.*-1;
    x_min = min(degree);
    x_max = max(degree);
    y_min = 0;
    y_max = 5600;
    
    % Set interpolation grid once
    x_points = 1200;
    y_points = 4000;
    [X, Y] = meshgrid(linspace(x_min, x_max, x_points), linspace(y_min, y_max, y_points));
    
    % Initialize plot outside the loop
    figure;
    h = surf(X, Y .* 0.017, zeros(size(X)));
    xlabel('Angle (degrees)');
    ylabel('Distance (cm)');
    zlabel('Value');
    yticks(0:5:60);
    title('Interpolated Data');
    shading interp;
    colorbar;
    axis xy;
    view(90, 90);
    ylim([10, 60]);
    
    % Initialize VideoWriter
    v = VideoWriter(videoFileName, 'MPEG-4');
    v.FrameRate = 1; % Set frame rate to 1 frame per second (adjust as needed)
    open(v);

    current_idx = 1;
    while current_idx < length(data1(1, :))
        % Determine next index
        next_idx = min(current_idx + 19, length(data1(1, :)));
        if next_idx == length(data1(1, :))
            break;
        end
        
        % Extract data segment
        ip = data1(:, current_idx:next_idx - 1);
        
        % Process the data
        [result, a, b] = processline(ip, degree, X, Y);

        % Update plot
        set(h, 'ZData', result);
        drawnow;
        
        % Capture the current frame and write it to the video
        frame = getframe(gcf);
        writeVideo(v, frame);
        
        % Move to the next segment
        current_idx = next_idx;
    end

    % Close the video file
    close(v);
end




%想辦法改掉for,  還有改掉不滿足19欄的欄位
function result = load_data(filepath)
gg = textread(filepath,"%s");
a = split(gg,",");
b = cell2table(a);
c = unique(b,"rows","stable");
d = table2array(c);
result = [];
for i = 1:length(d(:,1))
    temp_data = d(i,:);
    for j = 1:101
        result(i,j) = str2num(cell2mat(temp_data(j)));
    end
end
result = result';
end

function cal_dis(data)
data1 = data;
dis = [];
pks = [];
distance = data1(:,1:280);
val = data1(:,281:end-2);
mode = data1(:,end);
vald = diff(val);
vald2 = diff(vald);

figure;
plot(val);
hold on;
plot(vald);
hold on;
plot(vald2);
legend("d0","d1","d2");
[pks2,loc2] = findpeaks(vald2,"MinPeakHeight",50);
% findpeaks(vald2,"MinPeakHeight",50);
target_loc = loc2(end);
target_val = val(target_loc);
target_dis = distance(target_loc);
disp("distance is " + target_dis*0.017 + " cm");
end




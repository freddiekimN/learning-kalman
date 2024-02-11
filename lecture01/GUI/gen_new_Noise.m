function [rotated_noise_point_array] = gen_new_Noise(x, y, width, length,target_yaw,host_yaw,noise_amplitude,num)

    rotated_noise_point_array = zeros(2,num);

    % 회전 각도 (yaw값, 시계 방향이 양의 방향)
    rotation_matrix = [cos(host_yaw), -sin(host_yaw); sin(host_yaw), cos(host_yaw)];
    for i = 1 : num
        % 노이즈 추가를 위한 점 선택
        if abs(target_yaw-host_yaw) < pi/4
            noise_point = [(noise_amplitude*(width*rand()-width/2)) ,(rand() * length) - (length/2)];                           
        else
            noise_point = [((rand() * width) - (width/2)), (-length/2) + (noise_amplitude*(length*rand()-length/2))]; 
        end

        rotated_noise_point = rotation_matrix * noise_point';

        % 노이즈 추가된 점을 평행이동으로 위치 설정
        rotated_noise_point_array(:,i) = rotated_noise_point + [x; y];    
    end
end

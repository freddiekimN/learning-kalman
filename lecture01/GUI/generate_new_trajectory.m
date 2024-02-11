function [target_info,host_info,simulation_info] = generate_new_trajectory(target_info,host_info,simulation_info)

    % simulation info
    host_target_offset_y = simulation_info.host_target_offset.y;
    target_pt_num = simulation_info.target_pt_num;
    target_noise_amplitude = simulation_info.target_noise_amplitude;
    host_trajectory_R_m = simulation_info.host_trajectory_R_m;
    host_total_distance_m = simulation_info.host_total_distance_m;
    target_total_distance_m = simulation_info.target_total_distance_m;
    road_R = simulation_info.road_R;
    time_interval = simulation_info.time_interval;
    initial_time = simulation_info.initial_time;
    total_time = simulation_info.total_time;
    host_car_history = simulation_info.host_car_history;
    target_history = simulation_info.target_history;

    % target car info.
    target_position = target_info.position;
    target_yaw = target_info.yaw;
    target_speed = target_info.speed;
    target_acc_g = target_info.acc_g;
    target_length = target_info.length;
    target_width = target_info.width;
    
    % host car info.
    host_position = host_info.position;
    host_yaw = host_info.yaw;
    host_speed = host_info.speed;
    host_acc_g = host_info.acc_g;
  
    % 시간 및 간격 설정
    time_steps = initial_time:time_interval:(initial_time+total_time);

    % 예상 트라젝토리 크기 계산
    estimated_size = length(time_steps);

    % position_history 배열 크기 늘리기
    if isempty(target_history)
        current_size = 1;
        total_size = estimated_size;
        target_history = zeros(estimated_size, 10);
        host_car_history = zeros(estimated_size, 5);
    else
        current_size = size(target_history, 1)+1;
        total_size = current_size + estimated_size - 1;
        target_history = [target_history; zeros(estimated_size, 10)];
        host_car_history = [host_car_history; zeros(estimated_size, 5)];
    end
    
    % 차량의 트라젝토리 계산
    target_vs = target_speed;
    host_vs = host_speed;
    R = road_R;
    for i = current_size:total_size
        % target info
        target_vs = target_vs + target_acc_g*time_interval;
        if target_vs < 0
            target_vs = 0;
        end
        target_yaw_rate = target_vs/R;
        target_yaw = target_yaw + target_yaw_rate * time_interval;
        
        % 차량의 위치 및 각도 업데이트
        target_position = target_position + target_vs * [cos(target_yaw); sin(target_yaw)] * time_interval;
        target_total_distance_m = target_total_distance_m + target_vs*time_interval;
        % host_trajectory_R_m 업데이트
        host_trajectory_R_m(ceil(target_total_distance_m),1) = R; 
        for i2 = 1:length(host_trajectory_R_m)
           if host_trajectory_R_m(i2,1) == 0
              host_trajectory_R_m(i2,1) = R;
           end
        end

        
        % host
        host_vs = host_vs + host_acc_g*time_interval;
        if host_vs < 0
            host_vs = 0;
        end                
        host_R = host_trajectory_R_m(floor(host_total_distance_m)+1,1) - host_target_offset_y;     
        host_yaw_rate = host_vs/host_R;
        host_yaw = host_yaw + host_yaw_rate * time_interval;
        host_position = host_position + host_vs * [cos(host_yaw); sin(host_yaw)] * time_interval;
        host_total_distance_m = host_total_distance_m + host_vs*time_interval;

        [rotated_noise_point] = gen_new_Noise(target_position(1), target_position(2), target_width, target_length,target_yaw,host_yaw,target_noise_amplitude,target_pt_num);
%         [rotated_noise_point] = genNoise(position(1), position(2), target_width_noise, target_length_noise,dif_heading,yaw_host,target_noise_amplitude,target_pt_num);
        % 트라젝토리 기록
%         host_yaw = -(host_heading-(pi/2));
%         rotation_matrix = [cos(host_yaw), -sin(host_yaw); sin(host_yaw), cos(host_yaw)];
        target_history(i, 1) = target_vs;
        target_history(i, 2) = target_yaw;
        target_history(i, 3) = target_yaw_rate;
        target_history(i, 4:5) = target_position;
        target_history(i, 6:7) = rotated_noise_point;
%         rotation_matrix*(rotated_noise_point-host_position);
        
        host_car_history(i,1) = host_vs;
        host_car_history(i,2) = host_yaw;
        host_car_history(i,3) = host_yaw_rate;
        host_car_history(i,4:5) = host_position;
    end
    
    final_time = initial_time+total_time;

    
    % save target info
    target_info.speed = target_vs;
    target_info.yaw = target_yaw;
    target_info.position = target_position;
    
    % save host car info
    host_info.speed = host_vs;
    host_info.yaw = host_yaw;    
    host_info.position = host_position;
    
    % save simulation info
    simulation_info.target_history=target_history;
    simulation_info.host_car_history=host_car_history;
    simulation_info.final_time=final_time;
    simulation_info.initial_time = final_time;
    simulation_info.host_trajectory_R_m=host_trajectory_R_m;
    simulation_info.host_total_distance_m=host_total_distance_m;
    simulation_info.target_total_distance_m=target_total_distance_m;
    
    
   
end

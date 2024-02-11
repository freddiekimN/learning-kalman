function [target_info,host_info,simulation_info] = gen_new_trajectory(simulation_info)
    
    %%% 시뮬레이션 정보
    g = 9.8; % m/s
    simulation_info.start_offset = 20;
    simulation_info.target_pt_num = 1;
    simulation_info.target_noise_amplitude = 0.25;
    simulation_info.host_target_offset.x = 5;
    simulation_info.host_target_offset.y = 0;
    simulation_info.host_trajectory_R_m = 32000*ones(simulation_info.start_offset,1);
    simulation_info.host_total_distance_m = 0;
    simulation_info.target_total_distance_m = sqrt(simulation_info.host_target_offset.x*simulation_info.host_target_offset.x + simulation_info.host_target_offset.y*simulation_info.host_target_offset.y);
    simulation_info.road_R = 32000;
    simulation_info.time_interval = 0.05;
    simulation_info.total_time = 6; % total_time;
    simulation_info.initial_time = 0; % initial_time;    
    simulation_info.host_car_history = [];
    simulation_info.target_history = [];
    
    %%% host car 정보
    host_info.position = [0; -1.75];
    host_info.yaw = 0/180*pi;
    host_info.speed = 0;
    host_info.acc_g = 0.3*g;
    
    %%% 타겟 정보
    target_info.position(1,1) = simulation_info.host_target_offset.x + host_info.position(1,1);
    target_info.position(2,1) = simulation_info.host_target_offset.y + host_info.position(2,1);
    target_info.yaw = 0/180*pi;
    target_info.speed = 0;
    target_info.acc_g = 0.3*g;
    target_info.length = 4;
    target_info.width = 2;
    
    [target_info,host_info,simulation_info] = generate_new_trajectory(target_info,host_info,simulation_info);

    %% 곡선 구간 진입
    simulation_info.road_R = 30;
    simulation_info.total_time = 2.5;
    target_info.acc_g = 0;
    host_info.acc_g = 0;
    
    [target_info,host_info,simulation_info] = generate_new_trajectory(target_info,host_info,simulation_info);
    
    
    simulation_info.road_R = -30;
    simulation_info.total_time = 2.5;
    target_info.acc_g = 0;
    host_info.acc_g = 0;
    
    [target_info,host_info,simulation_info] = generate_new_trajectory(target_info,host_info,simulation_info);    
    
    %% 다시 직선 구간 진입
    simulation_info.road_R = 32000;
    simulation_info.total_time = 2;
    target_info.acc_g = -3*g;
    host_info.acc_g = -3*g;
    
    [target_info,host_info,simulation_info] = generate_new_trajectory(target_info,host_info,simulation_info);     
    
end
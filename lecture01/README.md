# 목적 : 간단한 Kalman filter 실습

## 차량의 주행을 구현하기위해서는 많은 것을 고려해야하지만 가장 간단하게 구현함.

## Observer : 0.0 지점에서 타겟을 본다고 가정했을때 얼마나 필터의 성능이 좋은지 확인함.

## Target : 타겟크기는 width 2m, length 4m로 가정하고 gussian noise를 추가해서 구현함.

처음 trajectory를 그릴때 어떤 정보가 필요할까?

### simulation info
- g = 9.8; % m/s
- start_offset = 20;
- target_pt_num = 1;
- target_noise_amplitude = 0.25;
- host_target_offset.x = 5;
- host_target_offset.y = 0;
- host_trajectory_R_m = 32000*ones(20,1);
- host_total_distance_m = 0;
- target_total_distance_m =
- road_R = 32000;
- time_interval = 0.05;
- total_time = 6; % total_time;
- initial_time = 0; % initial_time;    
- host_car_history = [];
- target_history = [];

### host car 정보
- position = 
- yaw = 0/180*pi;
- speed = 0;
- acc_g = 1*g;

### 타겟 정보
- position 
- yaw = 0/180*pi;
- speed = 0;
- acc_g = 1*g;
- length = 4;
- width = 2;

### scenario 1 trajectory complete
- Measurement information was generated from the observer's point of view (0.0).
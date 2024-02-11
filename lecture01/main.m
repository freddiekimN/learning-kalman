% add path
addpath(genpath('./MODEL'));
addpath(genpath('./GUI'));

[target_info,host_info,simulation_info] = gen_new_trajectory();
figure(1)
cla
subplot(6,2,[1 3 5 7 9 11])
ax = gca;
gt_position_history = simulation_info.target_history(:,4:5);
draw_gt_trajectory(ax,gt_position_history)
measure_position_history = simulation_info.target_history(:,6:7);
draw_gt_points(ax,measure_position_history)


[n_row,n_col] = size(gt_position_history);
n_offset = simulation_info.start_offset;
dt = simulation_info.time_interval;
for i = n_offset : n_row
    j = i - n_offset + 1;
    
    xm = measure_position_history(i,1);
    ym = measure_position_history(i,2);    
    
    gt_x(j,1) = gt_position_history(i, 1);
    gt_y(j,1) = gt_position_history(i, 2);
    gt_Vx(j,1) = (gt_position_history(i, 1) - gt_position_history(i-1, 1))/dt*3.6;
    gt_Vy(j,1) = (gt_position_history(i, 2) - gt_position_history(i-1, 2))/dt*3.6;    
    
end

index_array = 1:length(gt_Vx);

ax = subplot(6,2,2);
x_axis_info = index_array;
x_axis_txt = 'index';
y_axis_txt = 'Vx(km/h)';
error_array = gt_Vx;
err_num = 1;
legend_txt = 'Vx(gt)';
title_txt = 'x-velocity ';
plot_error(ax,x_axis_info,x_axis_txt,error_array,err_num,y_axis_txt,legend_txt,title_txt)

ax = subplot(6,2,4);
x_axis_info = index_array;
x_axis_txt = 'index';
y_axis_txt = 'Vy(km/h)';
error_array = gt_Vy;
err_num = 1;
legend_txt = 'Vy(gt)';
title_txt = 'y-velocity ';
plot_error(ax,x_axis_info,x_axis_txt,error_array,err_num,y_axis_txt,legend_txt,title_txt)

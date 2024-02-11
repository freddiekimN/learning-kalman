function draw_gt_trajectory(ax,position_history)
    hold on;
    plot(ax,position_history(:, 2), position_history(:, 1), 'k--')
    ax.XDir = 'reverse';
    xlabel('Y (m)')
    ylabel('X (m)')    
    title('Vehicle Trajectory');
    axis equal;
    grid on;
end
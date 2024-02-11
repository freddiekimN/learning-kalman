function draw_gt_points(ax,position_history)
    hold on;
    plot(ax,position_history(:, 2), position_history(:, 1), 'bx');  % 트라젝토리를 파란색 선으로 표시
    ax.XDir = 'reverse';
    xlabel('Y (m)')
    ylabel('X (m)')    
    title('Vehicle Trajectory');
    axis equal;
    grid on;
end
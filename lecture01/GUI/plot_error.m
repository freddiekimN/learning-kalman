function plot_error(ax,x_axis_info,x_axis_txt,error_array,err_num,y_axis_txt,legend_txt,title_txt)

    color_basic = {'k','r','b','c','m','y'};

    for i = 1 : err_num
        plot(ax,x_axis_info,error_array(:,i),color_basic{i});  
    end
    xlabel(ax,x_axis_txt);
    ylabel(ax,y_axis_txt);
    xlim([min(x_axis_info) max(x_axis_info)]);
    grid on;
    legend(ax,legend_txt);
    title(ax,title_txt);
end
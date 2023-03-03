function plot_path_phase(num_line,x,y)

fig = figure;
fig.Color = 'w';
ax = axes('Parent', fig);
hold(ax, 'on')

for i=1:num_line
    plot(x,y(:,i),'LineWidth', 2, 'DisplayName',['\angleS',num2str(i*2),num2str(i*2-1),' (Line ', num2str(i),')']);
end

YTickLength = 10;
xlabel(ax, 'frequency (GHz)')
ylabel(ax, 'phase (\circ)')
grid(ax, 'on')
legend(ax, 'show', 'Location','NorthEast')
title(ax, ['Phase of Line'],'FontWeight','Normal')

end
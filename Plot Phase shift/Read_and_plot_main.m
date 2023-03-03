%%
% read CSV/TXT to plot

%%
clear
clc
tic % record time
disp('Retrieving data...'); % display

%% Read

num_line=5; % number of lines
N = 1001; % number of points of each line

for i =1:num_line
    str="D:\Simulation\DataExport\2022.10.10\S21_deg_"+i+".txt";
    z{i} = str; % read 0,lag 45,lag 90 degree % read 0,lag 135,lag 180 degree
end
for i =1:num_line
    T{:,i} = readtable(z{i});
end

for i=1:num_line % cell table to table
    for j=1:2
        T1(:,2*i-1+j-1)=T{1,i}(:,j);
    end
end 

T1=T1{:,:}; % convert table to matrix

i=1;j=1;
while i <= N % extract x axis
    x1(i)=T1(i,j);
    i=i+1;
end

for j=1:num_line % extract y axis
    i=1;
    while i <= N
        y1(i,j)=T1(i,j*2);
        i=i+1;
    end 
end

%% plot lines' phase

plot_path_phase(num_line,x1,y1); % plot phase of line

%% plot phase diffrence of lines

num_line_base=1; % line to be substract

for j=1:num_line % phase difference
    i=1;
    while i <= N
        pha_dif(i,j)=y1(i,j)-y1(i,num_line_base); % y(i,num_line)& y(i,num_line_base)
        i=i+1;
    end 
end

for j=1:num_line
    for i=1:N
        if pha_dif(i,j)<0 
            pha_dif(i,j)=pha_dif(i,j)+360;
        elseif pha_dif(i,j)>360
            pha_dif(i,j)=pha_dif(i,j)-360;
        end
    end
end

fig = figure;
fig.Color = 'w';
ax = axes('Parent', fig);
hold(ax, 'on')

% pha_dif(:,4)=pha_dif(:,4)-40;
% 
% plot(x1,pha_dif(:,4),'LineWidth', 2, 'DisplayName',['\angleS',num2str(2*2),...
%     num2str(2*2-1),' -\angleS',num2str(num_line_base*2),num2str(num_line_base*2-1)]);

for j=1:num_line % phase difference
        plot(x1,pha_dif(:,j),'LineWidth', 2, 'DisplayName',['\angleS',num2str((j)*2),...
            num2str((j)*2-1),' -\angleS',num2str(num_line_base*2),num2str(num_line_base*2-1)]);
        j=j+1;
end

% axis([28 40 -220 -130])
YTickLength = 10;
xlabel(ax, 'frequency (GHz)')
ylabel(ax, 'phase difference (\circ)')
grid(ax, 'on')
legend(ax, 'show', 'Location','NorthEast')
title(ax, ['Phase Shift'],'FontWeight','Normal')
% line(ax, [30 30], ax.YLim, 'LineWidth', 1, 'Color', 'r', 'LineStyle','--');

toc


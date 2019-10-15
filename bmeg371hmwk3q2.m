%adapting mesh conditions from q1
h=0.1;
k=0.001;
mesh_step = 1/h;

%Initial BCs
Grid=zeros([1,mesh_step+1]); %creating a matrix that reflects a tube of uniform concentration 1
for point= 1 : 1 : length(Grid)
    Grid(point)=1;
end

Grid_forward = Grid;
Grid_initial = Grid;

for time=0:k:10
    
    for point= 2 : 1 : length(Grid) - 1
        Grid_forward(point) = Grid(point) + ((k/(h^2))*(Grid(point+1) - 2* Grid(point)+ Grid(point-1))) + k * (1+sin(time));
    end
    Grid= Grid_forward;
    
    if time==0.01
        A_point_zero_one = Grid;
    elseif time==0.03
        A_point_zero_three = Grid;
    elseif time == 0.06
        A_point_zero_six = Grid;
    elseif time == 1.00
        A_one = Grid;
    elseif time == 10.00
        A_ten = Grid;
    end
end

plot(0:h:1,Grid_initial, 0:h:1,A_point_zero_one, 0:h:1,A_point_zero_three, 0:h:1,A_point_zero_six, 0:h:1,A_one, 0:h:1,A_ten)
xlabel(' x ') 
ylabel('Concentration') 
title('Concentration vs x')
legend({'time = 0','time = 0.01','time = 0.03', 'time = 0.06', 'time = 1.0', 'time=10'},'Location','northeast')
axis([0 1 0.9 1.3])
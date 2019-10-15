%mesh points and time steps
h=0.1;
k=0.001;
mesh_step = 1/h;

%BCs
Grid = zeros([1,mesh_step+1]);
point = 2;
for x=0+h:h:1-h
    Grid(point)=x*(1-x);
    point = point+1;
end

Grid_forward= Grid;
Grid_intitial = Grid;

for time=0:k:1
    for point=2:1:length(Grid)-1
        Grid_forward(point) = Grid(point) + ((k/(h^2))*(Grid(point+1) - 2* Grid(point)+ Grid(point-1)));
    end
    
    Grid = Grid_forward;
    if time==0.05
        Grid_point_zero_five = Grid;
    elseif time==0.1
        Grid_point_one = Grid;
    elseif time == 0.2
        Grid_point_two = Grid;
    elseif time == 1.00
        Grid_final = Grid;
    end
end

plot(0:h:1,Grid_intitial, 0:h:1,Grid_point_zero_five, 0:h:1,Grid_point_one, 0:h:1,Grid_point_two, 0:h:1,Grid_final)
xlabel('0 < x < 1') 
ylabel('Concentration') 
title('Concentration vs x')
legend({'time = 0','time = 0.05','time = 0.1', 'time = 0.2', 'time = 1.0'},'Location','northwest')
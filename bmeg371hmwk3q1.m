%mesh points and time steps
h=0.1;
k=0.001;
mesh_step = 1/h;

%BCs
Grid = zeros([1,mesh_step+1]); %1 by 11 matrix of zeros
point = 2;
for x= 0+h : h : 1-h %creating initial condition concentration curve 
    Grid(point)=x*(1-x);
    point = point+1;
end

%starting numerical approximation 
Grid_forward= Grid;
Grid_intitial = Grid;

for time=0:k:1
    
    for point=2:1:length(Grid)-1
        Grid_forward(point) = Grid(point) + (k/(h^2))*(Grid(point-1) - 2* Grid(point) + Grid(point+1));
    end
    
    Grid = Grid_forward;
    
    %saving the concentration profile at these times to graph later
    if time==0.05
        time_point_zero_five = Grid;
    elseif time==0.1
        time_point_one = Grid;
    elseif time == 0.2
        time_point_two = Grid;
    elseif time == 1.00
        time_final = Grid;
    end
end

plot(0:h:1,Grid_intitial, 0:h:1,time_point_zero_five, 0:h:1,time_point_one, 0:h:1,time_point_two, 0:h:1,time_final)
xlabel('x') 
ylabel('Concentration') 
title('Concentration vs x')
legend({'time = 0','time = 0.05','time = 0.1', 'time = 0.2', 'time = 1.0'},'Location','northeast')

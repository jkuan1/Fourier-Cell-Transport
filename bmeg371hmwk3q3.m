%mesh conditions
h=0.2;
k=0.001;
mesh_step = (1/h)+1;

%Initial BCs with the assumption that phi(x=1, y=1) = 1 (contridiction in the homework)
Grid=zeros([mesh_step,mesh_step]);
for y_axis=(mesh_step/2)+1:1:mesh_step
    Grid(mesh_step, y_axis)=1;    
end

Grid_initial=Grid;
Grid_Fourier=Grid;

% Gauss-Seidel with seven sweeps over the grid
for i=1:1:7
    for y_axis=2:1:mesh_step-1
        for x_axis=2:1:mesh_step-1
            Grid(x_axis, y_axis) = (1/4)*(Grid(x_axis,y_axis-1)+Grid(x_axis-1,y_axis)+Grid(x_axis+1,y_axis)+Grid(x_axis,y_axis+1));
        end
    end
end

% Fourier Series Calculation
for y=0+h:h:1-h
    for x=0+h:h:1-h
        sum = 0;
        for n=1:1:20
            sum = sum + ((2*(cos(n*pi/2)+(-1)^(n+1)))/(n*pi*sinh(n*pi))*sin(n*pi*y)*sinh(n*pi*x));
        end
        Grid_Fourier(x/h + 1,y/h + 1) = sum;
    end
end

% Difference between Fourier and Numerical

Grid_diff = Grid_Fourier - Grid;

%Plots

figure(1)
contour(Grid)
xticks([1 2 3 4 5 6 7 8 9 10])
xticklabels({'0', '0.1', '0.2', '0.3','0.4', '0.5', '0.6', '0.7', '0.8', '0.9' , '1'})
yticks([1 2 3 4 5 6])
yticklabels({'0','0.2','0.4','0.6','0.8','1'})
xlabel('Y') 
ylabel('X') 
zlabel('Concentration')
title('Gauss-Seidel Solution')

figure(2)
contour(Grid_Fourier)
xticks([1 2 3 4 5 6])
xticklabels({'0','0.2','0.4','0.6','0.8','1'})
yticks([1 2 3 4 5 6])
yticklabels({'0','0.2','0.4','0.6','0.8','1'})
xlabel('Y') 
ylabel('X') 
zlabel('Concentration')
title('Fourier Series Solution')

figure(3)
contour(Grid_diff)
xticks([1 2 3 4 5 6])
xticklabels({'0','0.2','0.4','0.6','0.8','1'})
yticks([1 2 3 4 5 6])
yticklabels({'0','0.2','0.4','0.6','0.8','1'})
xlabel('Y') 
ylabel('X') 
zlabel('Concentration')
title('Difference between GS and Fourier')
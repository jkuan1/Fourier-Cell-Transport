%mesh conditions
h=0.2;
k=0.001;
mesh_step = (1/h)+1;

%Initial BCs
Grid=zeros([mesh_step,mesh_step]);
for y_point=(mesh_step/2)+1:1:mesh_step
    Grid(mesh_step, y_point)=1;    
end

A_new =Grid;
A_initial=Grid;
A_Fourier=Grid;
A_diff = Grid;

%%
% GS Numerical Solution
for i=1:1:7
    for y_point=2:1:mesh_step-1
        for xpoint=2:1:mesh_step-1
            Grid(xpoint, y_point) = (1/4)*(Grid(xpoint-1,y_point)+Grid(xpoint+1,y_point)+Grid(xpoint,y_point-1)+Grid(xpoint,y_point+1));
        end
    end
end



%%
% Fourier Series Calculation
for y=0+h:h:1-h
    for x=0+h:h:1-h
        sum=0;
        for n=1:1:20
            sum = sum + ((2*(cos(n*pi/2)+(-1)^(n+1)))/(n*pi*sinh(n*pi))*sin(n*pi*y)*sinh(n*pi*x));
        end
        A_Fourier(x/h+1,y/h+1)=sum;
    end
end

%%
% Difference between Fourier and Numerical

for y_point=1:1:mesh_step
    for xpoint=1:1:mesh_step
        A_diff(xpoint, y_point) = Grid(xpoint, y_point)-A_Fourier(xpoint, y_point);
    end
end

%%
%PLOTS

% surf(A)
% xticks([1 2 3 4 5 6])
% xticklabels({'0','0.2','0.4','0.6','0.8','1'})
% yticks([1 2 3 4 5 6])
% yticklabels({'0','0.2','0.4','0.6','0.8','1'})
% xlabel('Y') 
% ylabel('X') 
% zlabel('Concentration')
% title('GS Numerical Solution')

surf(A_Fourier)
xticks([1 2 3 4 5 6])
xticklabels({'0','0.2','0.4','0.6','0.8','1'})
yticks([1 2 3 4 5 6])
yticklabels({'0','0.2','0.4','0.6','0.8','1'})
xlabel('Y') 
ylabel('X') 
zlabel('Concentration')
title('Fourier Solution')

% surf(A_diff)
% xticks([1 2 3 4 5 6])
% xticklabels({'0','0.2','0.4','0.6','0.8','1'})
% yticks([1 2 3 4 5 6])
% yticklabels({'0','0.2','0.4','0.6','0.8','1'})
% xlabel('Y') 
% ylabel('X') 
% zlabel('Concentration')
% title('Difference')
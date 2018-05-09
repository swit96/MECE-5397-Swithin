clc
clear all
close all
%% Intial conditions, time steps, space steps
Lx=10;
Ly=10;
Nx= 50;
Ny=50;
Nt = 10;
dx = Lx/(Nx-1);
dy = Ly/(Ny-1);
A=1;
%%CFL
c=1;
C=0.05;
dt= C*dx/c;

Tn=zeros(Ny,Nx);
x= linspace(0,Lx,Nx);
y= linspace(0,Ly,Ny);
%%Plotting the solution
[X,Y] = meshgrid(x,y);

%%Intial t
Tn(:,:)=0;
t=0;
Tol= 1E-6; %%Verification, grid convergence
error=1;
%%Explicit method
while error>Tol
    Tc= Tn;
    t = t+dt;
    for i=2:Nx-1
        for j= 2:Ny-1
            Tn(j,i)=Tc(j,i)+ dt*((Tc(j,i+1)+Tc(j+1,i)-4*Tc(j,i)+Tc(j,i-1))+Tc(j-1,i))/dx/dx; 
                                        %dx/dx is faster than dx^2 which a optimization method
        end
    end
    %% Boundary Conditions
    Tn(1,:)= (pi-dx)^(2)*cos(dx);
    Tn(end,:)=dx*(pi-dx)^(2);
    Tn(:,1)= -4*pi^2+((dy+pi)/2*pi)*(-4*pi^3+4*pi^2);
    Tn(:,end)=Tn(:,end-1); %%Neumann
    
    %% Plotting
    mesh(x,y, Tn); axis([-10 10 -10 10 -10  10]);
    title(sprintf('Time= %f seconds',t));
    pause(.00000001)
    %%error calculation
    error = max(max(abs(Tc-Tn)));
end

%%Steady State plots
subplot(2,1,1),contour(x,y,Tn),
title('Temperature (Steady State)'),xlabel('x'),ylabel('y'),colorbar
subplot(2,1,2),pcolor(x,y,Tn),shading interp,
title('Temperature (Steady State)'),xlabel('x'),ylabel('y'),colorbar

    %% Run time around 98.5 seconds to hit the steady state region 
    
          









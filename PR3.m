clc; clear; close all;


m1= 290;% kg
m2= 59;% kg
b1= 1000;% Ns/m
k1= 16182;% N/m
k2= 19000;% N/m
f=0;% N


tspan = [0 10];
x0 = [0 0 0 0];   

z=1;
[t1,x_z1]= ode45(@(t,x) suspension(t,x,m1,m2,b1,k1,k2,f,z), tspan, x0);

z=2;
[t2,x_z2]= ode45(@(t,x) suspension(t,x,m1,m2,b1,k1,k2,f,z), tspan, x0);

figure

plot(t1,x_z1(:,1),'b','LineWidth',1.5); hold on
plot(t1,x_z1(:,2),'r','LineWidth',1.5)

plot(t2,x_z2(:,1),'--b','LineWidth',1.5)
plot(t2,x_z2(:,2),'--r','LineWidth',1.5)

grid on
xlabel('Tiempo (s)')
ylabel('Desplazamiento (m)')
title('Suspension automovil')
legend('x_1 con z_1','x_2 con z_1','x_1 con z_2','x_2 con z_2')

function dx = suspension(t,x,m1,m2,b1,k1,k2,f,ztype)

if ztype == 1
    z = 0.05*sin(0.5*pi*t);   % z1(t)
else
    z = 0.05*sin(20*pi*t);    % z2(t)
end

dx = zeros(4,1);

dx(1) = x(3);
dx(2) = x(4);

dx(3) = (-b1*x(3)+b1*x(4)-k1*x(1)+k1*x(2)+f)/m1;
dx(4) = (b1*x(3)-b1*x(4)+k1*x(1)-(k1+k2)*x(2) ...
          - f + k2*z )/m2;
end

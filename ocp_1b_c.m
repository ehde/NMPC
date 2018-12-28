clear all;
close all;
clc; 
%% parameters
 t0 = 0; % initial time
 tf = 3; % end time
 h = 0.02;
 N = (tf - t0)/h; % horizon length
 t = t0:h:tf;
 nx = 4;
 nu = 2;
 l_1=0.5;
 l_2=0.5;
 % c = 1;
 % initial conditions
 x0 = [-5;0; -4;0];
 % terminal conditons
 xend=[pi/2;0;0;0];
 % weights
 Q = eye(nx);
 R = 0.005*eye(nu);
 % constraints
 umin = -1000;
 umax = 1000;
 %% solve steady state problem
 % steady state
 xSS = zeros(nx,1);
 uSS = zeros(nu,1);
 % better way
 % cASS = 0.1;
 % [y,fval] = fsolve(@(y)CSTR ode(0,[cASS,y(1)],y(2)), [x0]);
 % xSS = [cASS; y(1)];
 % uSS = y(2);
%% build OCP
addpath('D:\Programme\Matlab2018\toolbox\casadi')
 import casadi.*
 ocp = casadi.Opti();
 X = ocp.variable(nx,N+1);
 U = ocp.variable(nu,N);


 J = 0;
 for i=1:N
 % dynamics
 xx = heuns(@(t,x,u)vdp(t,x,u),h,t(i),X(:,i),U(:,i));
 ocp.subject_to( X(:,i+1) == xx );
 % input constraints
 ocp.subject_to( umin <= U(:,i) <= umax );
 % nonlinear constraint
 ocp.subject_to( -3/2*pi <= X(2,i) <= 3/2*pi );
 ocp.subject_to( -3/2*pi <= X(4,i) <= 3/2*pi );
 
 % cost function
 dx = X(:,i+1)-xSS;
 du = U(:,i)-uSS;
 J = J + h*(dx'*Q*dx + du'*R*du);
 end
  ocp.subject_to( -3/2*pi <= X(2,end) <= 3/2*pi );
 ocp.subject_to( -3/2*pi <= X(4,end) <= 3/2*pi );
 % initial condition
 ocp.subject_to( X(:,1) == x0 )
 % terminal constraint
 ocp.subject_to( X(:,end) == xend );
 %% solve OCP
 % initial guess
 ocp.set_initial(X,repmat(x0,1,N+1));
 ocp.set_initial(U,repmat(0.5*(umax-umin),2,N));

 % set solver
 ocp.solver('ipopt');
 % set objective
 ocp.minimize(J);
 % solve ocp
 sol = ocp.solve();
% get solution
 Xsol = sol.value(X);
 Usol = sol.value(U);
 
 %x-y-plane plot
 arm1=[];
 arm2=[];
 arm1(1,:)= l_1*cos(Xsol(1,:));
 arm1(2,:)= l_1*sin(Xsol(1,:));
 arm2(1,:)= l_1*cos(Xsol(1,:))+l_2*cos(Xsol(1,:)+Xsol(3,:));
 arm2(2,:)= l_1*sin(Xsol(1,:))+l_2*sin(Xsol(1,:)+Xsol(3,:));
 %% plot solutions
 t_plot = [t0:1e-4:tf];
 

 fig = figure('position', [60, 100, 500, 500])
 subplot(2,1,1)
 plot(t, Xsol(:,:),'Linewidth', 2)
 xlabel('t')
 ylabel('States')
 legend('q_1','Dq_1','q_2','Dq_2')
 %axis([0, 1, -0.5, 0]);
 grid on
 xlim([t_plot(1), t_plot(end)]);


 subplot(2,1,2)
 plot(t(1:N), Usol,'Linewidth', 2)
 xlabel('t')
 ylabel('u')
 legend('U_1', 'U_2')
 grid on
 xlim([t_plot(1), t_plot(end)]);
 
 figure('position', [600, 100, 500, 500])
 plot(arm1(1,:),arm1(2,:) ,'Linewidth', 2)
 hold on
 plot(arm1(1,1),arm1(2,1), '*')
 plot(arm1(1,end),arm1(2,end), 'o')
 hold on
 plot(arm2(1,:),arm2(2,:) ,'Linewidth', 2)
 hold on
 plot(arm2(1,1),arm2(2,1), '+')
 plot(arm2(1,end),arm2(2,end), 'o')
 xlabel('X')
 ylabel('Y')
 grid on
 axis([-1 1 -1 1])
 


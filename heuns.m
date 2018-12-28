%% Heun's method integrator
function xf = heuns(ode,h,t,x,u)
 x_tilde=x+h*ode(t,x,u);
 xf=x+h/2*(ode(t,x,u)+ode(t+h,x_tilde,u));
 end

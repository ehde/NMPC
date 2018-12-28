%% Euler forward integrator
function xf = eulerf(ode,h,t,x,u)
 xf=x+h*ode(t,x,u);
 end

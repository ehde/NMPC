function dqdt = vdp(t,Y,u)

%VDP Summary of this function goes here
%   Detailed explanation goes here

dqdt=[Y(2);
    -(2*(235*u(2) - 1225*u(1) + 961380*cos(Y(1)) + 242847*cos(Y(1) + Y(3)) + 5875*sin(Y(3))*Y(2)^2 + 30625*sin(Y(3))*Y(4)^2 - 61325*cos(Y(3))*cos(Y(1) + Y(3)) + 250*u(2)*cos(Y(3)) + 6250*cos(Y(3))*sin(Y(3))*Y(2)^2 + 61250*sin(Y(3))*Y(2)*Y(4)))/(5*(19800*cos(Y(3)) - 2500*cos(Y(3))^2 + 95791));
    Y(4);
 (4000*u(2) - 470*u(1) + 368856*cos(Y(1)) - 865909*cos(Y(1) + Y(3)) + 392400*cos(Y(1))*cos(Y(3)) + 100000*sin(Y(3))*Y(2)^2 + 11750*sin(Y(3))*Y(4)^2 - 122650*cos(Y(3))*cos(Y(1) + Y(3)) - 500*u(1)*cos(Y(3)) + 1000*u(2)*cos(Y(3)) + 25000*cos(Y(3))*sin(Y(3))*Y(2)^2 + 12500*cos(Y(3))*sin(Y(3))*Y(4)^2 + 23500*sin(Y(3))*Y(2)*Y(4) + 25000*cos(Y(3))*sin(Y(3))*Y(2)*Y(4))/(5*(19800*cos(Y(3)) - 2500*cos(Y(3))^2 + 95791));
];
 end


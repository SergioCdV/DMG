function [dae,Ddae] = MinfuelDae(sol,setup)

global constants

sigma = sol.time;
x = sol.state;
C1 = x(:,1);
C2 = x(:,2);
C3 = x(:,3);
tau = x(:,4);
u = sol.control;
u1=u(:,1);
u2=u(:,2);

sigmaf = sol.parameter(2);
sigma =sigma*(sigmaf);
p1 = constants.p1;
p2 = sol.parameter(1);



s= 1+C1.*cos(sigma)+C2.*sin(sigma);
p=C1+(1+s).*cos(sigma);
q=C2+(1+s).*sin(sigma);

apx= (u1./(p1-p2.*tau))./(C3.^4.*s.^3);
apy= (u2./(p1-p2.*tau))./(C3.^4.*s.^3);

C1dot =  s.*sin(sigma).*apx + p.*apy; 
C2dot = -s.*cos(sigma).*apx + q.*apy;
C3dot = -C3.*apy;
taudot = 1./(C3.^3.*s.^2);

path = u1.^2+u2.^2;


dae = [sigmaf.*C1dot, sigmaf.*C2dot, sigmaf.*C3dot, sigmaf.*taudot, path];

       

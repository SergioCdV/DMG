% ----------------------------
% Bryson Maximum-Radius Example
% ----------------------------
% This problem is taken verbatim from the following reference:
% Bryson, A. E. and Ho, Y-C, Applied Optimal Control, Hemisphere
% Publishing, New York, 1975.
% ----------------------------
clear all
clear setup limits guess;
format long

global constants
constants.p1 = 1/0.1405;
constants.p2 = 0.5328825;
snseti ('Scale option',1);
eps=1;
C10 = 0;
C20 = 0;
C30 = 1;
tau0 = 0;
C1f= 0;
C2f= 0 ;
C3f= 0.8*eps;
tauf=3.32;
C1min = -1;
C1max =  1;
C2min= -1;
C2max = 1;
C3min = -1;
C3max = 1;
taumin = 0;
taumax = 3.32;
u1min = -5;
u1max = -u1min*eps;
u2min = u1min;
u2max = u1max;
sigma0 = 0 ;
sigmaf = 1;

iphase = 1;
limits(iphase).nodes = 40;
limits(iphase).time.min         = [sigma0     sigmaf];
limits(iphase).time.max         = [sigma0     sigmaf];
limits(iphase).state.min(1,:)   = [C10 C1min C1f];
limits(iphase).state.max(1,:)   = [C10 C1max C1f];
limits(iphase).state.min(2,:)   = [C20 C2min C2f];
limits(iphase).state.max(2,:)   = [C20 C2max C2f];
limits(iphase).state.min(3,:)   = [C30 C3min C3min];
limits(iphase).state.max(3,:)   = [C30 C3max C3max];
limits(iphase).state.min(4,:)   = [tau0 taumin tauf];
limits(iphase).state.max(4,:)   = [tau0 taumax tauf];
limits(iphase).control.min(1,:) = u1min;
limits(iphase).control.max(1,:) = u1max;
limits(iphase).control.min(2,:) = u2min;
limits(iphase).control.max(2,:) = u2max;

limits(iphase).parameter.min    = 0;
limits(iphase).parameter.max    = 5;

limits(iphase).path.min    = 1;
limits(iphase).path.max    = 1;
limits(iphase).event.min   = [0; 0];
limits(iphase).event.max   = [0 ;0];
guess(iphase).time =  [sigma0; sigmaf];
guess(iphase).state(:,1) = [C10; C1f];
guess(iphase).state(:,2) = [C20; C2f];
guess(iphase).state(:,3) = [C30; C3f];
guess(iphase).state(:,4) = [tau0; tauf];
guess(iphase).control(:,1) = [0; 1];
guess(iphase).control(:,2) = [1; 0];
guess(iphase).parameter =  2.48 ;
tic()
setup.name = 'Maxradius';
setup.funcs.cost = 'MaxradiusCost';
setup.funcs.dae = 'MaxradiusDae';
setup.funcs.event = 'maxradeventfun';
setup.limits = limits;
setup.guess = guess;
setup.linkages = [];
setup.solver ='ipopt';
setup.method ='pseudospectral';
setup.checkDerivatives = 1;

%%

output = DMG(setup);
%plot(solution.state(:,4),solution.state(:,1))
%figure(2)
%plot(solution.state(:,4),solution.state(:,2))
%figure(3)
%plot(solution.state(:,4),solution.state(:,3))
%figure(4)
%plot(solution.state(:,4), atan2(solution.control(:,1),solution.control(:,2)))
%figure(1)
%plot(solution.state(:,4), solution.costate)
solution.costate(1,:)
rf=1/solution.state(end,3)^2

error = 1.525243822099782- rf
toc()


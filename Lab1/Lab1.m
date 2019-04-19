%% initialize
clear all;
close all;
clc;
%% buck
Vin = 24;
RL = 10;
L = 100e-6;
C = 100e-6;
%% 2.1 graph Vout(d)
D = linspace(0,1,1001);
Vout = D*Vin;
fig = figure;
plot(D,Vout,'LineWidth',2)
grid on
xlabel('D')
ylabel('V_{out} [V]')
yticks([0,6,12,18,24])
saveFig(fig,'buck_Vout',200)
%% 2.2 graph VCripple(fsw) og ILripple(fsw)
fsw = linspace(40e3,100e3,601);
D = 0.5;
Vout=Vin*D;
dt = 1./fsw*D;
ILripple = 1/L*(Vin-Vout)*dt;
Q = 1./2*ILripple./2.*1./(2.*fsw);
VCripple = Q./C;
fig = figure;
plot(fsw/1000,ILripple,'LineWidth',2)
grid on
xlabel('f_{sw} [kHz]')
ylabel('I_{L,ripple} [A]') 
ylim([0 max(ILripple)])
saveFig(fig,'buck_IL',200)
fig = figure;
plot(fsw/1000,1000*VCripple,'LineWidth',2)
grid on
xlabel('f_{sw} [kHz]')
ylabel('V_{C,ripple} [mV]') 
ylim([0 1000*max(VCripple)])
saveFig(fig,'buck_VC',200)
%% 2.3 Critical RL
fsw=100e3;
D=0.5;
Rcrit = 2*L*fsw/(1-D);
display(Rcrit)
%% 2.4 efficiency
% 100 kHz should be more effective since the p2p ripple current and voltage
% is a lot lower.
%% boost
L = 100e-6;
Vin = 10;
%% 4.1 Vout(D)
D = linspace(0.1,0.6,501);
Vout=Vin./(1-D);
fig = figure;
plot(D,Vout,'LineWidth',2)
grid on
xlabel('D')
ylabel('V_{out} [V]')
saveFig(fig,'boost_Vout',200)
%% 4.2 ILripple
fsw = linspace(40e3,100e3,601);
D = 0.5;
RL = 20;
dt = 1./fsw*D;
ILripple = 1/L*Vin*dt;
fig = figure;
plot(fsw/1000,ILripple,'LineWidth',2)
grid on
xlabel('f_{sw} [kHz]')
ylabel('I_{L_{ripple}} [A]') 
ylim([0 max(ILripple)])
saveFig(fig,'boost_IL',200)
%% 4.3 efficiency 
% 100 kHz should be more effective since the p2p ripple current is a lot lower.
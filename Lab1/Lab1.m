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
% read data
d10 = readtable('451-10.csv', 'HeaderLines', 1);
d20 = readtable('451-20.csv', 'HeaderLines', 1);
d30 = readtable('451-30.csv', 'HeaderLines', 1);
d40 = readtable('451-40.csv', 'HeaderLines', 1);
d50 = readtable('451-50.csv', 'HeaderLines', 1);
d60 = readtable('451-60.csv', 'HeaderLines', 1);
d_list=[d10.Volt d20.Volt d30.Volt d40.Volt d50.Volt d60.Volt];
D_real = 0.1:0.1:0.6;
Vout_real = zeros(length(D_real),1);
for i=1:length(Vout_real)
    Vout_real(i)=mean(d_list(:,i));
end
D = linspace(0.1,0.6,501);
Vout=Vin./(1-D);
%% plot
fig = figure;
plot(D,Vout,'LineWidth',2)
hold on
plot(D_real,Vout_real,'.','MarkerSize',15)
legend('Theoretical','Measured','Location','northwest')
grid on
xlabel('D')
xlim([0.1 0.6])
ylabel('V_{out} [V]')
set(gca,'FontSize',20)
saveFig(fig,'boost_Vout_data',200)
%% 4.2 waveform
Lwave40_boost = readtable('452-40.csv', 'HeaderLines', 1);
Lwave60_boost = readtable('452-60.csv', 'HeaderLines', 1);
Lwave80_boost = readtable('452-80.csv', 'HeaderLines', 1);
Lwave100_boost = readtable('452-100.csv', 'HeaderLines', 1);
fig=figure;
plot((Lwave40_boost.second-Lwave40_boost.second(1))*10^6,2*Lwave40_boost.Volt_2,'LineWidth',1.2)
hold on
plot((Lwave60_boost.second-Lwave60_boost.second(1))*10^6,2*Lwave60_boost.Volt_2,'LineWidth',1.2)
plot((Lwave80_boost.second-Lwave80_boost.second(1))*10^6,2*Lwave80_boost.Volt_2,'LineWidth',1.2)
plot((Lwave100_boost.second-Lwave100_boost.second(1))*10^6,2*Lwave100_boost.Volt_2,'LineWidth',1.2)
grid on
xlabel('Time [\mus]')
xlim([0,50])
ylabel('Inductor current [A]')
set(gca,'FontSize',20)
legend('40 kHz','60 kHz','80 kHz','100 kHz','Location','south')
saveFig(fig,'boost_Lripple_wave',200)
%% 4.2 ILripple
fsw = linspace(40e3,100e3,601);
D = 0.5;
fsw_real = (40:20:100);
Lwave_list = [2*Lwave40_boost.Volt_2 2*Lwave60_boost.Volt_2 2*Lwave80_boost.Volt_2 2*Lwave100_boost.Volt_2];
ILripple_real = 2*sqrt(3).*sqrt(1/2000.*sum((Lwave_list-mean(Lwave_list,1)).^2,1));
%ILripple_real = [2.298-1.241 2.11-1.44 2.045-1.515 1.973-1.563];
RL = 20;
dt = 1./fsw*D;
ILripple = 1/L*Vin*dt;
%%
fig = figure;
plot(fsw/1000,ILripple,'LineWidth',2)
grid on
hold on
plot(fsw_real,ILripple_real,'.','MarkerSize',15)
legend('Theoretical','Measured','Location','northeast')
xlabel('f_{sw} [kHz]')
ylabel('I_{L_{ripple}} [A]') 
ylim([0 max(ILripple)])
set(gca,'FontSize',20)
saveFig(fig,'boost_IL_data',200)
%% 4.3 efficiency 
% 100 kHz should be more effective since the p2p ripple current is a lot lower.
eff_boost_100 = readtable('453-100.csv', 'HeaderLines', 1);
eff_boost_40 = readtable('453-40.csv', 'HeaderLines', 1);
eff_boost_100_Iout_wave=2*eff_boost_100.Volt_2-0.965;
eff_boost_100_Iout_wave(eff_boost_100_Iout_wave<0.5)=0;
%eff_boost_100_Iout_wave(eff_boost_100_Iout_wave>1.75)=1.7;
eff_boost_40_Iout_wave=2*eff_boost_40.Volt_2-0.965;
eff_boost_40_Iout_wave(eff_boost_40_Iout_wave<0.5)=0;
%eff_boost_40_Iout_wave(eff_boost_40_Iout_wave>1.75)=1.7;
fig=figure;
plot(10^6*(eff_boost_100.second-min(eff_boost_100.second)),[2*eff_boost_100.Volt_2,eff_boost_100_Iout_wave,2*eff_boost_100.Volt_3],'LineWidth',1.2)
legend('I_{out}','I_{out}*','I_{in}')
xlabel('Time [\mus]')
xlim([0 50])
ylabel('Current [A]')
grid()
set(gca,'FontSize',20)
saveFig(fig,'boost_eff_100',200)

fig=figure;
plot(10^6*(eff_boost_40.second-min(eff_boost_40.second)),[2*eff_boost_40.Volt_2,eff_boost_40_Iout_wave,2*eff_boost_40.Volt_3],'LineWidth',1.2)
legend('I_{out}','I_{out}*','I_{in}')
xlabel('Time [\mus]')
xlim([0 50])
ylabel('Current [A]')
grid()
set(gca,'FontSize',20)
saveFig(fig,'boost_eff_40',200)
eff_boost_100_Vout=1/2000*sum(eff_boost_100.Volt);
eff_boost_100_Vin=1/2000*sum(eff_boost_100.Volt_1);
eff_boost_100_Iout=1/2000*sum(eff_boost_100_Iout_wave);
eff_boost_100_Iin=1/2000*sum((2.*eff_boost_100.Volt_3));
eff_boost_40_Vout=1/2000*sum(eff_boost_40.Volt);
eff_boost_40_Vin=1/2000*sum(eff_boost_40.Volt_1);
eff_boost_40_Iout=1/2000*sum(eff_boost_40_Iout_wave);
eff_boost_40_Iin=sqrt(1/2000*sum((2.*eff_boost_40.Volt_3).^2));
% efficiency
eff_boost_100_real=eff_boost_100_Vout*eff_boost_100_Iout/(eff_boost_100_Vin*eff_boost_100_Iin);
eff_boost_40_real=eff_boost_40_Vout*eff_boost_40_Iout/(eff_boost_40_Vin*eff_boost_40_Iin);
display(eff_boost_100_real)
display(eff_boost_40_real)
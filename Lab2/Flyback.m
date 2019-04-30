%% Flyback init
clear all;
close all;
clc;
%% 
Nturns=1/2; %N2/N1
Vin=15;
%% 8.5.1
d1 = readtable('data\851-00.csv','HeaderLines',1);
d2 = readtable('data\851-10.csv','HeaderLines',1);
d3 = readtable('data\851-20.csv','HeaderLines',1);
d4 = readtable('data\851-30.csv','HeaderLines',1);
d5 = readtable('data\851-40.csv','HeaderLines',1);
d6 = readtable('data\851-50.csv','HeaderLines',1);
D=linspace(0,0.5,5001);
Dreal=[0 0.1 0.2 0.3 0.4 0.5];
Voutreal=[mean(d1.Volt_1) mean(d2.Volt_1) mean(d3.Volt_1) mean(d4.Volt_1) mean(d5.Volt_1) mean(d6.Volt_1)];
Vout=Nturns*Vin.*D./(1-D);
%% fig
fig=figure;
plot(D,Vout,'LineWidth',2)
hold on
plot(Dreal,Voutreal,'.','MarkerSize',15)
legend('Theoretical','Measured','Location','northwest')
grid on
xlabel('D')
ylabel('V_{out} [V]')
%ylim([0 Vin*2])
xlim([0 0.5])
set(gca,'FontSize',20)
saveFig(fig,'figs/Flyback_Vout_real.eps',200)
%% 8.5.2
D=0.4;
RL=10;
fsw=100e3;
%% voltage
dV = readtable('data\852-10-100.csv','HeaderLines',1);
Treal=dV.second-dV.second(1);
Vsec_real=dV.Volt_1;
T=linspace(0,1,1001);
Vprim=zeros(1,length(T));
Vprim(T<=D)=Vin;
Vprim(T>=D)=-Vin*D/(1-D);
Vsec=zeros(1,length(T));
Vsec(T<=D)=-Nturns*Vin;
Vsec(T>=D)=Nturns*Vin*D/(1-D);
Vsec=[Vsec Vsec(2:end)];
Vprim=[Vprim Vprim(2:end)];
T=linspace(0,1,2001);
%% fig
fig=figure;
plot((T*Treal(end)/2)*10^6,Vprim,'LineWidth',2.5)
hold on
grid on
plot((T*Treal(end)/2)*10^6,Vsec,'LineWidth',2.5)
plot((Treal-4e-7)*10^6,-2*Vsec_real,'LineWidth',1.5)
plot((Treal-4e-7)*10^6,Vsec_real,'LineWidth',1.5)
xlabel('T [\mus]')
ylabel('Voltage [V]')
xlim([0 Treal(end)/2*10^6])
legend('V_{prim} theoritical','V_{sec} theoritical','V_{prim} constructed','V_{sec} measured')
set(gca,'FontSize',20)
saveFig(fig,'figs/Flyback_transwave_real.eps',200)
%% mosfet
dV = readtable('data\852-10-100.csv','HeaderLines',1);
Tcons=dV.second-dV.second(1);
Vmos_cons=Vin+2*dV.Volt_1;
dmos = readtable('data\852-mos.csv','HeaderLines',1);
Tmos=dmos.second-dmos.second(1);
Vmos_real=dmos.Volt_1;
T=linspace(0,1,1001);
Vmos=zeros(1,length(T));
Vmos(T<=D)=0;
Vmos(T>=D)=Vin+Vin*D/(1-D);
Vmos=[Vmos Vmos(2:end)];
T=linspace(0,1,2001);
%% fig
fig=figure;
plot((T*Tmos(end))*10^6,Vmos,'LineWidth',4)
hold on
plot(Tcons*10^6-0.4,Vmos_cons,'LineWidth',2)
plot((Tmos-3e-7)*10^6,Vmos_real,'LineWidth',2)
grid on
xlabel('T [\mus]')
ylabel('Voltage over mosfet [V]')
xlim([0 (Tmos(end)-3e-7)*10^6])
ylim([-4 38]);
legend('Theoretical','Constructed','Measured','Location','best')
set(gca,'FontSize',20)
saveFig(fig,'figs/Flyback_mos_real.eps',200)
%% current
% Iout = Idiode
D=0.4;
Lprim = 280e-6;
Lsec = 70e-6;
Vout=Nturns*Vin*D/(1-D);
RL=10;
fsw=40e3;
%
Tmax=1/fsw;
T=linspace(0,Tmax,1001);
Iout=Vout/RL;
Iin=Nturns*Iout*D/(1-D); % based on 100% efficiency
Iin_delta=Vin*(D*Tmax)/Lprim;
Iin_0=-(D*Iin_delta-2*Iin)/(2*D);
Iin_peak=(D*Iin_delta+2*Iin)/(2*D);
Iout_0=1/Nturns*Iin_0;
Iout_peak=1/Nturns*Iin_peak;
%waveforms
iin=zeros(1,length(T));
iout=zeros(1,length(T));
iin(1:(D*1000+1))=Iin_0+T(1:(D*1000+1))*Iin_delta/(Tmax*D);
iout((D*1000+1):end)=Iout_peak-(T((D*1000+1):end)-T(D*1000+1))*(Iout_peak-Iout_0)/(Tmax*(1-D));
%% save data
save('Flyback_currentwave_10_40.mat','T','iin','iout');
%% fig iin
data_75_40=load('Flyback_currentwave_75_40.mat');
data_10_40=load('Flyback_currentwave_10_40.mat');
data_75_100=load('Flyback_currentwave_75_100.mat');
fig=figure;
plot(data_75_40.T,data_75_100.iin,'LineWidth',2)  %brugt anden x-akse ift skitse!!!
hold on
plot(data_10_40.T,data_10_40.iin,'LineWidth',2)
plot(data_75_40.T,data_75_40.iin,'LineWidth',2)
grid on
xlabel('T')
xlim([0,data_10_40.T(end)])
xticks([data_10_40.T(end)/5 2/5*data_10_40.T(end) 3/5*data_10_40.T(end) 4/5*data_10_40.T(end)])
xticklabels(['' '' '' ''])
ylabel('I_{in}') 
yticks([0.2 0.4 0.6 0.8]);
yticklabels('')
set(gca,'FontSize',20)
saveFig(fig,'figs/Flyback_iin.eps',200)
%% fig iout
data_75_40=load('Flyback_currentwave_75_40.mat');
data_10_40=load('Flyback_currentwave_10_40.mat');
data_75_100=load('Flyback_currentwave_75_100.mat');
fig=figure;
plot(data_75_40.T,data_75_100.iout,'LineWidth',2) %brugt anden x-akse ift skitse!!!
hold on
plot(data_10_40.T,data_10_40.iout,'LineWidth',2)
plot(data_75_40.T,data_75_40.iout,'LineWidth',2)
grid on
xlabel('T')
xlim([0,data_10_40.T(end)])
xticks([data_10_40.T(end)/5 2/5*data_10_40.T(end) 3/5*data_10_40.T(end) 4/5*data_10_40.T(end)])
xticklabels(['' '' '' ''])
ylabel('I_{in}') 
yticks([0.4 0.8 1.2 1.6]);
yticklabels('')
set(gca,'FontSize',20)
saveFig(fig,'figs/Flyback_iout.eps',200) 
%% fig iout real
clear
d1 = readtable('data\852-75-100.csv','HeaderLines',1);
d2 = readtable('data\852-75-040.csv','HeaderLines',1);
d3 = readtable('data\852-10-100.csv','HeaderLines',1);
d4 = readtable('data\852-10-040.csv','HeaderLines',1);
fig=figure;
plot((d1.second-2.8e-7)*10^6,2*d1.Volt_2,'LineWidth',1.5)
hold on
plot((d2.second-2.8e-7)*10^6,2*d2.Volt_2,'LineWidth',1.5)
plot((d3.second-2.8e-7)*10^6,2*d3.Volt_2,'LineWidth',1.5)
plot((d4.second-2.8e-7)*10^6,2*d4.Volt_2,'LineWidth',1.5)
grid on
xlim([0 (2.63e-5)*10^6]);
xlabel('T [\mus]')
ylabel('Output current [A]')
legend('R=7.5 \Omega,f_{sw}=100 kHz','R=7.5 \Omega,f_{sw}=40 kHz','R=10 \Omega,f_{sw}=100 kHz','R=10 \Omega,f_{sw}=40 kHz','Location','eastoutside');
saveFig(fig,'figs/Flyback_iout_real.eps',200)
fig=figure;
plot((d1.second)*10^6,2*d1.Volt_3,'LineWidth',1.5)
hold on
plot((d2.second)*10^6,2*d2.Volt_3,'LineWidth',1.5)
plot((d3.second)*10^6,2*d3.Volt_3,'LineWidth',1.5)
plot((d4.second)*10^6,2*d4.Volt_3,'LineWidth',1.5)
grid on
xlim([0 25.99]);
xlabel('T [\mus]')
ylabel('Input current [A]')
legend('R=7.5 \Omega,f_{sw}=100 kHz','R=7.5 \Omega,f_{sw}=40 kHz','R=10 \Omega,f_{sw}=100 kHz','R=10 \Omega,f_{sw}=40 kHz','Location','eastoutside');
saveFig(fig,'figs/Flyback_iin_real.eps',200)
%% lm1
% 100 kHz 1.6 -> 3.18
% 40 kHz 2.19 -> 10.11
clear
d1 = readtable('data\852-75-100.csv','HeaderLines',1);
d2 = readtable('data\852-75-040.csv','HeaderLines',1);
d3 = readtable('data\852-10-100.csv','HeaderLines',1);
d4 = readtable('data\852-10-040.csv','HeaderLines',1);
d1fit=d1.Volt_3(d1.second>=1.6e-6 & d1.second<=3.18e-6);

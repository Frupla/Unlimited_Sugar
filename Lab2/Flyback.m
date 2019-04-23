%% Flyback init
clear all;
close all;
clc;
%% 
Nturns=1/2; %N2/N1
Vin=15;
%% 8.5.1
D=linspace(0,1,1001);
Vout=Nturns*Vin.*D./(1-D);
%% fig
fig=figure;
plot(D,Vout,'LineWidth',2)
grid on
xlabel('D')
ylabel('V_{out} [V]')
ylim([0 Vin*2])
xlim([0 1])
set(gca,'FontSize',20)
saveFig(fig,'figs/Flyback_Vout.eps',200)
%% 8.5.2
D=0.4;
RL=10;
fsw=100e3;
%% voltage
T=linspace(0,1,1001);
Vprim=zeros(1,length(T));
Vprim(T<=D)=Vin;
Vprim(T>=D)=-Vin*D/(1-D);
Vsec=zeros(1,length(T));
Vsec(T<=D)=-Nturns*Vin;
Vsec(T>=D)=Nturns*Vin*D/(1-D);
%% fig
fig=figure;
plot(T,Vprim,'LineWidth',2)
hold on
grid on
plot(T,Vsec,'LineWidth',2)
xlabel('T')
ylabel('Voltage [V]')
xlim([0 1])
legend('Primary winding','Secondary winding')
set(gca,'FontSize',20)
saveFig(fig,'figs/Flyback_transwave.eps',200)
%% mosfet
Vmos=zeros(1,length(T));
Vmos(T<=D)=0;
Vmos(T>=D)=Vin+Vin*D/(1-D);
%% fig
fig=figure;
plot(T,Vmos,'LineWidth',2)
hold on
grid on
xlabel('T')
ylabel('Voltage over mosfet [V]')
xlim([0 1])
set(gca,'FontSize',20)
saveFig(fig,'figs/Flyback_mos.eps',200)
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
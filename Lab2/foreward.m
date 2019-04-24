% foreward

% Graf Vout over d
Vin = 20;
D = linspace(0,0.4,1001);
Vout = D*Vin;
fig = figure(100);
plot(D,Vout,'LineWidth',2)
grid on
xlabel('D')
ylabel('V_{out} [V]')
%yticks([0,6,12,18,24])
saveFig(fig,'foreward_Vout_vs_D',200)

%% Kurveform af spændingen over MOSFETen

Vmos = horzcat(zeros(1,400),ones(1,600));
t = linspace(0,1,1000);
fig = figure(100);
plot(t,Vmos,'LineWidth',2);
xticks([0 0.200 0.400 0.600 0.800 1]);
xticklabels({'0','','dT','','','T'})
xlabel('t')
ylabel('V_{MOSFET}')
yticks([0 0.25 0.5 0.75 1])
yticklabels({'0','','','', '2V_{in}'})
grid()
saveFig(fig,'foreward_Vmos_scetch',200)

%%

D=0.4;
Vin=20;
L=144*10^(-6);
Vout=D*Vin;
RL=10;
fsw=100*10^3;
Tmax=1/fsw;
T=linspace(0,Tmax,1001);
deltaIm = Vin*(D*Tmax)/L;
Iout = Vout/RL;
i1 =zeros(1,length(T));
i3 = zeros(1,length(T));
i1(1:(D*1000+1))=Iout+T(1:(D*1000+1))*deltaIm/(D*Tmax);
i3(D*1000+2:length(T)) = deltaIm + (T(D*1000+2:length(T))-T(D*1000+2))*(-deltaIm/((1-D)*Tmax));
iIn = i1-i3;
figure(200)
plot(T,i1,'LineWidth',8)
hold on
plot(T,i3,'LineWidth',6)
plot(T,iIn,'LineWidth',4)
xlim([0 10^(-5)])
grid()
xticks([0 0.200 0.400 0.600 0.800 1]*10^(-5));
xticklabels({'0','','dT','','','T'})
xlabel('t');
ylabel('V_{MOSFET}');
yticks([-deltaIm 0 deltaIm Iout (Iout+deltaIm)]);
yticklabels({'-\Delta I_m','0','','\Delta I_m', 'I_{out}','I_{out}+\Delta I_m'});
title({'Constructing the input current from', 'the current running through primary winding','and current running through the demagtinization winding'});
legend('Current through primary winding','Current through demagtinization winding','Input current');
set(gca,'FontSize',12)
ylabel('I')
xlabel('t')
hold off
%all this based off pase 147 of the book

%% Now we do that four times:
RL = 10;
fsw=100*10^3;
Tmax=1/fsw;
T=linspace(0,Tmax,1001);
T1 =T;
deltaIm = Vin*(D*Tmax)/L;
Iout = Vout/RL;
i1 =zeros(1,length(T));
i3 = zeros(1,length(T));
i1(1:(D*1000+1))=Iout+T(1:(D*1000+1))*deltaIm/(D*Tmax);
i3(D*1000+2:length(T)) = deltaIm + (T(D*1000+2:length(T))-T(D*1000+2))*(-deltaIm/((1-D)*Tmax));
iIn1 = i1-i3;

RL = 7.5;
fsw=100*10^3;
Tmax=1/fsw;
T=linspace(0,Tmax,1001);
T2 =T;
deltaIm = Vin*(D*Tmax)/L;
Iout = Vout/RL;
i1 =zeros(1,length(T));
i3 = zeros(1,length(T));
i1(1:(D*1000+1))=Iout+T(1:(D*1000+1))*deltaIm/(D*Tmax);
i3(D*1000+2:length(T)) = deltaIm + (T(D*1000+2:length(T))-T(D*1000+2))*(-deltaIm/((1-D)*Tmax));
iIn2 = i1-i3;


RL = 10;
fsw=40*10^3;
Tmax=1/fsw;
T=linspace(0,Tmax,1001);
T3 =T;
deltaIm = Vin*(D*Tmax)/L;
Iout = Vout/RL;
i1 =zeros(1,length(T));
i3 = zeros(1,length(T));
i1(1:(D*1000+1))=Iout+T(1:(D*1000+1))*deltaIm/(D*Tmax);
i3(D*1000+2:length(T)) = deltaIm + (T(D*1000+2:length(T))-T(D*1000+2))*(-deltaIm/((1-D)*Tmax));
iIn3 = i1-i3;



RL = 7.5;
fsw=40*10^3;
Tmax=1/fsw;
T=linspace(0,Tmax,1001);
T4 =T;
deltaIm = Vin*(D*Tmax)/L;
Iout = Vout/RL;
i1 =zeros(1,length(T));
i3 = zeros(1,length(T));
i1(1:(D*1000+1))=Iout+T(1:(D*1000+1))*deltaIm/(D*Tmax);
i3(D*1000+2:length(T)) = deltaIm + (T(D*1000+2:length(T))-T(D*1000+2))*(-deltaIm/((1-D)*Tmax));
iIn4 = i1-i3;

figure(202)

subplot(4,1,1)
plot(T1,iIn1)

subplot(4,1,2)
plot(T2,iIn2)

subplot(4,1,3)
plot(T3,iIn3)

subplot(4,1,4)
plot(T4,iIn4)


figure(203)
plot(iIn1,'LineWidth',5)
hold on
plot(iIn2,'LineWidth',3)
plot(iIn3,'LineWidth',5)
plot(iIn4,'LineWidth',3)
hold off
legend('f=100kHz, R_L = 10\Omega','f=100kHz, R_L = 7.5\Omega','f=40kHz,   R_L = 10\Omega','f=40kHz,   R_L = 7.5\Omega')
xlim([0 1000])
xticks([0 200 400 600 800 1000]);
xticklabels({'0','','dT','','','T'});
yticks([0]);
yticklabels({'0'});
set(gca,'FontSize',20)
grid()
set(gca,'FontSize',20)
ylabel('I_{in}')
xlabel('t')
%% TODO:
% 1. make similar thing, but for inductor current
% 2. make the save figure function actually work


RL = 10;
fsw=100*10^3;
Tmax=1/fsw;
T=linspace(0,Tmax,1001);
T1 =T;
deltaIm = Vin*(D*Tmax)/L;
Iout = Vout/RL;

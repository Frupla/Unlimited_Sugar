% forward

% Graf Vout over d
Vin = 20;
D = linspace(0,0.4,1001);
Vout = D*Vin;
fig = figure(100);
plot(D,Vout,'LineWidth',2)
grid on
xlabel('d')
ylabel('V_{out} [V]')
%yticks([0,6,12,18,24])
set(gca,'FontSize',16)
saveFig(fig,'forward_Vout_vs_D',200)
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
set(gca,'FontSize',12)
saveFig(fig,'forward_Vmos_scetch',200)

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
fig = figure(200)
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
set(gca,'FontSize',16)
yticks([-deltaIm 0 deltaIm Iout (Iout+deltaIm)]);
yticklabels({'-\Delta I_m','0','','\Delta I_m', 'I_{out}','I_{out}+\Delta I_m'});
%title({'Constructing the input current from', 'the current running through primary winding','and current running through the demagtinization winding'});
legend('Current in primary winding','Current in demagtinization winding','Input current','Location','best');
set(gca,'FontSize',12)
ylabel('I')
xlabel('t')
hold off
saveFig(fig,'foreward_contructing_I_out',200)
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


fig=figure(203)
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
set(gca,'FontSize',12)
grid()
ylabel('I_{in}')
xlabel('t')
saveFig(fig,'foreward_various_Iout',200)
%% TODO:
% 1. make similar thing, but for inductor current
% 2. make the save figure function actually work

[iL1,Iout1] = findingiL(10,100*10^3);
[iL2,Iout2] = findingiL(7.5,100*10^3);
[iL3,Iout3] = findingiL(10,40*10^3);
[iL4,Iout4] = findingiL(7.5,40*10^3);
fig = figure(210);
plot(iL1,'LineWidth',2)
hold on
plot(iL2,'LineWidth',2)
plot(iL3,'LineWidth',2)
plot(iL4,'LineWidth',2)
legend('I_{L} for f=100kHz, R_L = 10\Omega','I_{L} for f=100kHz, R_L = 7.5\Omega','I_{L} for f=40kHz,   R_L = 10\Omega','I_{L} for f=40kHz,   R_L = 7.5\Omega','Location','eastoutside')
xlim([0 1000])
xticks([0 200 400 600 800 1000]);
xticklabels({'','','dT','','','T'});
%yticks([Iout1,Iout2]);
%yticklabels({'I_{out,10\Omega}','I_{out,7.5\Omega}'});
set(gca,'FontSize',14)
grid()
%ylabel('I_{L}')
%xlabel('t')
saveFig(fig,'forward_various_IL',200)
hold off

function [i,Iout] = findingiL(R_L,f)
    L = 100*10^(-6);
    Vin =20;
    d =0.4;
    T_max=1/f;
    T=linspace(0,T_max,1001);
    Vout = d*Vin;
    Iout = Vout/R_L;
    i = zeros(1,length(T));
    i(1:(d*1000+1))=T(1:(d*1000+1))*(1-d)*Vin/L;
    i((d*1000+2):length(T))=(T((d*1000+2):length(T))-d/f)*(-d*Vin/L)+(1-d)*Vin*d/(L*f);
    i_avg = sum(i)/length(i);
    i = i - i_avg + Iout;
end

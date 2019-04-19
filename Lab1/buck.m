%% buck - 2.6.1, 2.6.2, 2.6.4

d1 = readtable('251del2-10.csv', 'HeaderLines', 1);
d2 = readtable('251del2-20.csv', 'HeaderLines', 1);
d3 = readtable('251del2-30.csv', 'HeaderLines', 1);
d4 = readtable('251del2-40.csv', 'HeaderLines', 1);
d5 = readtable('251del2-50.csv', 'HeaderLines', 1);
d6 = readtable('251del2-60.csv', 'HeaderLines', 1);
d7 = readtable('251del2-70.csv', 'HeaderLines', 1);
d8 = readtable('251del2-80.csv', 'HeaderLines', 1);
d9 = readtable('251del2-90.csv', 'HeaderLines', 1);


%1.Attach  a  graph  output  voltage  (V2+)  versus  duty  ratio  
%using  data  obtained  in  section  2.5.1. 
%Also plot the theoretically calculated results  on  the  same  graph.  
%Compare  the  two  plots  and  comment  about  how  the  buck  
%converter  works  as  a  variable  dc  step  down  transformer.  
%Enclose  output  voltage  &  voltage  across  diode  waveforms  
%for  duty  ratio  50%

D1 = mean(d1.Volt);
D2 = mean(d2.Volt);
D3 = mean(d3.Volt);
D4 = mean(d4.Volt);
D5 = mean(d5.Volt);
D6 = mean(d6.Volt);
D7 = mean(d7.Volt);
D8 = mean(d8.Volt);
D9 = mean(d9.Volt);

voltages = [D1,D2,D3,D4,D5,D6,D7,D8,D9];
duty = [0.1,0.2,0.30,0.40,0.50,0.60,0.70,0.80,0.90];

Vin = 24;
RL = 10;
L = 100e-6;
C = 100e-6;

D = linspace(0,1,1001);
Vout = D*Vin;
fig = figure(100);
plot(D,Vout,'LineWidth',5)
hold on
scatter(duty,voltages,'*')
grid on
xlabel('D')
ylabel('V_{out} [V]')
yticks([0,6,12,18,24])
set(gca,'fontsize', 20);
saveFig(fig,'buck_Vout_vs_duty',200)
hold off

d10 = readtable('251del1.csv', 'HeaderLines', 1);
fig = figure(101);
scatter(10^6 *(d10.second-d10.second(1)),[d10.Volt],'LineWidth',2)
hold on
scatter(10^6 *(d10.second-d10.second(1)),[d10.Volt_2],'LineWidth',2)
legend('Vout','Vd')
grid on
ylabel('V [V]')
xlabel('t [\mu s]')
set(gca,'fontsize', 20);
saveFig(fig,'buck_V_out_and_Vd_vs_time',200)
hold off


%% 2.Attach  a  copy  of  the  inductor  current  (CS5)  
%and  the  capacitor  current  (CS4)  waveforms  obtained in section 2.5.2. 
%Explain the relation between the two currents. 
%Comment on the ripple in the inductor current for the two frequencies.

d100 = readtable('252-100.csv', 'HeaderLines', 1);
d40 = readtable('252-40.csv', 'HeaderLines', 1);

fig = figure(110);
subplot(2,1,1);
scatter(10^6 * (d100.second-d100.second(1)),2*(d100.Volt_2),'LineWidth',2)
hold on
scatter(10^6 * (d100.second-d100.second(1)),2*(d100.Volt_3),'LineWidth',2)
hold off
legend('I_L', 'I_C')
ylabel('V [V]')
xlabel('t [\mu s]')
grid()
set(gca,'fontsize', 20);
subplot(2,1,2);
scatter(10^6 * (d40.second-d40.second(1)),2*d40.Volt_2,'LineWidth',2)
hold on
scatter(10^6 * (d40.second-d40.second(1)),2*d40.Volt_3,'LineWidth',2)
hold off
legend('I_L', 'I_C')
ylabel('V [V]')
xlabel('t [\mu s]')
grid()
set(gca,'fontsize', 20);
saveFig(fig,'262_I_vs_t',400)

%% 3. Plot  the  peak-peak  ripple  in  the  output  voltage 

Vin = 24;
R = 10;
L = 100e-6;
C = 100e-6;
Rc1 = 10e-3;
Rc2 = 5e-1;
Rc3 = 5;
Rc4 = 15;

f = -100e3+1:1e2:100e3;

H1 = (1j*2*pi*f*C*Rc1*R/(R+Rc1)+R/(R+Rc1))./((1j*2*pi*f).^2*L*C+(1j*2*pi*f)*(C*R*Rc1+L)/(R+Rc1)+R/(R+Rc1));
H2 = (1j*2*pi*f*C*Rc2*R/(R+Rc1)+R/(R+Rc2))./((1j*2*pi*f).^2*L*C+(1j*2*pi*f)*(C*R*Rc2+L)/(R+Rc2)+R/(R+Rc2));
H3 = (1j*2*pi*f*C*Rc3*R/(R+Rc1)+R/(R+Rc3))./((1j*2*pi*f).^2*L*C+(1j*2*pi*f)*(C*R*Rc3+L)/(R+Rc3)+R/(R+Rc3));
H4 = (1j*2*pi*f*C*Rc4*R/(R+Rc1)+R/(R+Rc4))./((1j*2*pi*f).^2*L*C+(1j*2*pi*f)*(C*R*Rc4+L)/(R+Rc4)+R/(R+Rc4));


fig = figure(230);
plot(f'/1000,mag2db(abs(H1))','LineWidth',2);
hold on 
plot(f'/1000,mag2db(abs(H2))','LineWidth',2);
plot(f'/1000,mag2db(abs(H3))','LineWidth',2);
plot(f'/1000,mag2db(abs(H4))','LineWidth',2);
hold off
legend(["10m\Omega","0.5\Omega","5\Omega","15\Omega"])
xlim([0 100e3/1000])
grid();
ylabel('amplitude')
xlabel('f [kHz]')
set(gca,'fontsize', 10);
saveFig(fig,'bodeOfESR',400);

%%

% from experiment
d1 = readtable('252-40.csv', 'HeaderLines', 1);
d2 = readtable('252-60.csv', 'HeaderLines', 1);
d3 = readtable('252-80.csv', 'HeaderLines', 1);
d4 = readtable('252-100.csv', 'HeaderLines', 1);

Vripple40 = d1.Volt - mean(d1.Volt);
Vripple60 = d2.Volt - mean(d2.Volt);
Vripple80 = d3.Volt - mean(d3.Volt);
Vripple100= d4.Volt - mean(d4.Volt);

Vpeak40 = 2*sqrt(3)*sqrt(sum(Vripple40.^2)/length(Vripple40));
Vpeak60 = 2*sqrt(3)*sqrt(sum(Vripple60.^2)/length(Vripple60));
Vpeak80 = 2*sqrt(3)*sqrt(sum(Vripple80.^2)/length(Vripple80));
Vpeak100= 2*sqrt(3)*sqrt(sum(Vripple100.^2)/length(Vripple100));

Vpeak = [0.2,0.2,0.2,0.2];

Iripple40 = 2*(d1.Volt_2 - mean(d1.Volt_2));
Iripple60 = 2*(d2.Volt_2 - mean(d2.Volt_2));
Iripple80 = 2*(d3.Volt_2 - mean(d3.Volt_2));
Iripple100= 2*(d4.Volt_2 - mean(d4.Volt_2));

Ipeak40 = 2*sqrt(3)*sqrt(sum(Iripple40.^2)/length(Iripple40));
Ipeak60 = 2*sqrt(3)*sqrt(sum(Iripple60.^2)/length(Iripple60));
Ipeak80 = 2*sqrt(3)*sqrt(sum(Iripple80.^2)/length(Iripple80));
Ipeak100= 2*sqrt(3)*sqrt(sum(Iripple100.^2)/length(Iripple100));

Ipeak = [Ipeak40,Ipeak60,Ipeak80,Ipeak100];

fstep = [40,60,80,100];

% theoretical

fsw = linspace(40e3,100e3,601);
D = 0.5;
Vout=Vin*D;
dt = 1./fsw*D;
ILripple = 1/L*(Vin-Vout)*dt;
Q = 1./2*ILripple./2.*1./(2.*fsw);
VCripple = Q./C;

fig = figure(200);
plot(fsw/1000,ILripple,'LineWidth',2)
hold on
scatter(fstep,Ipeak,'*')
hold off
grid on
legend('Theoretical', 'Measured');
xlabel('f_{sw} [kHz]')
ylabel('I_{L,ripple} [A]') 
set(gca,'fontsize', 10);
saveFig(fig,'Ilripple',400)


fig = figure(210);
plot(f'/1000,[1000*abs(H1)',1000*abs(H2)',1000*abs(H3)',1000*abs(H4)'],'LineWidth',2)
hold on
scatter(fstep,1000*Vpeak,'*')
hold off
grid on
legend(["10m\Omega","0.5\Omega","5\Omega","15\Omega","Measured"])
xlabel('f_{sw} [kHz]')
ylabel('V_{C,ripple} [mV]') 
xlim([40 100])
set(gca,'fontsize', 10);
saveFig(fig,'Vcripple',400)


%% 4.Attach a copy of the inductor current waveforms obtained in section 2.5.3.
% Compare the theoretically calculated Rcrit with the observed value.

d10 = readtable('253-10.csv', 'HeaderLines', 1);
d40 = readtable('253-40.csv', 'HeaderLines', 1);
d50 = readtable('253-50.csv', 'HeaderLines', 1);
d100 = readtable('253-100.csv', 'HeaderLines', 1);
%lines(4)
fig = figure(120);
plot(10^6 * (d10.second-d10.second(1)),2 * d10.Volt_2,'LineWidth',2);
hold on
plot(10^6 * (d40.second-d40.second(1)),2 * d40.Volt_2,'LineWidth',2);
plot(10^6 * (d50.second-d50.second(1)),2 * d50.Volt_2,'LineWidth',2);
plot(10^6 * (d10.second-d100.second(1)),2 * d100.Volt_2,'LineWidth',2);

legend({'I_L(R_L=10\Omega)','I_L(R_L=40\Omega)','I_L(R_L=50\Omega)','I_L(R_L=100\Omega)'},'Location','best')
%legend('boxoff')
ylabel('I [A]')
xlabel('t [\mus]')
hold off
grid()
set(gca,'fontsize', 20);
saveFig(fig,'264_I_L_vs_t',200)


%% Efficiency
d40 = readtable('254-40.csv', 'HeaderLines', 1);
d100 = readtable('254-100.csv', 'HeaderLines', 1);

V_o_40_avg = mean(d40.Volt); 
V_i_40_avg = mean(d40.Volt_1); 
I_o_40_avg = mean(2*d40.Volt_2);
I_i_40_avg = mean(2*d40.Volt_3);

V_o_100_avg = mean(d100.Volt); 
V_i_100_avg = mean(d100.Volt_1); 
I_o_100_avg = mean(2*d100.Volt_2);
I_i_100_avg = mean(2*d100.Volt_3);

P_o_40 = V_o_40_avg*I_o_40_avg;
P_i_40 = V_i_40_avg*I_i_40_avg;
eta_40_1 = P_o_40/P_i_40

P_o_40_avg = mean(d40.Volt.*(2*d40.Volt_2));
P_i_40_avg = mean(d40.Volt_1.*(2*d40.Volt_3));
%eta_40_3 = P_o_40_avg/P_i_40_avg


V_o_100_avg = mean(d100.Volt); 
V_i_100_avg = mean(d100.Volt_1); 
I_o_100_avg = mean(2*d100.Volt_2);
I_i_100_avg = mean(2*d100.Volt_3);

V_o_100_avg = mean(d100.Volt); 
V_i_100_avg = mean(d100.Volt_1); 
I_o_100_avg = mean(2*d100.Volt_2);
I_i_100_avg = mean(2*d100.Volt_3);

P_o_100 = V_o_100_avg*I_o_100_avg;
P_i_100 = V_i_100_avg*I_i_100_avg;
eta_100_1 = P_o_100/P_i_100

P_o_100_avg = mean(d100.Volt.*(2*d100.Volt_2));
P_i_100_avg = mean(d100.Volt_1.*(2*d100.Volt_3));
%eta_100_3 = P_o_100_avg/P_i_100_avg



fig = figure(7);
legend('-DynamicLegend');
yyaxis left
plot(10^6 * (d40.second-d40.second(1)),[d40.Volt],'Color',[0,0.4470,0.7410],'LineWidth',2,'LineStyle','-','DisplayName','V_{out}')
hold on
ylabel('V [V]')
plot(10^6 * (d40.second-d40.second(1)),[d40.Volt_1],'Color',[0.8500,0.3250,0.0980],'LineWidth',2,'LineStyle','-','DisplayName','V_{in}')
hold off
yyaxis right
plot(10^6 * (d40.second-d40.second(1)),[2*d40.Volt_2],'Color',[0.9290,0.6940,0.1250],'LineWidth',2,'LineStyle','-','DisplayName','I_{out}')
hold on
plot(10^6 * (d40.second-d40.second(1)),[2*d40.Volt_3],'Color',[0.4940,0.1840,0.5560],'LineWidth',2,'LineStyle','-','DisplayName','I_{out}')
grid on
hold off
ylabel('I [A]')
xlabel('t [\mu s]')
set(gca,'fontsize', 20);
saveFig(fig,'265_40',200);



fig = figure(8);
legend('-DynamicLegend');
yyaxis left
plot(10^6 * (d100.second-d100.second(1)),[d100.Volt],'Color',[0,0.4470,0.7410],'LineWidth',2,'LineStyle','-','DisplayName','V_{out}')
hold on
ylabel('V [V]')
plot(10^6 * (d100.second-d100.second(1)),[d100.Volt_1],'Color',[0.8500,0.3250,0.0980],'LineWidth',2,'LineStyle','-','DisplayName','V_{in}')
hold off
yyaxis right
plot(10^6 * (d100.second-d100.second(1)),[2*d100.Volt_2],'Color',[0.9290,0.6940,0.1250],'LineWidth',2,'LineStyle','-','DisplayName','I_{out}')
hold on
plot(10^6 * (d100.second-d100.second(1)),[2*d100.Volt_3],'Color',[0.4940,0.1840,0.5560],'LineWidth',2,'LineStyle','-','DisplayName','I_{out}')
grid on
hold off
ylabel('I [A]')
xlabel('t [\mu s]')
set(gca,'fontsize', 20);
saveFig(fig,'265_100',200);



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

%% 4.Attach a copy of the inductor current waveforms obtained in section 2.5.3.
% Compare the theoretically calculated Rcrit with the observed value.

d10 = readtable('253-10.csv', 'HeaderLines', 1);
d40 = readtable('253-40.csv', 'HeaderLines', 1);
d50 = readtable('253-50.csv', 'HeaderLines', 1);
d100 = readtable('253-100.csv', 'HeaderLines', 1);

fig = figure(120);
scatter(10^6 * (d10.second-d10.second(1)),2 * d10.Volt_2,'LineWidth',2);
hold on
scatter(10^6 * (d40.second-d40.second(1)),2 * d40.Volt_2,'LineWidth',2);
scatter(10^6 * (d50.second-d50.second(1)),2 * d50.Volt_2,'LineWidth',2);
scatter(10^6 * (d10.second-d100.second(1)),2 * d100.Volt_2,'LineWidth',0.5);

legend('I_L (R_L = 10\Omega)','I_L (R_L = 40\Omega)','I_L (R_L = 50\Omega)','I_L (R_L = 100\Omega)')
ylabel('V [V]')
xlabel('t [\mu s]')
hold off
set(gca,'fontsize', 20);
saveFig(fig,'264_I_C_vs_t',200)
%% Buck
d1 = readtable('251del2-10.csv', 'HeaderLines', 1);
d2 = readtable('252-100.csv', 'HeaderLines', 1);
d3 = readtable('253-40.csv', 'HeaderLines', 1);
d4 = readtable('254-100.csv', 'HeaderLines', 1);

% Boost
d5 = readtable('451-50.csv', 'HeaderLines', 1);
d6 = readtable('452-60.csv', 'HeaderLines', 1);
d7 = readtable('453-100.csv', 'HeaderLines', 1);
%  Buck

figure(1)
plot(d1.second,[d1.Volt,d1.Volt_1,d1.Volt_2],'LineWidth',5)
legend('Vout','PWM','Vd')
grid()

figure(2)
plot(d2.second,[d2.Volt,d2.Volt_1,d2.Volt_2,d2.Volt_3],'LineWidth',5)
legend('Vout','PWM','Il', 'Ic')
grid()

figure(3)
plot(d3.second,[d3.Volt,d3.Volt_1,d3.Volt_2],'LineWidth',5)
legend('Vout','PWM','Il')
grid()

figure(4)
plot(d4.second,[d4.Volt,d4.Volt_1,d4.Volt_2,d4.Volt_3],'LineWidth',5)
legend('Vout','Vin','Iout','Iin')
grid()

% Boost
figure(5)
plot(d5.second,[d5.Volt,d5.Volt_1],'LineWidth',5)
legend('Vout','PWM')
grid()


figure(6)
plot(d6.second,[d6.Volt,d6.Volt_1,d6.Volt_2],'LineWidth',5)
legend('Vout','PWM','Iin')
grid()

figure(7)
plot(d7.second,[d7.Volt,d7.Volt_1,d7.Volt_2,d7.Volt_3],'LineWidth',5)
legend('Vout','Vin','Iout','Iin')
grid()

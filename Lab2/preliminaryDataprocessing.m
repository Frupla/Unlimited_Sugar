 %% 8.5.1
clear
d1 = readtable('data\851-00.csv','HeaderLines',1);
d2 = readtable('data\851-10.csv','HeaderLines',1);
d3 = readtable('data\851-20.csv','HeaderLines',1);
d4 = readtable('data\851-30.csv','HeaderLines',1);
d5 = readtable('data\851-40.csv','HeaderLines',1);
d6 = readtable('data\851-50.csv','HeaderLines',1);

v = [mean(d1.Volt_1),mean(d2.Volt_1),mean(d3.Volt_1),mean(d4.Volt_1),mean(d5.Volt_1),mean(d6.Volt_1)];
pwm = [0,0.1,0.2,0.3,0.4,0.5];

figure(1)
plot(pwm,v)

%% 8.5.2
clear
d1 = readtable('data\852-75-100.csv','HeaderLines',1);
d2 = readtable('data\852-75-040.csv','HeaderLines',1);
d3 = readtable('data\852-10-100.csv','HeaderLines',1);
d4 = readtable('data\852-10-040.csv','HeaderLines',1);
d5 = readtable('data\852-mos.csv','HeaderLines',1);


%pwm,Vsec,Iout,Iin
figure(1)
plot(d1.second,d1.Volt_1)

figure(2)
plot(d1.second,2*[d1.Volt_2,d1.Volt_3])
legend('out','in')


figure(3)
plot(d5.second,[d5.Volt,d5.Volt_1]);

%% 9.5.1
clear
d1 = readtable('data\951-00.csv','HeaderLines',1);
d2 = readtable('data\951-10.csv','HeaderLines',1);
d3 = readtable('data\951-20.csv','HeaderLines',1);
d4 = readtable('data\951-30.csv','HeaderLines',1);
d5 = readtable('data\951-40.csv','HeaderLines',1);

v = [mean(d1.Volt_1),mean(d2.Volt_1),mean(d3.Volt_1),mean(d4.Volt_1),mean(d5.Volt_1)];
pwm = [0,0.1,0.2,0.3,0.4];

figure(1)
scatter(pwm,v)

%% 9.5.2
clear
d1 = readtable('data\952-75-100.csv','HeaderLines',1);
d2 = readtable('data\952-75-040.csv','HeaderLines',1);
d3 = readtable('data\952-10-100.csv','HeaderLines',1);
d4 = readtable('data\952-10-040.csv','HeaderLines',1);
d5 = readtable('data\952-Il.csv','HeaderLines',1);

%t, pwm,Vmos,Iout,Iin (d1-4)
%t, Iout, Ic
figure(1)
plot(d1.second,d1.Volt_1)

figure(2)
plot(d1.second,2*[d1.Volt_2,d1.Volt_3])
legend('out','in')

figure(3)
plot(d5.second,[2*d5.Volt,10*d5.Volt_1]);

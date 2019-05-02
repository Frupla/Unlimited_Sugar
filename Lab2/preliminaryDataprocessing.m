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

Vin = 20;
d = 0.4;

%t, pwm,Vmos,Iout,Iin (d1-4) 
%t, Iout, Ic d5
figure(1)
plot(adjustTime(d1.second),2*[d1.Volt_2,d2.Volt_2,d3.Volt_2,d4.Volt_2,d5.Volt])
legend('7.5,100','7.5,40','10,100','10,40','??')

figure(2)
plot(adjustTime(d1.second),2*[d1.Volt_3,d2.Volt_3,d3.Volt_3,d4.Volt_3])
legend('7.5,100','7.5,40','10,100','10,40')

t = adjustTime(d5.second)*1e-6;

%% @ 10ohm, 40Hz

Il = 2*d5.Volt+10*d5.Volt_1;


[L1] = findLlab2(d5.second,Il,(1-d)*Vin,[d5.second(1) d5.second(400)]);
[L2] = findLlab2(d5.second,Il,d*Vin,[d5.second(400) d5.second(1000)]);
[L3] = findLlab2(d5.second,Il,(1-d)*Vin,[d5.second(1000) d5.second(1400)]);
[L4] = findLlab2(d5.second,Il,d*Vin,[d5.second(1400) d5.second(2000)]);

L1040 = (abs(L1)+abs(L2)+abs(L3)+abs(L4))/4;



%% @ 7.5ohm, 40Hz We can't even do this I realize

Il = 2*d4.Volt_2+10*d5.Volt_1;
tempV = [(1-d)*Vin*ones(1,d*1000),d*Vin*ones(1,(1-d)*1000)];
Vl = [tempV,tempV]';
clear tempV;

[L1] = findLlab2(d5.second,Il,(1-d)*Vin,[d5.second(1) d5.second(400)]);
[L2] = findLlab2(d5.second,Il,d*Vin,[d5.second(400) d5.second(1000)]);
[L3] = findLlab2(d5.second,Il,(1-d)*Vin,[d5.second(1000) d5.second(1400)]);
[L4] = findLlab2(d5.second,Il,d*Vin,[d5.second(1400) d5.second(2000)]);

L7540 = (abs(L1)+abs(L2)+abs(L3)+abs(L4))/4;

%% Gettin Ic@100kHz through shady methods:
C = 100*10^-6;
f = 40*10^3;

Ic40 = medfilt1(d5.Volt_1*10,13);
figure(1)
plot(t,Ic40)
Icpeak = max(Ic40)-min(Ic40);



%%
im1 = -0.274; %100,10
im2 = -0.264; %100,7.5
im3 = -0.851; %40, 10
im4 = -0.861; %40, 7.5

%im1 = min(2*d1.Volt_3);
%im2 = min(2*d2.Volt_3);
%im3 = min(2*d3.Volt_3);
%im4 = min(2*d4.Volt_3);

L1m = 0.2*10^-3;
N1 = 16;
Rm = N1^2/L1m;

flux1 = N1*im1/Rm;
flux2 = N1*im2/Rm;
flux3 = N1*im3/Rm;
flux4 = N1*im4/Rm;


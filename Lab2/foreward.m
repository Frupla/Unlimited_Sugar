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



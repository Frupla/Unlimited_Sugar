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

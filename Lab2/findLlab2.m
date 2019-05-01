function [L,fig]=findLlab2(x,y,V,range)
% fits y=a*x+b in the specified range.
% it is assumed that this is a current through an inductor.
% the inductor value is found as L=V/a. Here V is the voltage over the
% inductor.
% The range should be given as range=[lower_limit upper_limit].
%
% If a second output is enabled, a figure showing the fit is generated
fitx=x(x>=range(1) & x<=range(2));
fity=y(x>=range(1) & x<=range(2));
model=fit(fitx,fity,'poly1');
L=V/model.p1;
if nargout==2
    fig=figure;
    hold on
    plot(x,y,'LineWidth',1.5)
    plot(model)
    grid on
    ylim([min(y)-abs(min(y))*0.1 max(y)+abs(max(y))*0.1])
end
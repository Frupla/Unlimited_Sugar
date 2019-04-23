function saveFig(f, p, h)
%SAVEFIG  Figure Exporter
%   SAVEFIG(f, p, h) saves the figure 'f' to path 'p' with format
%   'exportstyle.mat'
%   As optional input, one can set the height 'h' of the figure.
%

%   Copyright 2018-inf

    s = load('exportstyle.mat');
    s = s.s;
    if nargin == 3
        s.Height = h;
    end
    applyStyle(f, s);
    % hgexport(f,'_',s,'applystyle',true);
    saveas(f,p,'epsc')
end


function applyStyle(f, s)
    hgexport(f,'_',s,'applystyle',true);
end
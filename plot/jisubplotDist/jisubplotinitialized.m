function [ out ] = jisubplotinitialized( plotfig )
%% Checks whether current figure is jissubplot initialized
% by behigner
if nargin==0
    plotfig = gcf;
end
try
	UD = getappdata(plotfig,'JRI_jisubplotData');
catch
	UD = get(plotfig,'userdata');
end
out = ~isempty(UD);
end


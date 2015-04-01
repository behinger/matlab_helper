function [  ] = be_figSameCaxis(f )
%BE_FIGSSAMEAXES Summary of this function goes here
%   Detailed explanation goes here
if nargin <1
f = gcf;
end

axes = findobj(f,'Type','axes');
tmp = caxis;
for K = 1:length(axes)
caxis(axes(K),tmp);
end

end


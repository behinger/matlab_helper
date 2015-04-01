function TT = be_permTable(N)
%% function tabl = be_permTable(N) 
% Taken from comment of Josh 10584
% http://www.mathworks.com/matlabcentral/fileexchange/27835-truth-table
TT = dec2bin(0:(2.^N)-1)-'0';
end
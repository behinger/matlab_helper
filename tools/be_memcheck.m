function [] = be_memcheck(memneed,times,warnOnly)
%% function [] = be_memcheck(memneed,times,warnOnly)
%BE_CHECKMEM Summary of this function goes here
%   Detailed explanation goes here

if length(memneed) ~= 1
    dt=whos('memneed');
    memneed=round(dt.bytes*9.53674e-7);
    
end
memFree = be_memfree;
if memFree < memneed * times*1.1
    if nargin ==3 && warnOnly
        warning('Possible Insufficient Memory: %.0f free %.0f needed \n',memFree,memneed*times*1.1)
    else
        error('Possible Insufficient Memory: %.0f free %.0f needed \n',memFree,memneed*times*1.1)
        
    end
end


end


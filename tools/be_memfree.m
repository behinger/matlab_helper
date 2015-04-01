function [memFree memStats] = be_memfree()
%% function [memFree memStats] = be_memfree()
% Originally but strongly modofied by behinger: Copyright (c) 2012, Michael Hirsch
%All rights reserved.
%
%Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
%
% Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
% Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
%
%THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.


if ispc % assumes windows, no mac
    [user sys] = memory;
    memStats.totalMB = sys.PhysicalMemory.Total/1024^2;
    memStats.usedMB = user.MemUsedMATLAB/1024^2;
    memStats.freeMB = sys.PhysicalMemory.Available/1024^2;
    memFree = memStats.freeMB;
    
elseif isunix
       
    
    [sts(1),msg] = unix('free -m | head -n2 | tail -1');
    [sts(1),msg2] = unix('free -m | head -n3 | tail -1');
    if any(sts) %error
        memStats.error = true;
        return
    else %no error
        mems = cell2mat(textscan(msg,'%*s %u %u %u %*u %*u %*u','delimiter',' ','collectoutput',true,'multipleDelimsAsOne',true));
        memStats.totalMB = double(mems(1));
        memStats.withCacheFree = double(mems(3));
        
        mems = cell2mat(textscan(msg2,'%*s %*s %u %u %*u %*u %*u','delimiter',' ','collectoutput',true,'multipleDelimsAsOne',true));
        memStats.usedMB = double(mems(1));
        memStats.freeMB = double(mems(2));
        memStats.error = false;
        
        memFree = memStats.freeMB;
    end
    
else
    error('not implemented')
    
end %function




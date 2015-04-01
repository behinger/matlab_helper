function [sparse] = p2_sparsify(inp,~)
%function [sparse] = p2_sparsify(inp,dS)
% Sparsifies the input coherence. Inputs are: inp is a (AxBxCxDxD) or (AxBxCxC) matrix
% where DxD will be sparsified
if nargin == 1
    dS = length(size(inp))-2;
end
if dS == 3
    
    sparse = [];
    for i = 1:size(inp,1)
        for l = 1:size(inp,2)
            for k=1:size(inp,3)
                
                indx = logical(tril(ones(size(inp,length(size(inp))-1)),-1));
                sparse(i,l,k,:) = inp(i,l,k,indx);
            end
        end
    end
elseif dS == 2
    sparse = [];
    for i = 1:size(inp,1)
        for l = 1:size(inp,2)
            
            
            indx = logical(tril(ones(size(inp,length(size(inp))-1)),-1));
            sparse(i,l,:) = inp(i,l,indx);
        end
        
    end
    
else
    error('not supported')
end

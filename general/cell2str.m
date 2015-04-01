function [s]=cell2str(c,varargin)
%[s]=cell2str(c,varargin)
%[s]=cell2str(c,SeparatorString,PrintFormatString)
%
% Concatenetes in a serial manner the contents of the cell array after
% transforming them to a string array. By default it inserts '_' after each
% concatenation. This default behaviour can be changed with the varargin.
%
% PrintFormat is passed to num2str
%
%Selim, 30-Nov-2006
%Selim, 15-Jan-2007 16:24:05, optionality for string format is implemented
%Selim, 20-Jul-2007 13:04:19, modified how the function handles are dealt
%with. See comments below.


%default settings
sepa   = '_';
format = '%g';

if ~isempty(c)
    if ~isempty(varargin)
        if nargin == 2
            if ~isempty(varargin{1})
                sepa = varargin{1};
            end

        elseif nargin ==3
            if ~isempty(varargin{2});
                format = varargin{2};
            end
            if ~isempty(varargin{1})%if varargin{1} is empty we have to put it by hand
                if ~isempty(varargin{1})
                    sepa = varargin{1};
                end
            end
        end
    end

    s = [];
    %main loop over the entries of the cell array C
    for n = 1:length(c)

        %we need to convert to string all the function handles which
        %might possibly be in one of the cell arrays. The reason is
        %that num2str does not manage them.
        if isa(c{n},'function_handle')
 [c{n}]=Repair_FunctionHandle(c{n});%transform c{n} 2 a str if it is f.handle
        end
        %
        if iscell(c{n})%if one of the varargins is already a cell array this
            %makes num2str crash, so first we have to get rid of all the
            %cell containing varargin entries. and we put minus between
            %the the contents of each cell.
            dummy = [];
            for nc = 1:length(c{n});
                if isa(c{n}{nc},'function_handle');                                        
                    [dummy] = [dummy '_' Repair_FunctionHandle(c{n}{nc})];
                else
                    [dummy] = [dummy '_' num2str(c{n}{nc})];
                end                
            end
            dummy(1)  = [];%remove the first char. which is a underscore..
            dummy(dummy == ' ') = [];
            c{n} = dummy;
        end
        
        if n == 1
            s = num2str(c{n},format);
        else
            s= [s sepa num2str(c{n}(:)',format)];
        end
    end
    %remove all the dots from the shit
    s(s=='.') = [];
    s(s==' ') = [];
else
    s =[];
end


    function [X]=Repair_FunctionHandle(X);
            X = ['@' func2str(X)];
            %when you enter something like that @(i) i; somehow the @ sign
            %is doubled after func2str function. Surprisingly this is not
            %the case for cases such as @mean, @max etc. This following if
            %loop removes that additional @ sign. And the second if loop
            %removes any space if there are.
            if strcmp(X(2),'@');
                X(2) = [];
            end
            if sum(X == ' ');
                X(X == ' ' ) = [];
            end
    end

end
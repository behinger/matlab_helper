function [x] = winMean(x,dim,percent)
%% function [x] = winMean(x,dim,percent)
% 
%
% Taken and adapted strongly from LIMO toolbox (2014)
% Copyright LIMO Team 2010
% Original code provided by Prof. Patrick J. Bennett, McMaster University
% made 3D: GAR - University of Glasgow - 7 Dec 2009

if nargin<3;percent=20;end
if length(x) ==1
    return
end
if isempty(x) 
    error('Vector should not be empty or length = 1');
end

if (percent >= 100) || (percent < 0)
    error('PERCENT must be between 0 and 100, is: %.2f',percent);
end
if nargin == 1
  dim = find(size(x)~=1,1,'first'); 
  if isempty(dim), dim = 1; end
end
% number of trials
n=size(x,dim);

% number of items to winsorize and trim
g=floor((percent/100)*n);

% permuteOrder = [dim notDim];
% orgSize = size(x);
% xsort = permute(x,permuteOrder); % make the first dimension the one to do the thing over

% winsorise x
x=sort(x,dim); % now sort over first dimension
% wx=xsort;
% Prepare Structs
Srep.type = '()';
S.type = '()';

% replace the left hand side
nDim = length(size(x));

beforeColons = num2cell(repmat(':',dim-1,1));

afterColons  = num2cell(repmat(':',nDim-dim,1));
Srep.subs = {beforeColons{:} [g+1]    afterColons{:}};
S.subs    = {beforeColons{:} [1:g+1]  afterColons{:}};
x = subsasgn(x,S,repmat(subsref(x,Srep),[ones(1,dim-1) g+1 ones(1,nDim-dim)])); % general case

% replace the right hand side
Srep.subs = {beforeColons{:} [n-g]            afterColons{:}};
S.subs    = {beforeColons{:} [n-g:size(x,dim)]  afterColons{:}};

x = subsasgn(x,S,repmat(subsref(x,Srep),[ones(1,dim-1) g+1 ones(1,nDim-dim)])); % general case
% wx(:,1:g+1)=repmat(xsort(:,g+1),[1 g+1]); %dim = 2 case
% wx(:,n-g:end)=repmat(xsort(:,n-g),[1 g+1]); % dim =2 case

% wvarx=squeeze(std(x,0,dim));
x = squeeze(nanmean(x,dim));




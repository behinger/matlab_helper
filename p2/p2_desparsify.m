function [dat] = p2_desparsify(dat)
% p2_desparsify(sparsified_data)
% Taken and adapted from Pang's code


sz = size(dat);	%expect([f, t, pair])

if sz(end) == sz(end-1)
   error('input is already de-sparsified?') 
end
id = sz(1 : end - 1);
nPairs = sz(end);
tmpData1 = reshape(dat, [prod(id), nPairs]);
nUnits = nPair2nUnit(nPairs);
if abs(round(nUnits) - nUnits) > 1/10000	%not an integer
    error('The number of location pairs seems wierd, please have a double check!');
end
[p, nPairs] = unit2pair(nUnits);

tmpData2 = nan([prod(id), nUnits, nUnits]);
for iPair = 1 : nPairs
    tmpData2(:, p(iPair, 2), p(iPair, 1)) = tmpData1(:, iPair);
    tmpData2(:, p(iPair, 1), p(iPair, 2)) = tmpData1(:, iPair);
end

dat = reshape(tmpData2, [id, nUnits, nUnits]);

end

function y = nPair2nUnit(x)

	y = sqrt(x * 2 + .25) + .5;

end


function [pairs, nPairs] = unit2pair (nUnits)

	nPairs = nUnits * (nUnits - 1) / 2;
	pairs = zeros(nPairs, 2);
	ct = 0;
	for ch1 = 1 : nUnits - 1
		idx = ct + 1 : ct + nUnits - ch1;
		ct = ct + nUnits - ch1;
		pairs(idx, 1) = ch1 + 1 : nUnits ;
		pairs(idx, 2) = ch1;
	end

end
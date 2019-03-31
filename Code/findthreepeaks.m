function [pks, locs]= findthreepeaks(sig, mindistance)
%find three or less peaks with the highest power
[pks, locs] = findpeaks(sig, 'minpeakdistance', mindistance, 'sortstr', 'ascend');
if length(pks) >= 3
    pks = pks(end-2:end);
    locs = locs(end-2:end);
end
[locs_sorted, indices] = sort(locs);
locs = locs_sorted;
pks = pks(indices);
end
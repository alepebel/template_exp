
function [ordr] = sort_runs (x)

c = sort(x);

ordr = [];    % Useful function to organize as a function of time the runs.

for idd = 1: length(x);
    id  = find(c(idd)==x);
    ordr = [ordr id];  %the function returns in ascending order
end
function [resids] = gausscdf(x0,P_C,Fc)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% psychometric function with performance constrained to be between 0 and
% 1 (see Yau et al., 2009a; Yau et al., 2010)
%
% p(Fc > Fs) = 1 / (1 + e^(Fc - mu)/sigma) 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

MU          = x0(1);
SIGMA       = x0(2); 


pred_perf =  0.5*(1 + erf((Fc - MU)/SIGMA/sqrt(2)));


if(length(P_C(:,1))~=length(pred_perf(:,1)))
    pred_perf = pred_perf';
end

resids = P_C - pred_perf;


return;


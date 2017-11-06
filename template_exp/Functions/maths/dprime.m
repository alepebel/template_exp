
function [d,beta] = dprime(pHit,pFA)

%-- Convert to Z scores, no error checking
zHit = norminv(pHit) ;
zFA  = norminv(pFA) ;

%-- Calculate d-prime
d = zHit - zFA ;

%-- If requested, calculate BETA
if (nargout > 1)
  yHit = normpdf(zHit) ;
  yFA  = normpdf(zFA) ;
  beta = yHit ./ yFA ;
end

%%  Return DPRIME and possibly BETA
%%%%%% End of file DPRIME.M
jitter = 0.25  

y = 0;
while y == 0
x     = jitter + (-jitter-jitter)*rand(1,3);
x4    = 0-sum(x);
x     = [x x4];
z     = find(x<-jitter | x>jitter);
y     = isempty(z); %maximum and miminum value of the last element generated

end

idx = randperm(length(x));  %rearranging the order of the elements
x = x(idx);
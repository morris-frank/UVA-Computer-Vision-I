function map = map(r, m)

n = size(r);
s = 0;
for i=1:n
    if r(i) == 1
        s = s + sum(r(1:i))/i;
    end
end
map = s/m;
end
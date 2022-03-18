preamble;
s = "The quick brown fox jumps over the lazy dog"
strarr = strsplit(s);
lenarr = strlength(strarr);
s1 = strarr(find(lenarr==min(lenarr), 1))
s2 = strarr(find(lenarr==max(lenarr), 1, 'last' ))
s3 = join([upper(strarr(1)), strarr(2:end)])
s4 = join([strarr(1:end-1), upper(strarr(end))])
shortarr = strarr(lenarr <5);
[~, sortind] = sort(lower(shortarr));
s5 = shortarr(sortind)
s6 = strarr(contains(strarr,'e'))
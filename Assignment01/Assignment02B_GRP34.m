preamble;
[numbers, check] = deal(1:1:1000, 4:2:1000);
primes = numbers(isprime(numbers))
sumprime = sort(unique(reshape((primes+primes.')',[],1)'))
sumprime = sumprime(sumprime <= 1000)
assert(all(ismember(check,sumprime)))
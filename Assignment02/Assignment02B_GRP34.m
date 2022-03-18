preamble;
N = 1000;
[numbers, check] = deal(1:1:N, 4:2:N);
primes = numbers(isprime(numbers));
primesums = sort(unique(reshape((primes+primes.')',[],1)'));
primesums = primesums(primesums <= N);
assert(all(ismember(check,primesums)))
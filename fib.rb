fib = Hash.new{ |cache,n| cache[n] = fib[n - 1] + fib[n - 2]}
fib[0] = 0
fib[1] = 1

p fib[1000]

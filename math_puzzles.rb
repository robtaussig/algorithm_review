require 'byebug'

def sieve_of_eratosthenes(max)
  nums = (2..max).to_a
  current_prime = 2
  primes = []
  until nums.length == 1
    count = nums.length - 1
    while count >= 0
      if nums[count] % current_prime == 0
        primes << nums[count] if count == 0
        nums.delete_at(count)
      end
      count -= 1
    end
    system('clear')
    p primes
    current_prime = nums.first
  end
  primes
end

sieve_of_eratosthenes(10000)

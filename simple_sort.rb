require_relative 'lib/concurrent_sort'

out = ConcurrentSort::sort([4, 5, -1, 2, 4])
puts out.to_s
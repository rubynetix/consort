require_relative 'lib/concurrent_sort'

include ConcurrentSort
test = [-2, 3, 10, -1, -8, 10, -10, 1, 4, -1] # Array.new(10) { rand(-10..10) }
puts test.to_s
out = ConcurrentSort::sort(test)
puts out.to_s

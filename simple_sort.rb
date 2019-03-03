require_relative 'lib/concurrent_sort'

include ConcurrentSort

test = Array.new(4000000) { rand(-100000..100000) }
# puts test.to_s
out = ConcurrentSort::sort(test)
# puts out.to_s
puts out.size

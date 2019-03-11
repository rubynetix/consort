require_relative 'lib/concurrent_sort'

include ConcurrentSort

data = Array.new(400000) {rand(-100000..100000)}
duration = 10

begin
  out = ConcurrentSort::sort(data, duration)
  puts out.to_s
rescue DurationTooShortError
  puts "Longer duration needed"
end

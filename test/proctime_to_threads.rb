require 'benchmark'
require_relative '../lib/concurrent_sort'
require_relative '../lib/merge_sort_concurrent'

module TestUtil
  MIN_VAL = -10_000
  MAX_VAL = 10_000
  MAX_LEN = 100_000

  # Generate elements of any type with block
  def rand_array(size: rand(1..MAX_LEN))
    Array.new(size) {yield}
  end

  def rand_int_array(size: rand(1..MAX_LEN), range: MIN_VAL..MAX_VAL)
    rand_array(size: size) {rand(range)}
  end
end

include TestUtil

(20_000..1_000_000).step(20000) do |n|
    min = 1000
    fanout = 200

    arr = TestUtil.rand_int_array(size: n)

    ths = (n / min + Math.log(n, fanout)).ceil

    proc_time = Benchmark.measure do
      ConcurrentSort.sort(arr, fan_out: fanout, min: min)
    end

    puts "#{ths}, #{proc_time.real}"
end

require 'test/unit'
require_relative '../lib/concurrent_sort'

class MergeSortTest < Test::Unit::TestCase

  TEST_ITER = 10
  MIN_VAL = -10_000
  MAX_VAL = 10_000
  MAX_LEN = 10_000

  def setup; end

  def teardown; end

  def assert_invariants; end

  def assert_sorted(arr)
    (0...arr.length-1).each {|i| yield(arr[i], arr[i + 1])}
  end

  def rand_array(size: rand(1..MAX_LEN), range: MIN_VAL..MAX_VAL)
    Array.new(size) {rand(range)}
  end

  def test_stream_sort; end

  def test_sort
    (0..TEST_ITER).each do
      arr = rand_array

      # Preconditions
      begin
      end

      sorted_arr = ConcurrentSort.sort(arr)

      # Postconditions
      begin
        assert_sorted(sorted_arr) {|first, second| assert_true(first <= second, "Array not sorted: failed #{first} is not <= #{second}")}
      end
    end
  end
end

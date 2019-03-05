require 'test/unit'
require_relative '../lib/concurrent_sort'
require_relative '../lib/merge_sort_concurrent'
require_relative 'utils/car'

class MergeSortTest < Test::Unit::TestCase
  TEST_ITER = 10
  MIN_VAL = -10_000
  MAX_VAL = 10_000
  MAX_LEN = 100_000

  def setup; end

  def teardown; end

  def assert_invariants; end

  def assert_sorted(arr)
    (0...arr.length - 1).each {|i| yield(arr[i], arr[i + 1])}
  end

  # Generate elements of any type with block
  def rand_array(size: rand(1..MAX_LEN))
    Array.new(size) {yield}
  end

  def rand_int_array(size: rand(1..MAX_LEN), range: MIN_VAL..MAX_VAL)
    rand_array(size: size) {rand(range)}
  end

  def test_stream_sort; end

  def test_sort
    (0..TEST_ITER).each do
      arr = rand_int_array

      # Preconditions
      begin
        arr.each {|el| el.is_a?(Comparable)}
      end

      sorted_arr = ConcurrentSort.sort(arr)

      # Postconditions
      begin
        assert_sorted(sorted_arr) {|first, second| assert_true(first <= second, "Array not sorted: failed #{first} is not <= #{second}")}
      end
    end
  end

  def test_sort_block
    (0..TEST_ITER).each do
      arr = rand_int_array

      # Preconditions
      begin
        arr.each {|el| el.is_a?(Comparable)}
      end

      sorted_arr = ConcurrentSort.sort(arr) {|first, second| -(first <=> second)}

      # Postconditions
      begin
        assert_sorted(sorted_arr) {|first, second| assert_true(first >= second, "Array not sorted: failed #{first} is not >= #{second}")}
      end
    end
  end

  def test_sort_custom_obj
    (0..TEST_ITER).each do
      arr = rand_array {Car.new}

      # Preconditions
      begin
        arr.each {|el| el.is_a?(Comparable)}
      end

      sorted_arr = ConcurrentSort.sort(arr)

      # Postconditions
      begin
        assert_sorted(sorted_arr) {|first, second| assert_true(first.wheels <= second.wheels, "Cars not sorted: #{first.wheels} wheels is not >= #{second.wheels} wheels")}
      end
    end
  end

  def test_too_many_threads
    (0..TEST_ITER).each do
      arr = rand_int_array(size: MAX_LEN)
      fan_out = 2
      threshold = 1

      # Preconditions
      begin
        assert_true(MergeSortConcurrent.num_threads(arr.length, fan_out, threshold) > MergeSortConcurrent::MAX_THREADS)
      end

      assert_raise(MergeSortConcurrent::InvalidSortConfiguration) { MergeSortConcurrent.new(arr, [], fan_out: fan_out, min: threshold)}

      # Postconditions
      begin
      end
    end
  end
end

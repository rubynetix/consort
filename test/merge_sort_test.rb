require 'test/unit'
require 'benchmark'
require_relative '../lib/concurrent_sort'
require_relative 'utils/car'

class MergeSortTest < Test::Unit::TestCase
  TEST_ITER = 1
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
    TEST_ITER.times.each do
      arr = rand_int_array
      arr_orig = arr.dup

      # Preconditions
      begin
        arr.each {|el| assert_true(el.is_a?(Comparable))}
      end

      sorted_arr = ConcurrentSort.sort(arr)

      # Postconditions
      begin
        assert_equal(arr_orig, arr, "Error: original array was modified")
        assert_sorted(sorted_arr) {|first, second| assert_true(first <= second, "Array not sorted: failed #{first} is not <= #{second}")}
      end
    end
  end

  def test_sort_block
    TEST_ITER.times do
      arr = rand_int_array
      arr_orig = arr.dup

      # Preconditions
      begin
        arr.each {|el| assert_true(el.is_a?(Comparable))}
      end

      sorted_arr = ConcurrentSort.sort(arr) {|first, second| -(first <=> second)}

      # Postconditions
      begin
        assert_equal(arr_orig, arr, "Error: original array was modified")
        assert_sorted(sorted_arr) {|first, second| assert_true(first >= second, "Array not sorted: failed #{first} is not >= #{second}")}
      end
    end
  end

  def test_sort_custom_obj
    TEST_ITER.times do
      arr = rand_array {Car.new}
      arr_orig = arr.dup

      # Preconditions
      begin
        arr.each {|el| assert_true(el.is_a?(Comparable))}
      end

      sorted_arr = ConcurrentSort.sort(arr)

      # Postconditions
      begin
        assert_equal(arr_orig, arr, "Error: original array was modified")
        assert_sorted(sorted_arr) {|first, second| assert_true(first.wheels <= second.wheels, "Cars not sorted: #{first.wheels} wheels is not >= #{second.wheels} wheels")}
      end
    end
  end

  def test_benchmark
    arr = rand_int_array(size: MAX_LEN)

    reg_time = Benchmark.measure do
      arr.sort
    end

    conc_time = Benchmark.measure do
      ConcurrentSort.sort(arr)
    end

    if conc_time.total > reg_time.total
      warn "Warning: Slower than regular sorting"
      warn "Regular: #{reg_time}"
      warn "Concurrent: #{conc_time}"
    end
  end
end

require 'test/unit'
require 'thread'
require_relative '../questions/multi_thread_singleton'

class MultiThreadSingletonTest < Test::Unit::TestCase
  def setup; end

  def teardown; end

  def assert_invariants; end

  def test_thread_safe_singleton
    thread_array = Array.new(50) { Thread.new { MultiThreadSingleton.instance }}
    assert_equal(1, thread_array.collect { |x| x.value }.uniq.size)
  end

end
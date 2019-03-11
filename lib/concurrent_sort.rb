require_relative 'merge_sort_concurrent'

class NotComparableError < TypeError; end
class DifferentTypeError < TypeError; end
class InvalidDurationError < StandardError; end
class DurationTooShortError < StandardError; end

module ConcurrentSort
  extend self

  # Optional block: if passed, must implement a comparison between
  # a and b and return an integer less than 0 when b follows a, 0 when a
  # and b are equivalent, or an integer greater than 0 when a follows b.
  #
  # See: https://ruby-doc.org/core-2.5.0/Array.html#method-i-sort
  def sort(data, duration=100)
    return data.dup unless data.size > 1

    # Sanity checks on data
    raise NotComparableError unless block_given? or data[0].is_a?(Comparable)
    raise DifferentTypeError unless data[0].class == data[1].class
    raise InvalidDurationError unless duration > 0

    result_buf = []
    merge = MergeSortConcurrent.new(data, result_buf, block_given? ? Proc.new : nil)

    timer = Thread.new do
      sleep(duration)
      merge.kill_sort
      raise DurationTooShortError
    end
    timer.abort_on_exception = true

    merge.sort
    timer.kill
    result_buf
  end
end

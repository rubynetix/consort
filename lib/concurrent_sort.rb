require_relative 'merge_sort_concurrent'

class NotComparableError < TypeError; end
class DifferentTypeError < TypeError; end

module ConcurrentSort
  extend self

  def stream_sort; end

  # Optional block: if passed, must implement a comparison between
  # a and b and return an integer less than 0 when b follows a, 0 when a
  # and b are equivalent, or an integer greater than 0 when a follows b.
  #
  # See: https://ruby-doc.org/core-2.5.0/Array.html#method-i-sort
  def sort(data)
    return data.dup unless data.size > 1

    # Sanity checks on data
    raise NotComparableError unless data[0].is_a?(Comparable)
    raise DifferentTypeError unless data[0].class == data[1].class

    result_buf = []
    MergeSortConcurrent.new(data, result_buf, block_given? ? Proc.new : nil).sort
    result_buf
  end
end

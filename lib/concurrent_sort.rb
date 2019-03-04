require_relative 'merge_sort_concurrent'

module ConcurrentSort
  extend self

  def stream_sort; end

  # Optional block: if passed, must implement a comparison between
  # a and b and return an integer less than 0 when b follows a, 0 when a
  # and b are equivalent, or an integer greater than 0 when a follows b.
  #
  # See: https://ruby-doc.org/core-2.5.0/Array.html#method-i-sort
  def sort(data)
    result_buf = []
    MergeSortConcurrent.new(data, result_buf).sort
    result_buf
  end
end
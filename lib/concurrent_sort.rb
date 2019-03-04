require_relative 'merge_sort_concurrent'

module ConcurrentSort
  extend self

  def stream_sort

  end

  def sort(data)
    result_buf = []
    MergeSortConcurrent.new(data, result_buf).sort
    result_buf
  end
end
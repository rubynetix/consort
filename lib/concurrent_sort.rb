require_relative 'merge_sort_concurrent'

module ConcurrentSort

  def stream_sort

  end

  def sort(data)
    result_buf = []
    MergeSortConcurrent.new(5, 1, data, result_buf).sort
    result_buf
  end

end
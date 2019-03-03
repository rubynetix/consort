module ConcurrentSort

  def stream_sort

  end

  def sort(data)
    result_buf = SizedQueue(data.size)
    MergeSortConcurrent.new(5, 1, data, result_buf)
    result_buf
  end

end
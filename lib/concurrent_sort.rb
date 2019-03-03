require_relative 'merge_sort_concurrent'

module ConcurrentSort

  FAN_OUT = 200
  MIN = 1000

  def stream_sort

  end

  def sort(data)
    result_buf = []
    MergeSortConcurrent.new(FAN_OUT, MIN, data, result_buf).sort
    result_buf
  end

end
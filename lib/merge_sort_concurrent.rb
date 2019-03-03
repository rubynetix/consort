require 'math'

require_relative 'sort_worker'

class MergeSortConcurrent

  def initialize(fan_out, min, data, result_buf)
    @fan_out = fan_out
    @min = min
    @data = data
    @result_buf = result_buf

    if data.size <= fan_out * min
      init_lower
    else
      init_upper
    end
  end

  def init_lower
    # Level right above sort workers
    @buffers = Array.new(Math.ceil(@data.size / @min), SizedQueue.new(@min))

    @workers = @buffers.map.with_index do |buf, i|
      start_index = i * @min
      end_index = [(i + 1) * @min, @data.size].min
      SortWorker.new(@data[start_index...end_index], buf)
    end
  end

  def init_upper
    @buffers = Array.new(@fan_out, SizedQueue.new(@min))

    block_size = @data.size / @fan_out

    # Children are also concurrent sort workers
    @workers = @buffers.map.with_index do |buf, i|
      start_index = i * block_size
      end_index = [(i + 1) * block_size, @data.size].min
      MergeSortConcurrent.new(@fan_out, @min, @data[start_index...end_index], buf)
    end
  end

  def sort
    out = []

    # TODO: A priority queue implementation
  end
end
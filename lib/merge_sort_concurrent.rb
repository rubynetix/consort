require_relative 'sort_worker'
require_relative 'p_queue'

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

  def sort
    first = @buffers.map.with_index { |buf, i| [buf.pop, i] }
    que = PQueue.new(first) { |a, b| a[0] < b[0] }

    until que.empty?
      e, i = que.deq
      @result_buf << e
      unless @buffers[i].empty? and not @workers[i].alive?
        que << [@buffers[i].pop, i]
      end
    end
  end

private

  def init_lower
    # Level right above sort workers
    @buffers = Array.new((@data.size.to_f / @min).ceil) { SizedQueue.new(@min) }

    @workers = @buffers.map.with_index do |buf, i|
      start_index = i * @min
      end_index = [(i + 1) * @min, @data.size].min
      Thread.new do
        SortWorker.new(@data[start_index...end_index], buf).sort
      end
    end
  end

  def init_upper
    @buffers = Array.new(@fan_out) { SizedQueue.new(@min) }
    block_size = (@data.size / @fan_out.to_f).ceil

    # Children are also concurrent sort workers
    @workers = @buffers.map.with_index do |buf, i|
      start_index = i * block_size
      end_index = [(i + 1) * block_size, @data.size].min
      Thread.new do
        MergeSortConcurrent.new(@fan_out, @min, @data[start_index...end_index], buf).sort
      end
    end
  end
end

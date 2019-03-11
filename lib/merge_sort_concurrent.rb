require_relative 'sort_worker'
require_relative 'p_queue'

class MergeSortConcurrent
  MAX_THREADS = 2000
  FAN_OUT = 200
  MIN = 10000

  class << self
    def num_threads(len, fan_out, threshold)
      workers = (len.to_f / threshold).ceil
      depth = Math.log(workers, fan_out).ceil
      threads = 0
      (0..depth).each {|n| threads += fan_out ** n}

      threads
    end

    def valid_config?(len, fan_out, threshold)
      num_threads(len, fan_out, threshold) <= MAX_THREADS
    end
  end

  def initialize(data, result_buf, compare_proc = nil, fan_out: FAN_OUT, min: MIN)
    @min = min
    @data = data
    @fan_out = fan_out
    @result_buf = result_buf
    @comparator = compare_proc

    unless MergeSortConcurrent.valid_config?(@data.length, @fan_out, @min)
      raise InvalidSortConfiguration.new("Concurrent sort requires too many threads. The fan-out/single-thread-threshold can be tuned manually.")
    end

    if data.size <= @fan_out * @min
      init_lower
    else
      init_upper
    end
  end

  def sort
    first = @buffers.map.with_index {|buf, i| [buf.pop, i]}
    que = PQueue.new(first) {|a, b| @comparator.nil? ? a[0] < b[0] : @comparator.call(a[0], b[0]) < 0}

    until que.empty?
      e, i = que.deq
      @result_buf << e
      unless @buffers[i].empty? and not @workers[i].alive?
        que << [@buffers[i].pop, i]
      end
    end
  end

  def kill_sort
    @workers.each do |t|
      Thread.kill(t)
    end
  end

  private

  def init_lower
    # Level right above sort workers
    @buffers = Array.new((@data.size.to_f / @min).ceil) {SizedQueue.new(@min)}

    @workers = @buffers.map.with_index do |buf, i|
      start_index = i * @min
      end_index = [(i + 1) * @min, @data.size].min
      Thread.new do
        @comparator.nil? ?
            SortWorker.new(@data[start_index...end_index], buf).sort :
            SortWorker.new(@data[start_index...end_index], buf).sort(&@comparator)
      end
    end
  end

  def init_upper
    @buffers = Array.new(@fan_out) {SizedQueue.new(@min)}
    block_size = (@data.size / @fan_out.to_f).ceil

    # Children are also concurrent sort workers
    @workers = @buffers.map.with_index do |buf, i|
      start_index = i * block_size
      end_index = [(i + 1) * block_size, @data.size].min
      Thread.new do
        MergeSortConcurrent.new(@data[start_index...end_index], buf, @comparator, fan_out: @fan_out, min: @min).sort
      end
    end
  end

  class InvalidSortConfiguration < StandardError; end
end

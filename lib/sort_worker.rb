class SortWorker

  def initialize(data, result_buf)
    @data = data
    @result_buf = result_buf
  end

  def sort
    @data.sort!
    @data.each do |e|
      @result_buf << e
    end
  end

end
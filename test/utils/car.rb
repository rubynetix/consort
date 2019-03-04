class Car
  include Comparable

  attr_reader :wheels

  def initialize(wheels = rand(1...1000))
    @wheels = wheels
  end

  def <=>(other)
    @wheels <=> other.wheels
  end
end

# Ruby lisp
class RLisp
  def initialize
    # RlISP!
  end

  def label(*args); end

  def quote(*args)
    args[0]
  end

  def car(*args); end

  def cdr(*args); end

  def cons(*args); end

  def eq(*args); end

  def if(*args); end

  def atom(*args); end

  def lambda(*args); end

  def eval(e)
    puts func, "\n"
    puts func.to_s, "\n"
    func = e.shift
    if !func.to_s.equal? :quote.to_s
      args = Array.new
      e.each { |item| args.append(eval(item)) }
      send func args
    else
      send func e
    end
  end
end

lisp = RLisp.new
puts lisp.class.instance_methods.to_s, "\n"
puts lisp.eval [:quote, [1, 1]]

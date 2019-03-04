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
    func = e.shift
    puts func, "\n"
    puts func.to_s, "\n"
    if !func.equal? :quote
      args = Array.new
      e.each { |item| args.append(eval(item)) }
      func.instance_exec args
    else
      func.instance_exec e
    end
  end
end

lisp = RLisp.new
puts lisp.class.instance_methods.to_s, "\n"
puts lisp.eval [:quote, [1, 1]]

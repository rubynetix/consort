# Ruby lisp
class RLisp
  def initialize
    # RlISP!
  end

  def label(*args); end

  def quote(arg)
    arg
  end

  def car(*args); end

  def cdr(*args); end

  def cons(*args); end

  def eq(*args); end

  def if(*args); end

  def atom(arg)
    return false if arg.is_a?

    true
  end

  def lambda(*args); end

  def eval(e)
    func = e.shift
    if !func.equal? :quote
      args = Array.new
      e.each { |item| args.append(eval(item)) }
      send func, args
    else
      send func, e[0]
    end
  end
end

lisp = RLisp.new
puts (lisp.eval [:quote, [1, 1]]).to_s

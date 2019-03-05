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

  def eq(args)
    raise ArgumentError, 'Incorrect number of arguments (' + args.size().to_s + ' for 2)' if args.size() != 2
    if args[0] == args[1]
      true
    else
      false
    end
  end

  def if(*args); end

  def atom(arg)
    if arg.is_a? Array
      return false
    elsif arg.is_a? Symbol
      return false
    end
    true
  end

  def lambda(*args); end

  def eval(e)
    return e if atom(e)
    func = e.shift
    if func.equal? :quote
      send func, e[0]
    else
      args = Array.new
      e.each { |item| args.append(eval(item)) }
      send func, args
    end
  end
end
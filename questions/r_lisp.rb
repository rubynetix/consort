# Ruby lisp
class RLisp
  def initialize
    # RLISP!
    @labels = Hash.new
  end

  def label(*args)
    raise ArgumentError unless args.size == 2

    @labels[args[0]] = args[1]
  end

  def quote(arg)
    puts arg.to_s
    arg
  end

  def car(args)
    raise ArgumentError unless (args.size == 1) && !atom(args[0])

    args[0].shift
  end

  def cdr(args)
    raise ArgumentError unless (args.size == 1) && !atom(args[0])

    args[0].shift
    args[0]
  end

  def cons(args)
    raise ArgumentError unless args.size == 2 && !atom(args[1])

    args[1].insert(0, args[0])
  end

  def eq(*args); end

  def if(*args); end

  def atom(arg)
    return false if arg.is_a? Array

    true
  end

  def lambda(*args); end

  def eval(e)
    return e if atom(e)

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

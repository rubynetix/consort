# Ruby lisp
class RLisp

  def initialize
    @labels = Hash.new
  end

  def label(args)
    @labels[args[0].dup] = args[1].dup
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

  def eq(args)
    raise ArgumentError, 'Incorrect number of arguments (' + args.size().to_s + ' for 2)' if args.size() != 2
    if args[0] == args[1]
      true
    else
      false
    end
  end

  def if(args)
    raise ArgumentError, 'Incorrect number of arguments (' + args.size().to_s + ' for 3)' if args.size() != 3
    if eval(args[0])
      eval(args[1])
    else
      eval(args[2])
    end
  end

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
    return @labels[e] if @labels.include? e
    return e if atom(e)
    puts e.to_s
    func = e.shift
    puts func
    if func.equal? :quote
      send func, e[0]
    elsif self.class.instance_methods.to_s.include? func.to_s
      args = Array.new
      e.each { |item| args.append(eval(item)) }
      puts args.to_s
      return send func, args
    else
      e
    end
  end
end
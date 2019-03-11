# Ruby lisp
class RLisp
  def initialize
    @labels = Hash.new
  end

  def label(args)
    @labels[args[0].dup] = args[1].dup
  end

  def quote(arg)
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
    args[0] == args[1]
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
    return false if arg.is_a? Array
    return false if self.class.instance_methods(false).to_s.include? arg.to_s

    true
  end

  def r_lambda(args)
    raise ArgumentError, 'Incorrect number of arguments (' + args.size().to_s + ' for 3)' if args.size() != 3
    lam = ->(lam_args) {
      l = self.dup
      i = 0
      args[1].each do |e|
        l.eval([:label, e, lam_args[i]])
        i += 1
      end
      l.eval(args[2])
    }
    lam
  end

  def eval(e)
    if @labels.include? e
      return @labels[e]
    end
    return e if atom(e)

    func = e.shift
    if func.equal? :quote
      send func, e[0]
    elsif func.equal? :if
      send func, e
    elsif @labels.include? func
      # func is a lambda function
      r_lambda(@labels[func]).call(e)
    else
      if self.class.instance_methods(false).to_s.include? func.to_s
        args = Array.new
        e.each {|item| args.append(eval(item))}
        return send func, args
      else
        r_lambda(func).call(e)
      end
    end
  end
end

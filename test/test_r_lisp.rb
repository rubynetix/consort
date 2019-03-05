require 'test/unit'
require_relative '../questions/r_lisp'

class RLispTest < Test::Unit::TestCase

  def setup
    @l = RLisp.new
  end

  def teardown; end

  def assert_invariants; end

  def test_label
    @l.eval [:label, :x, 15]
    assert_equal(@l.eval(:x), 15)
    assert_false(@l.eval([:eq, 17, :x]))
    assert_true(@l.eval([:eq, 15, :x]))
  end

  def test_quote
    assert_equal(@l.eval([:quote, [7, 10, 12]]), [7, 10, 12])
  end

  def test_car
    assert_equal(@l.eval([:car, [:quote, [7, 10, 12]]]), 7)
  end

  def test_cdr
    assert_equal(@l.eval([:cdr, [:quote, [7, 10, 12]]]), [10, 12])
  end

  def test_cons
    assert_equal(@l.eval([:cons, 5, [:quote, [7, 10, 12]]]), [5, 7, 10, 12])
  end

  def test_if
    assert_equal(@l.eval([:if, [:eq, 5, 7], 6, 7]), 7)
  end

  def test_atom
    assert_false(@l.eval([:atom, [:quote, [7, 10, 12]]]), 7)
  end

  def test_lambda
    @l.eval([:label, :second, [:quote, [:lambda, [:x], [:car, [:cdr, :x]]]]])
    assert_equal(@l.eval([:second, [:quote, [7, 10, 12]]]), 10)
  end
end
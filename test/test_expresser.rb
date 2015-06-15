require 'minitest_helper'
require 'yaml'

class TestExpresser < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Expresser::VERSION
  end

  def test_simple_expressions
    a = Expression {|x| 2*x}
    # p a
    assert_equal '*', a.name.to_s
    assert_equal 2, a.args.length
  end

  def test_enumerations
    a = Expression {|x| 2*x}
    fromtop = a.topdown.map do |e|
      e.to_hash
    end
    frombottom = a.bottomup.map do |e|
      e.to_hash
    end
    assert_equal fromtop.first, frombottom.last
    assert_equal fromtop.length, frombottom.length
    assert_equal 3, fromtop.length
  end

end

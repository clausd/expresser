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
end

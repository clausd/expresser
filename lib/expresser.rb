require "expresser/version"
require "expresser/expression"

module Expresser
  def if(condition, _then, _else)
  end
  def repeat(condition, body)
  end
end

def Expression(&block)
  root = Expresser::Expression.new(nil, nil, nil)
  root.express(&block)
end

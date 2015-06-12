module Expresser
  class Expression
  	attr_accessor :parent, :name, :args

  	def initialize(parent, name, args)
      @parent = parent
  		@name = name
  		@args = args
  	end

    def express(&block)
      self.instance_exec(*(block.parameters.map {|p| Expression.new(self, p.last, nil)}), &block)
    end

    def cast(raw)
      # I'd like something smarter here down the road
      Expression.new(self, raw.class.name, [raw])
    end

    # if args is nil this is just a variable - if not it's a function
    def method_missing(name, *args)
      # p name
      args_as_expressions = args.map {|a| a.is_a?(Expression) ? a : cast(a)} if args
      args_as_expressions.unshift(self)
      Expression.new(nil, name, args_as_expressions)
    end

    # support scalar multiplication and such....
    def coerce(scalar)
      # p scalar
      return cast(scalar), self
    end

    # serialize this node
    def to_hash
      {
        # :parent => (self.parent.is_a?(Expression) ? self.parent.to_hash : self.parent),
        :name => self.name,
        :args => self.args.to_a.map {|a| a.is_a?(Expression) ? a.to_hash : a}
      }
    end

    # # find the top, serialize it
    # def serialize
    #   if self.parent
    #     self.parent.serialize
    #   else
    #     self.to_hash
    #   end
    # end
  end
end

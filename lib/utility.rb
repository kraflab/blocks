module Blocks
  module Utility
    def sign(x)
      x <=> 0
    end

    def zero_vector
      CP::Vec2.new(0, 0)
    end

    def rand(n)
      @rng ||= Random.new
      @rng.rand(n)
    end

    def coin_flip?
      rand(2) == 1
    end
  end
end

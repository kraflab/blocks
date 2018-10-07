require 'drawable'
require 'shapeless'

module Blocks
  class ShapelessPlatform < Base
    include Drawable
    include Shapeless

    def initialize(x, y, a = 0, color = 0xff_ffffff)
      @image = Gosu::Image.new('media/platform.png')
      @p_x = x
      @p_y = y
      @p_a = a
      @color = color
    end
  end
end

require 'drawable'
require 'physical'
require 'physical/static'

module Blocks
  class StaticSpike < Base
    include Drawable
    include Physical
    include Physical::Static

    def initialize(x, y, a = 0, color = 0xff_ffffff)
      @image = Gosu::Image.new('media/spike.png')
      @color = color

      body = CP::StaticBody.new
      body.object = self
      define_shape_isosceles_by_image(body)
      shape.e = 1
      shape.collision_type = :spike
      move_to(x, y)
      rotate_to(a)
    end
  end
end

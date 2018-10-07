require 'drawable'
require 'physical'
require 'physical/static'

module Blocks
  class StaticPlatform < Base
    include Drawable
    include Physical
    include Physical::Static

    def initialize(x, y)
      @image = Gosu::Image.new('media/platform.png')

      body = CP::StaticBody.new
      body.object = self
      define_shape_rectangle_by_image(body)
      shape.e = 1
      shape.collision_type = :platform
      move_to(x, y)
    end
  end
end

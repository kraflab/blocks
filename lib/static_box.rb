require 'physical'
require 'physical/static'

module Blocks
  class StaticBox < Base
    include Physical
    include Physical::Static

    attr_reader :width, :height

    def initialize(x, y, width, height)
      @width = width
      @height = height
      body = CP::StaticBody.new
      body.object = self
      define_shape_rectangle_by_width_height(body, width, height)
      shape.e = 1
      shape.collision_type = :box
      move_to(x, y)
    end
  end
end

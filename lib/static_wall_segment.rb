require 'static_segment'

module Blocks
  class StaticWallSegment < StaticSegment
    attr_reader :shape

    def initialize(a_x, a_y, b_x, b_y)
      super
      shape.collision_type = :wall
    end
  end
end

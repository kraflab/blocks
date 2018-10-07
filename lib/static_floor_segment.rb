require 'static_segment'

module Blocks
  class StaticFloorSegment < StaticSegment
    attr_reader :shape

    def initialize(a_x, a_y, b_x, b_y)
      super
      shape.collision_type = :floor
    end
  end
end

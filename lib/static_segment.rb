module Blocks
  class StaticSegment < Base
    include Physical::Static

    attr_reader :shape

    def initialize(a_x, a_y, b_x, b_y)
      body = CP::StaticBody.new
      body.object = self
      @shape = CP::Shape::Segment.new(
        body, CP::Vec2.new(a_x, a_y), CP::Vec2.new(b_x, b_y), 0
      )
      shape.e = 1
      shape.collision_type = :segment
    end

    def p_x
      (shape.a.x + shape.b.x) / 2
    end

    def p_y
      (shape.a.y + shape.b.y) / 2
    end

    def left_edge
      shape.a.x < shape.b.x ? shape.a.x : shape.b.x
    end

    def right_edge
      shape.a.x > shape.b.x ? shape.a.x : shape.b.x
    end

    def top_edge
      shape.a.y < shape.b.y ? shape.a.y : shape.b.y
    end

    def bottom_edge
      shape.a.y > shape.b.y ? shape.a.y : shape.b.y
    end
  end
end

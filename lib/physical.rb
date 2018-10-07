module Blocks
  module Physical
    attr_reader :shape

    def p_x
      shape.body.p.x
    end

    def p_y
      shape.body.p.y
    end

    def p_a
      shape.body.a.radians_to_gosu
    end

    def v_x
      shape.body.v.x
    end

    def v_y
      shape.body.v.y
    end

    private

    def above?(object)
      p_y < object.p_y
    end

    def horizontal_overlap?(object, leeway = 0)
      (left_edge < object.right_edge - leeway &&
        left_edge > object.left_edge + leeway) ||
        (right_edge > object.left_edge + leeway &&
        right_edge < object.right_edge - leeway) ||
        (left_edge < object.left_edge && right_edge > object.right_edge)
    end

    def vertical_overlap?(object, leeway = 0)
      (top_edge < object.bottom_edge - leeway &&
        top_edge > object.top_edge + leeway) ||
        (bottom_edge > object.top_edge + leeway &&
        bottom_edge < object.bottom_edge - leeway) ||
        (top_edge < object.top_edge && bottom_edge > object.bottom_edge)
    end

    def apply_force(*args)
      shape.body.apply_force(*args)
    end

    def reset_rotation
      shape.body.a = 0
      shape.body.w = 0
    end

    def reset_velocity
      reset_y_velocity
      reset_x_velocity
    end

    def reset_y_velocity
      shape.body.v.y = 0.0
    end

    def reset_x_velocity
      shape.body.v.x = 0.0
    end

    def define_shape_rectangle_by_width_height(body, width, height)
      shape_array = [
        CP::Vec2.new(-width / 2, -height / 2),
        CP::Vec2.new(-width / 2, height / 2),
        CP::Vec2.new(width / 2, height / 2),
        CP::Vec2.new(width / 2, -height / 2)
      ]
      @shape = CP::Shape::Poly.new(
        body, shape_array, CP::Vec2.new(0, 0)
      )
    end

    def define_shape_rectangle_by_image(body)
      define_shape_rectangle_by_width_height(body, @image.width, @image.height)
    end

    def define_shape_isosceles_by_image(body)
      shape_array = [
        CP::Vec2.new(-@image.width / 2, @image.height / 2),
        CP::Vec2.new(@image.width / 2, @image.height / 2),
        CP::Vec2.new(0, -@image.height / 2)
      ]
      @shape = CP::Shape::Poly.new(
        body, shape_array, CP::Vec2.new(0, 0)
      )
    end

    def move_to(x, y)
      shape.body.p = CP::Vec2.new(x, y)
    end

    def rotate_to(a)
      shape.body.a = a
    end

    def accelerate_to(x, y)
      shape.body.v = CP::Vec2.new(x, y)
    end

    def accelerate_x(x)
      shape.body.v.x = x
    end

    def accelerate_y(y)
      shape.body.v.y = y
    end

    def outside_play?(leeway = 0)
      p_y > Config::GAME_HEIGHT + leeway ||
        p_y < -leeway ||
        p_x > Config::GAME_WIDTH + leeway ||
        p_x < -leeway
    end
  end
end

module Blocks
  module Drawable
    DRAW_ANGLE_OFFSET = 270

    attr_reader :image, :color

    def draw
      image.draw_rot(
        p_x,
        p_y,
        0,
        p_a + DRAW_ANGLE_OFFSET,
        0.5, 0.5, 1, 1,
        color || 0xff_ffffff
      )
    end

    def width
      @image.width
    end

    def height
      @image.height
    end
  end
end

require 'drawable'

module Blocks
  class Bullet < Base
    SPAWN_LEEWAY = 32
    LEFT_EDGE = -SPAWN_LEEWAY
    RIGHT_EDGE = GAME_WIDTH + SPAWN_LEEWAY
    TOP_EDGE = -SPAWN_LEEWAY
    BOTTOM_EDGE = GAME_HEIGHT + SPAWN_LEEWAY
    SPAWN_HEIGHT = BOTTOM_EDGE - TOP_EDGE
    SPAWN_WIDTH = RIGHT_EDGE - LEFT_EDGE
    IMAGE = Gosu::Image.new('media/bullet.png')

    include Drawable
    include Physical

    def initialize
      @image = IMAGE
      initialize_physics
      reset
    end

    def update
      detect_boundaries
    end

    private

    def initialize_physics
      body = CP::Body.new(0.1, 15.0)
      body.object = self
      define_shape_rectangle_by_image(body)
      shape.collision_type = :bullet
      shape.e = 1
    end

    def spawn_color
      colors = [
        0xff_ffffff,
        0xff_ffff11,
        0xff_11ffff,
        0xff_ff11ff,
        0xff_ff8811,
        0xff_8811ff,
        0xff_11ff88,
        0xff_ff1188,
        0xff_1188ff,
        0xff_88ff11
      ]
      colors[(Game.frame / 100) % colors.size]
    end

    def reset
      @color = spawn_color

      move_to(*random_spawn_position)
      accelerate_to(*random_spawn_velocity)
      reset_rotation
    end

    def random_spawn_position
      x, y = 0, 0
      if Blocks.coin_flip?
        x = Blocks.coin_flip? ? LEFT_EDGE : RIGHT_EDGE
        y = Blocks.rand(SPAWN_HEIGHT) - SPAWN_LEEWAY
      else
        y = Blocks.coin_flip? ? TOP_EDGE : BOTTOM_EDGE
        x = Blocks.rand(SPAWN_WIDTH) - SPAWN_LEEWAY
      end
      [x, y]
    end

    def random_spawn_velocity
      angle = Blocks.rand(360)
      speed = Blocks.rand(20) != 0 ? BULLET_SPEED : BULLET_SPEED_SLOW
      [Gosu.offset_x(angle, speed.to_f), Gosu.offset_y(angle, speed.to_f)]
    end

    def detect_boundaries
      reset if outside_play?(2 * SPAWN_LEEWAY)
    end
  end
end

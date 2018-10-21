module Blocks
  class Base
    def draw(*); end
    def add_to_space(*); end

    def left_edge
      p_x - width / 2
    end

    def right_edge
      p_x + width / 2
    end

    def top_edge
      p_y - height / 2
    end

    def bottom_edge
      p_y + height / 2
    end
  end

  PHYSICS_TIME_DIVISIONS = 4
  GAME_WIDTH = 1024
  GAME_HEIGHT = 768
  PLAYER_SIZE = 16
  PLAYER_HITBOX_LENGTH = 16
  MAX_JUMP_COUNT = 2
  JUMP_REFRESH_LEEWAY = 2
  JUMP_FRAME_CAP = [8, 16].freeze
  PLAYER_RUN_FORCE = CP::Vec2.new(20000, 0).freeze
  PLAYER_JUMP_FORCE = CP::Vec2.new(0, -10000).freeze
  PLAYER_GRAVITY = CP::Vec2.new(0.0, 2000.0).freeze
  MAX_RUN_SPEED = 400
  MAX_FALL_SPEED = 1000
  BULLET_SPEED = 300
  BULLET_SPEED_SLOW = 100
end

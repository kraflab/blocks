require 'drawable'
require 'physical'

module Blocks
  class Player < Base
    include Drawable
    include Physical
    include Utility

    JUMP_SPEED = [-400, -750].freeze

    def initialize(color = 0xff_ffffff)
      @image = Gosu::Image.new('media/player.png')
      @color = color

      body = CP::Body.new(1.0, CP::INFINITY)
      body.object = self
      define_shape_rectangle_by_image(body)
      shape.collision_type = :player
      reset_position
      reset_velocity
      reset_jump_state
    end

    def reset_position
      move_to(Config::GAME_WIDTH / 2.0, Config::GAME_HEIGHT / 4.0)
      reset_rotation
    end

    def update
      @shape.body.reset_forces
      if @jumps_available == MAX_JUMP_COUNT && !@on_the_ground
        @jumps_available -= 1
      end
      apply_gravity
      jump
      run
      detect_boundaries
      @on_the_ground = false
    end

    # these are inside collision callbacks, so contact is assured
    def on_floor?(floor)
      above?(floor) && horizontal_overlap?(floor, JUMP_REFRESH_LEEWAY)
    end

    def on_ceiling?(ceiling)
      !above?(ceiling) && horizontal_overlap?(ceiling, JUMP_REFRESH_LEEWAY)
    end

    def on_wall?(wall)
      vertical_overlap?(wall, JUMP_REFRESH_LEEWAY)
    end

    def refresh_floor_jump(floor)
      if on_floor?(floor) && !jumping?
        reset_jump_state
        @on_the_ground = true
      end
    end

    def apply_gravity
      if v_y >= MAX_FALL_SPEED
        shape.body.v.y = MAX_FALL_SPEED
        return
      end
      apply_force(PLAYER_GRAVITY, zero_vector)
    end

    def undo_gravity
      apply_force(-PLAYER_GRAVITY, zero_vector)
    end

    def queue_jump
      return unless can_jump?
      start_jumping
    end

    def reset_jump_state
      @jump_state = {
        available: MAX_JUMP_COUNT,
        jumping: false,
        start: nil
      }
    end

    def can_jump?
      @jump_state[:available] > 0
    end

    def continue_jump?
      jump_duration <= JUMP_FRAME_CAP[@jump_state[:available]] &&
        Gosu.button_down?(Gosu::KB_SPACE)
    end

    def jumping?
      @jump_state[:jumping]
    end

    def start_jumping
      @jump_state[:start] = Game.frame
      @jump_state[:available] -= 1
      @jump_state[:jumping] = true
      shape.body.v.y = JUMP_SPEED[@jump_state[:available]]
    end

    def stop_jumping
      shape.body.v.y = [-300, shape.body.v.y].max
      @jump_state[:jumping] = false
    end

    def jump_duration
      Game.frame - @jump_state[:start]
    end

    def jump
      return unless jumping?
      return stop_jumping unless continue_jump?
      # undo_gravity
    end

    def run
      apply_friction
      run_right
      run_left
    end

    def apply_friction
      if v_x.abs > MAX_RUN_SPEED
        shape.body.v.x = MAX_RUN_SPEED * sign(v_x)
      else
        reset_x_velocity unless running?
      end
    end

    def running?
      Gosu.button_down?(Gosu::KB_RIGHT) || Gosu.button_down?(Gosu::KB_LEFT)
    end

    def run_right
      return unless v_x < MAX_RUN_SPEED and Gosu.button_down?(Gosu::KB_RIGHT)
      apply_force(PLAYER_RUN_FORCE, zero_vector)
    end

    def run_left
      return unless v_x > -MAX_RUN_SPEED and Gosu.button_down?(Gosu::KB_LEFT)
      apply_force(-PLAYER_RUN_FORCE, zero_vector)
    end

    def detect_boundaries
      reset_position if outside_play?
    end
  end
end

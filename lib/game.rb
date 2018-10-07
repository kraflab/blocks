require 'gosu'
require 'chipmunk'
require 'base'
require 'board'
require 'player'
require 'bullet'
require 'collision_handler'

module Blocks
  class Game < Gosu::Window
    class << self
      def frame
        @frame ||= 0
      end

      def next_frame
        @frame = frame + 1
      end
    end

    def initialize
      super 1024, 768
      self.caption = 'Blocks'

      @dt = 1.0 / 60

      @frame = 0
      @space = CP::Space.new

      @player = Player.new(0xff_1188ff)
      @space.add_body(@player.shape.body)
      @space.add_shape(@player.shape)

      @board = Board.new('001')
      @board.add_to_space(@space)

      @bullets = []
      @score = 0
      @highscore = 420

      CollisionHandler.init(@space)
    end

    def update
      update_score
      spawn_bullet if spawn_bullet?
      Config::PHYSICS_TIME_DIVISIONS.times do
        @player.update
        @bullets.each { |i| i.update(score: @score) }
        @space.step(@dt / Config::PHYSICS_TIME_DIVISIONS)
      end

      Game.next_frame
    end

    def spawn_bullet?
      ((@score / 100) % 10) < 3 && Blocks.rand(2) == 0 && @bullets.count < 50
    end

    def spawn_bullet
      bullet = Bullet.new(score: @score)
      @space.add_body(bullet.shape.body)
      @space.add_shape(bullet.shape)
      @bullets << bullet
    end

    def update_score
      @score += 1
      @highscore = @score if @score > @highscore
    end

    def check_collisions
      if @player.collides_with_any?(@bullets)
        reset_game
      end
    end

    def reset_game
      @bullets = []
      @score = 0
    end

    def draw
      Gosu::Image.from_text("Score: #{@score}", 32).draw(0, 0, 0)
      Gosu::Image.from_text("Record: #{@highscore}", 32).draw(0, 32, 0)
      Gosu::Image.from_text("P: #{@player.p_x.round}, #{@player.p_y.round}", 32).draw(0, 64, 0)
      Gosu::Image.from_text("V: #{@player.v_x.round}, #{@player.v_y.round}", 32).draw(0, 96, 0)
      @board.draw
      @player.draw
      @bullets.each { |i| i.draw }
    end

    def button_down(id)
      case id
      when Gosu::KB_ESCAPE
        close
      when Gosu::KB_SPACE
        @player.queue_jump
      end
    end
  end
end

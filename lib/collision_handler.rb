require 'collision_handler/player_floor'
require 'collision_handler/player_wall'
require 'collision_handler/player_ceiling'
require 'collision_handler/player_box'
require 'collision_handler/player_bullet'

module Blocks
  module CollisionHandler
    extend self

    def init(space)
      space.add_collision_handler(
        :player, :floor, PlayerFloor.new
      )
      space.add_collision_handler(
        :player, :wall, PlayerWall.new
      )
      space.add_collision_handler(
        :player, :ceiling, PlayerCeiling.new
      )
      space.add_collision_handler(
        :player, :box, PlayerBox.new
      )
      space.add_collision_handler(
        :plaer, :bullet, PlayerBullet.new
      )
    end
  end
end

module Blocks
  module CollisionHandler
    class PlayerWall
      def pre_solve(player_shape, wall_shape)
        player = player_shape.body.object
        wall = wall_shape.body.object

        player.on_wall?(wall)
      end
    end
  end
end

module Blocks
  module CollisionHandler
    class PlayerFloor
      def pre_solve(player_shape, floor_shape)
        player = player_shape.body.object
        floor = floor_shape.body.object

        player.refresh_floor_jump(floor)
        player.on_floor?(floor)
      end
    end
  end
end

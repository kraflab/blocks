module Blocks
  module CollisionHandler
    class PlayerBox
      def pre_solve(player_shape, box_shape)
        player = player_shape.body.object
        box = box_shape.body.object

        player.refresh_floor_jump(box)
        true
      end
    end
  end
end

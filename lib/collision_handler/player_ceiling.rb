module Blocks
  module CollisionHandler
    class PlayerCeiling
      def pre_solve(player_shape, ceiling_shape)
        player = player_shape.body.object
        ceiling = ceiling_shape.body.object

        player.on_ceiling?(ceiling)
      end
    end
  end
end

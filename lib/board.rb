require 'static_platform'
require 'shapeless_platform'
require 'static_box'
require 'static_spike'
require 'static_floor_segment'
require 'static_wall_segment'
require 'static_ceiling_segment'
require 'service/convert_arg_types'

module Blocks
  class Board
    BOARD_ELEMENT = {
      'static_platform' => StaticPlatform,
      'shapeless_platform' => ShapelessPlatform,
      'static_box' => StaticBox,
      'static_spike' => StaticSpike,
      'floor' => StaticFloorSegment,
      'wall' => StaticWallSegment,
      'ceiling' => StaticCeilingSegment
    }

    def initialize(name)
      @elements = []
      filename = "boards/#{name}.board"
      raise "Missing file: #{filename}" unless File.exist?(filename)

      File.readlines(filename).each do |line|
        args = line.chomp.split
        break if args.size == 0

        element_class = BOARD_ELEMENT[args.delete_at(0)]
        args = Service::ConvertArgTypes.call(args)
        @elements << element_class.new(*args)
      end
    end

    def draw
      @elements.each { |i| i.draw }
    end

    def add_to_space(space)
      @elements.each { |i| i.add_to_space(space) }
    end
  end
end

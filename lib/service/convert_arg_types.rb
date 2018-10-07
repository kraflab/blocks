module Blocks
  module Service
    module ConvertArgTypes
      extend self

      def call(args)
        args.map do |arg|
          int_arg(arg) || hex_arg(arg) || str_arg(arg)
        end
      end

      private

      def int_arg(arg)
        return unless arg.to_i.to_s == arg
        arg.to_i
      end

      def hex_arg(arg)
        return unless arg[0..1] == '0x'
        arg.to_i(16)
      end

      def str_arg(arg)
        arg
      end
    end
  end
end

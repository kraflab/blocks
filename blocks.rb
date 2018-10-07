#!/usr/bin/env ruby

require 'pry'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), 'lib'))

require 'game'

Blocks::Game.new.show if __FILE__ == $0

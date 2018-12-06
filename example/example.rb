require "gosu"
require "gosu/spritesheet"

class GameWindow < Gosu::Window
  def initialize
    super 800, 600
  end
end

GameWindow.new.show


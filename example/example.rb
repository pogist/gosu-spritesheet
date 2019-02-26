require "gosu"

class GameWindow < Gosu::Window
  def initialize
    super 800, 600
  end

  def needs_cursor?
    true
  end
end

GameWindow.new.show


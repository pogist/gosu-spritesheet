require "gosu"
require_relative "dude"

class GameWindow < Gosu::Window
  def initialize
    super 800, 600

    # Dude starts at the center of the screen
    @dude = Dude.new 400, 300
  end

  def needs_cursor?
    true
  end

  def update
    if button_down?(Gosu::KbLeft) or button_down?(Gosu::GpLeft)
      @dude.move :left, self.width
    end

    if button_down?(Gosu::KbRight) or button_down?(Gosu::GpRight)
      @dude.move :right, self.width
    end
  end

  def draw
    @dude.draw
  end

  def button_up(id)
    keys = [
      Gosu::KbLeft,
      Gosu::GpLeft,
      Gosu::KbRight,
      Gosu::GpRight
    ]

    if keys.include?(id)
      @dude.stop_moving
    end
  end

  # Helper functions
  private

  def button_down?(key)
    Gosu::button_down?(key)
  end
end

GameWindow.new.show


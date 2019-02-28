require 'gosu'
require 'gosu/spritesheet'

class Dude
  def initialize(x, y)
    @x, @y = x, y

    @tiles = Gosu::Image.load_tiles 'sprites/dude.png', 32, 48

    @spritesheet = Gosu::Spritesheet.new({
      :tiles => @tiles,
      :animations => {
        :walk_left => { range: [0..3], duration: 0.2 },
        :walk_right => { range: [5..8], duration: 0.2 }
      }
    })

    @moving = false
    @facing = :left
    @movement_speed = { left: -2.0, right: 2.0 }
  end

  ##
  # This method is called on each game loop iteration.
  # So here is where we need to draw every animation frame.
  #
  def draw
    anim_key = @facing == :left ? :walk_left : :walk_right
    animation = @spritesheet.animation(anim_key)

    frame = @moving ? animation.step : animation.stop
    frame.draw @x, @y, 1
  end

  def move(direction, screen_width)
    @facing = direction
    @moving = true

    @x += @movement_speed[direction]

    # Avoid dude scapes from screen
    @x %= screen_width
  end

  def stop_moving
    @moving = false
  end
end

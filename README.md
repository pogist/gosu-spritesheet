# Installation

Add this line to your application's Gemfile:

```ruby
gem 'gosu-spritesheet'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install gosu-spritesheet

# Usage

### Creating a simple spritesheet animation

```ruby
require 'gosu'
require 'gosu/spritesheet'

class Game < Gosu::Window
  def initialize
    tiles = Gosu::Image.load_tiles 'path/to/your/tiles.png', 10, 10
    @spritesheet = Gosu::Spritesheet.new { :tiles => tiles }
  end

  def draw
    x, y, z = #...the position of your animation on screen.

    # Just draws the next animation frame on each iteration.
    @spritesheet.animation(:default).step.draw x, y, z
  end
end

Game.new.show
```

### A more complex example using custom animations

Consider that your game object may have more than one animation with different
frames each, but those frames are on the same image. That way, you can define 
different animations for each set of frames:

```ruby
require 'gosu'
require 'gosu/spritesheet'

class Character
  # x, y, z are our character's initial position.
  def initialize(x, y, z)
    @x, @y, @z = x, y, z
    tiles = Gosu::Image.load_tiles 'path/to/your/tiles.png', 10, 10
    
    # Suppose your tile has 8 frames.
    #
    # The first 4 frames are your character walking left.
    # And the other 4 your character walking right.
    @spritesheet = Gosu::Spritesheet.new({
      :tiles => tiles,
      :animations => {
        # Here we are taking the first 4 frames as the walking left
        # animation frames.
        :walk_left => { range: [0..3], duration: 0.2 },
        # The other 4 are the frames of walking right.
        :walk_right => { range: [4..7], duration: 0.2 }
      }
    })

    # By default our character starts facing left and stopped.
    @move_direction = :left
    @moving = false
  end
  
  def draw
    # Let's decide which animation to draw.
    animation_key = @move_direction == :left ? :walk_left : :walk_right

    if @moving
      # If our character is moving let's animate it!
      @spritesheet.animation(animation_key).step.draw @x, @y, @z
    else
      # When our character isn't moving let's just draw its stopped frame.
      @spritesheet.animation(animation_key).stop.draw @x, @y, @z
    end
  end

  def walk(direction, speed)
    @moving = true
    @x += direction == :right ? speed : -speed
  end
  
  def stop_moving
    @moving = false
  end
end
```

Now that we have our character class ready let's use it!

```ruby
class Game < Gosu::Window
  def initialize
    super 800, 600 
    # Let's start our character at the center of the screen.
    @char = Character.new 400, 300, 1
  end

  def draw
    @char.draw
  end

  def update
    if pressing_right?
      @char.walk :right, 2
    end

    if pressing_left?
      @char.walk :left, 2
    end
  end

  def button_up(id)
    # When the user stops pressing any button let's tell our character to stop
    # moving.
    @char.stop_moving
  end

  # Let's define some helper functions
  def pressing_right?
    Gosu::button_down?(Gosu::KbRight) or Gosu::button_down?(Gosu::GpRight)
  end

  def pressing_left?
    Gosu::button_down?(Gosu::KbLeft) or Gosu::button_down?(Gosu::GpLeft)
  end
end

Game.new.show
```

That's it.

## Contributing

Just open a pull request. I'll read it, I promise.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

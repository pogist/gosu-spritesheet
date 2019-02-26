require "test_helper"
require "gosu"

describe Gosu::AnimationBlock do
  let(:dude_tiles) { 
    path = File.expand_path('../resources/dude.png', __FILE__)
    Gosu::Image.load_tiles path, 32, 48 
  }

  before do
    @animation = Gosu::AnimationBlock.new(dude_tiles, 0.2)
  end

  after do
    @animation = nil
  end

  it "calculates the next animation frame" do
    # When
    next_frame = @animation.step

    # Then
    next_frame.must_equal dude_tiles[
      Gosu::milliseconds / @animation.duration_in_millisecs % dude_tiles.size
    ]
  end
end

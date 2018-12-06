require "test_helper"
require "gosu"

describe Gosu::Spritesheet do
  let(:dude_tiles) { 
    path = File.expand_path('../resources/dude.png', __FILE__)
    Gosu::Image.load_tiles path, 32, 48 
  }
  
  describe "when initialized from a tile set" do
    describe "and a custom animation block is provided" do
      let (:spritesheet) {
        Gosu::Spritesheet.new({
          :tiles => dude_tiles,
          :animations => {
            :my_custom_animation => { range: [0..3], duration: 0.3 }
          }
        })
      }

      it "must be able to fetch the custom animation" do
        spritesheet.animation(:my_custom_animation).wont_be_nil
        spritesheet.animation(:my_custom_animation).frames.must_equal dude_tiles[0..3]
        spritesheet.animation(:my_custom_animation).duration.must_equal 0.3
      end
    end

    describe "and no custom animation blocks are provided" do
      let(:spritesheet) { Gosu::Spritesheet.new(:tiles => dude_tiles) }

      it "has a default animation block that animates all tiles in sequence" do
        spritesheet.animation(:default).wont_be_nil
        spritesheet.animation(:default).frames.must_equal dude_tiles
        spritesheet.animation(:default).duration.must_equal 0.2
      end
    end
    
    describe "and a animation block called default is provided" do
      let(:spritesheet) { 
        Gosu::Spritesheet.new({
          :tiles => dude_tiles,
          :animations => {
            :default => [0..3, 0.3]
          }
        })
      }

      # Default animation options set during `default`'s initialization
      let(:default_frames) { dude_tiles }
      let(:default_duration) { 0.2 }

      it "wont be overrided" do
        spritesheet.animation(:default).frames.wont_equal default_frames
        spritesheet.animation(:default).duration.wont_equal default_duration
      end
    end
  end
end

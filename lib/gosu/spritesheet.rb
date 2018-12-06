require "gosu/spritesheet/version"
require "gosu/spritesheet/animation_block"

module Gosu
  class MissingAnimationKeys < StandardError; end
  class UnknownAnimationKeys < StandardError; end

  class Spritesheet
    def initialize(tiles: [], animations: nil)
      @tiles = tiles
      setup_animations(animations)
    end

    def animation(anim_key)
      @animations[anim_key.to_sym]
    end

    private
    def setup_animations(animations)
      @animations = Hash.new

      if animations.nil?
        @animations[:default] = Gosu::AnimationBlock.new(@tiles, 0.2)
      else
        animations.each do |key, value|
          @animations[key] = animation_from_spec(value)
        end
      end
    end

    def animation_from_spec(spec)
      frames_range = spec.fetch(:range, nil)
      duration = spec.fetch(:duration, nil)

      missing_keys = []
      missing_keys << ":range" if frames_range.nil?
      missing_keys << ":duration" if duration.nil?

      if not missing_keys.empty?
        message = "Missing #{missing_keys.join(' and ')} on block: #{spec}" 
        raise MissingAnimationKeys, message
      end

      Gosu::AnimationBlock.new(@tiles[frames_range.first], duration)
    end
  end
end

module Gosu
  class AnimationBlock
    attr_reader :frames, :duration

    def initialize(frames, duration)
      @frames = frames
      @duration = duration
    end
  end
end

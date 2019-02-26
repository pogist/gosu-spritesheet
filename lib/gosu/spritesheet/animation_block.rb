require 'gosu'

module Gosu
  class AnimationBlock
    attr_reader :frames, :duration, :duration_in_millisecs

    def initialize(frames, duration)
      @frames = frames
      @duration = duration
      @duration_in_millisecs = @duration * 1000
    end

    ##
    # Calculates the next animation frame.
    #
    def step
      @frames[Gosu::milliseconds / @duration_in_millisecs % @frames.size]
    end

    def stop
      # Just gets back to the first frame.
      @frames[0]
    end
  end
end

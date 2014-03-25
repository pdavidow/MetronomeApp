module MetronomicExceptions
  class MetronomeError < StandardError
    def message_view
      self.message
    end
  end

  class MetronomeSettingError < MetronomeError
  end

  class MetronomeSettingError_ClassicTicksPerBeat < MetronomeSettingError
    attr_accessor :classic_ticks_per_beat, :beat

    def self.new_for__classic_ticks_per_beat__for_beat(classic_ticks_per_beat, beat)
      instance = self.new
      instance.classic_ticks_per_beat = classic_ticks_per_beat
      instance.beat = beat
      instance
    end

    def error_string_for_location_description(location_description)
      "Invalid classic ticks per beat: Beat (#{location_description}) has #{self.beat.tick_amount} ticks, which is not cleanly divisible by classic ticks per beat of #{self.classic_ticks_per_beat}"
    end

    def message
      self.message_model
    end

    def message_model
      self.error_string_for_location_description(self.beat.location_description)
    end

    def message_view
      self.error_string_for_location_description(self.beat.display_location_description)
    end
  end
end

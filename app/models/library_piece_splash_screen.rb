class LibraryPieceSplashScreen < AbstractLibraryPiece

  def self.my_name
    "Splash Screen"
  end

  def self.composer
    "PJD"
  end

  def self.push_measures(piece)
    piece.measures.push(Measure.new) #1
    piece.measures.last.beats.push(Beat.new(rh:2, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:4, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:8, lh:3))
  end

  def self.set_metronome_setting(setting)
    setting.classic_ticks_per_minute = 15
    setting.classic_ticks_per_beat = 1
    setting.is_background_on_all_ticks = true
    setting.is_background_tick = true
    setting.is_mute_right_and_left_for_classic = true
    setting.is_classic_tick = true
    setting.is_right_hand_tick = true
    setting.is_left_hand_tick = true
    setting.is_stereo_for_right_left = true
    setting.is_use_entire = true
    setting.is_loop = true
  end
end
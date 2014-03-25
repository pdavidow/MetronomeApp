class LibraryPieceChopinNocturneCsharpminorOpusPosthumousMeasures53thru64 < AbstractLibraryPiece

  def self.my_name
    "Nocturne in C sharp Minor (measures 53 thru 64)"
  end

  def self.composer
    "Chopin"
  end

  def self.catalog_reference
    "Op. posthumous"
  end

  def self.push_measures(piece)
    (1..52).each do |i|  # Measure-holders
      piece.measures.push(Measure.new)
      piece.measures.last.beats.push(Beat.new(rh:1, lh:1))
      piece.measures.last.beats.push(Beat.new(rh:1, lh:1))
    end

    piece.measures.push(Measure.new) #53
    piece.measures.last.beats.push(Beat.new(rh:1, lh:4))
    piece.measures.last.beats.push(Beat.new(rh:1, lh:4))

    piece.measures.push(Measure.new) #54
    piece.measures.last.beats.push(Beat.new(rh:1, lh:4))
    piece.measures.last.beats.push(Beat.new(rh:1, lh:4))

    piece.measures.push(Measure.new) #55
    piece.measures.last.beats.push(Beat.new(rh:1, lh:4))
    piece.measures.last.beats.push(Beat.new(rh:1, lh:4))

    piece.measures.push(Measure.new) #56
    piece.measures.last.beats.push(Beat.new(rh:1, lh:4))
    piece.measures.last.beats.push(Beat.new(rh:1, lh:4))

    piece.measures.push(Measure.new) #57
    piece.measures.last.beats.push(Beat.new(rh:1, lh:4))
    piece.measures.last.beats.push(Beat.new(rh:18, lh:4))

    piece.measures.push(Measure.new) #58
    piece.measures.last.beats.push(Beat.new(rh:1, lh:4))
    piece.measures.last.beats.push(Beat.new(rh:35, lh:4))

    piece.measures.push(Measure.new) #59
    piece.measures.last.beats.push(Beat.new(rh:1, lh:4))
    piece.measures.last.beats.push(Beat.new(rh:11, lh:4))

    piece.measures.push(Measure.new) #60
    piece.measures.last.beats.push(Beat.new(rh:1, lh:4))
    piece.measures.last.beats.push(Beat.new(rh:13, lh:4))

    piece.measures.push(Measure.new) #61
    piece.measures.last.beats.push(Beat.new(rh:1, lh:4))
    piece.measures.last.beats.push(Beat.new(rh:1, lh:4))

    piece.measures.push(Measure.new) #62
    piece.measures.last.beats.push(Beat.new(rh:1, lh:4))
    piece.measures.last.beats.push(Beat.new(rh:1, lh:4))

    piece.measures.push(Measure.new) #63
    piece.measures.last.beats.push(Beat.new(rh:1, lh:4))
    piece.measures.last.beats.push(Beat.new(rh:1, lh:4))

    piece.measures.push(Measure.new) #64
    piece.measures.last.beats.push(Beat.new(rh:1, lh:4))
    piece.measures.last.beats.push(Beat.new(rh:1, lh:4))
  end

  def self.set_metronome_setting(setting)
    setting.classic_ticks_per_minute = 5
    setting.classic_ticks_per_beat = 1
    setting.is_background_on_all_ticks = true
    setting.is_background_tick = true
    setting.is_mute_right_and_left_for_classic = true
    setting.is_classic_tick = true
    setting.is_right_hand_tick = true
    setting.is_left_hand_tick = true
    setting.is_stereo_for_right_left = false

    setting.is_loop = false
    setting.is_use_entire = false
    setting.begin_measure_index = 53-1
    setting.begin_beat_index = 1-1
    setting.end_measure_index = 64-1
    setting.end_beat_index = 2-1
  end

  def self.add_log_entry(log)
    super
    log.entries.new(contents: "Online sheet music:
http://www.allpianoscores.com/free_scores.php?id=259")
  end
end


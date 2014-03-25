class LibraryPieceChopinNocturneEminorOpus72No1Posthumous < AbstractLibraryPiece

  def self.my_name
    "Nocturne in E Minor"
  end

  def self.composer
    "Chopin"
  end

  def self.catalog_reference
    "Op. 72, No. 1"
  end

  def self.push_measures(piece)
    piece.measures.push(Measure.new) #1
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))

    piece.measures.push(Measure.new) #2
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:2, lh:3))

    piece.measures.push(Measure.new) #3
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:4, lh:3))

    piece.measures.push(Measure.new) #4
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:2, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:2, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:2, lh:3))

    piece.measures.push(Measure.new) #5
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))

    piece.measures.push(Measure.new) #6
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))

    piece.measures.push(Measure.new) #7
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))

    piece.measures.push(Measure.new) #8
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))

    piece.measures.push(Measure.new) #9
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))

    piece.measures.push(Measure.new) #10
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:2, lh:3))

    piece.measures.push(Measure.new) #11
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:3, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:3, lh:3))

    piece.measures.push(Measure.new) #12
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:2, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:3, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:3, lh:3))

    piece.measures.push(Measure.new) #13
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:3, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))

    piece.measures.push(Measure.new) #14
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:2, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))

    piece.measures.push(Measure.new) #15
    piece.measures.last.beats.push(Beat.new(rh:2, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:2, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:2, lh:3))

    piece.measures.push(Measure.new) #16
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:2, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:2, lh:3))

    piece.measures.push(Measure.new) #17
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:2, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))

    piece.measures.push(Measure.new) #18
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))

    piece.measures.push(Measure.new) #19
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))

    piece.measures.push(Measure.new) #20
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:2, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))

    piece.measures.push(Measure.new) #21
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))

    piece.measures.push(Measure.new) #22
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))

    piece.measures.push(Measure.new) #23
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))

    piece.measures.push(Measure.new) #24
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))

    piece.measures.push(Measure.new) #25
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:2, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:2, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:2, lh:3))

    piece.measures.push(Measure.new) #26
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))

    piece.measures.push(Measure.new) #27
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:2, lh:3))

    piece.measures.push(Measure.new) #28
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))

    piece.measures.push(Measure.new) #29
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:2, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:2, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:2, lh:3))

    piece.measures.push(Measure.new) #30
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))

    piece.measures.push(Measure.new) #31
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:4, lh:3))

    piece.measures.push(Measure.new) #32
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:6, lh:3))

    piece.measures.push(Measure.new) #33
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:6, lh:3))

    piece.measures.push(Measure.new) #34
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:8, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))

    piece.measures.push(Measure.new) #35
    piece.measures.last.beats.push(Beat.new(rh:9, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:3, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:10, lh:3))

    piece.measures.push(Measure.new) #36
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:8, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:8, lh:3))

    piece.measures.push(Measure.new) #37
    piece.measures.last.beats.push(Beat.new(rh:8, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:8, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:8, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:11, lh:3))

    piece.measures.push(Measure.new) #38
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))

    piece.measures.push(Measure.new) #39
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:2, lh:3))

    piece.measures.push(Measure.new) #40
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:3, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:6, lh:3))

    piece.measures.push(Measure.new) #41
    piece.measures.last.beats.push(Beat.new(rh:3, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:3, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:3, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:3, lh:3))

    piece.measures.push(Measure.new) #42
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:3, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))

    piece.measures.push(Measure.new) #43
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))

    piece.measures.push(Measure.new) #44
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))

    piece.measures.push(Measure.new) #45
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))

    piece.measures.push(Measure.new) #46
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))

    piece.measures.push(Measure.new) #47
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))

    piece.measures.push(Measure.new) #48
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))

    piece.measures.push(Measure.new) #49
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:2, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:2, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:2, lh:3))

    piece.measures.push(Measure.new) #50
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))

    piece.measures.push(Measure.new) #51
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:3, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:2, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:3, lh:3))

    piece.measures.push(Measure.new) #52
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))

    piece.measures.push(Measure.new) #53
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:2, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:2, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:2, lh:3))

    piece.measures.push(Measure.new) #54
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))

    piece.measures.push(Measure.new) #55
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))

    piece.measures.push(Measure.new) #56
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))

    piece.measures.push(Measure.new) #57
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
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
    setting.is_stereo_for_right_left = false
    setting.is_use_entire = true
    setting.is_loop = false
  end

  def self.add_log_entry(log)
    super
    log.entries.new(contents: "Online sheet music:
http://totalpianist.com/music/classical/c/chopin/nocturnes/nocturne-op-72.pdf
http://www.allpianoscores.com/free_scores.php?id=268")
  end
end
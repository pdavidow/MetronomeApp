class PieceFixture < Object

  def self.last_beat_in_last_measure_only_has_1_tick
    Mongoid.purge!

    piece = Piece.create(name: 'only1', composer: 'c1', catalog_reference: 'r1')
    piece.measures.push(Measure.new)
    piece.measures.last.beats.push(Beat.new(rh:1, lh:1))
    piece.measures.last.beats.push(Beat.new(rh:1, lh:1))

    setting = piece.metronome_setting
    setting.classic_ticks_per_beat = 1

    piece
  end

  def self.no_loop
    Mongoid.purge!

    piece = Piece.create(name: 'no_loop', composer: 'c2', catalog_reference: 'r2')
    piece.measures.push(Measure.new)
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:2, lh:3))
    piece.measures.push(Measure.new)
    piece.measures.last.beats.push(Beat.new(rh:3, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:4, lh:3))

    setting = piece.metronome_setting
    setting.classic_ticks_per_beat = 1
    setting.is_loop = false

    piece
  end

  def self.loop_entire
    Mongoid.purge!

    piece = Piece.create(name: 'loop', composer: 'c3', catalog_reference: 'r3')
    piece.measures.push(Measure.new)
    piece.measures.last.beats.push(Beat.new(rh:2, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:4, lh:3))

    setting = piece.metronome_setting
    setting.classic_ticks_per_beat = 1
    setting.is_loop = true

    piece
  end

  def self.logeeOff
    Mongoid.purge!

    u1 = User.create(email:'u1@user.com', password:'qewr5675jkljgrty')
    piece = u1.pieces.new(name: 'logeeA', composer: 'c4', catalog_reference: 'r4')
    piece.measures.push(Measure.new)
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))

    setting = piece.metronome_setting
    setting.is_log_usage = false
    setting.is_log_settings_if_log_usage = false

    piece.save
    piece
  end

  def self.logeeA
    Mongoid.purge!

    u1 = User.create(email:'u1@user.com', password:'qewr5675jkljgrty')
    piece = u1.pieces.new(name: 'logeeA', composer: 'c5', catalog_reference: 'r5')
    piece.measures.push(Measure.new)
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))

    setting = piece.metronome_setting
    setting.is_log_usage = true
    setting.is_log_settings_if_log_usage = false

    piece.save
    piece
  end

  def self.logeeB
    Mongoid.purge!

    u1 = User.create(email:'u1@user.com', password:'qewr5675jkljgrty')
    piece = u1.pieces.new(name: 'logeeB', composer: 'c6', catalog_reference: 'r6')
    piece.measures.push(Measure.new)
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))

    setting = piece.metronome_setting
    setting.is_log_usage = true
    setting.is_log_settings_if_log_usage = false

    piece.save
    piece
  end

  def self.logeeC
    Mongoid.purge!

    u1 = User.create(email:'u1@user.com', password:'qewr5675jkljgrty')
    piece = u1.pieces.new(name: 'logeeC', composer: 'c7', catalog_reference: 'r7')
    piece.measures.push(Measure.new)
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))

    setting = piece.metronome_setting
    setting.is_log_usage = true
    setting.is_log_settings_if_log_usage = false

    piece.save
    piece
  end

  def self.logeeD
    Mongoid.purge!

    u1 = User.create(email:'u1@user.com', password:'qewr5675jkljgrty')
    piece = u1.pieces.new(name: 'logeeD', composer: 'c8', catalog_reference: 'r8')
    piece.measures.push(Measure.new)
    piece.measures.last.beats.push(Beat.new(rh:1, lh:3))

    setting = piece.metronome_setting
    setting.is_log_usage = true
    setting.is_log_settings_if_log_usage = false

    piece.save
    piece
  end

  def self.logeeE
    Mongoid.purge!

    u1 = User.create(email:'u1@user.com', password:'qewr5675jkljgrty')
    piece = u1.pieces.new(name: 'logeeE', composer: 'c9', catalog_reference: 'r9')
    piece.measures.push(Measure.new)
    piece.measures.last.beats.push(Beat.new(rh:2, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:4, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:8, lh:3))
    piece.measures.push(Measure.new)
    piece.measures.last.beats.push(Beat.new(rh:2, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:4, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:8, lh:3))
    piece.measures.push(Measure.new)
    piece.measures.last.beats.push(Beat.new(rh:2, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:4, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:8, lh:3))

    setting = piece.metronome_setting
    setting.is_log_usage = true
    setting.is_log_settings_if_log_usage = true
    setting.classic_ticks_per_minute = 15
    setting.classic_ticks_per_beat = 3
    setting.is_background_on_all_ticks = true
    setting.is_background_tick = true
    setting.is_mute_right_and_left_for_classic = true
    setting.is_classic_tick = true
    setting.is_right_hand_tick = true
    setting.is_left_hand_tick = true
    setting.is_stereo_for_right_left = false
    setting.is_loop = false
    setting.is_use_entire = false
    setting.begin_measure_index = 2-1
    setting.begin_beat_index = 2-1
    setting.end_measure_index = 3-1
    setting.end_beat_index = 3-1

    piece.save
    piece
  end

  def self.logeeF
    Mongoid.purge!

    u1 = User.create(email:'u1@user.com', password:'qewr5675jkljgrty')
    piece = u1.pieces.new(name: 'logeeF', composer: 'c10', catalog_reference: 'r10')
    piece.measures.push(Measure.new)
    piece.measures.last.beats.push(Beat.new(rh:2, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:4, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:8, lh:3))
    piece.measures.push(Measure.new)
    piece.measures.last.beats.push(Beat.new(rh:2, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:4, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:8, lh:3))
    piece.measures.push(Measure.new)
    piece.measures.last.beats.push(Beat.new(rh:2, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:4, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:8, lh:3))

    setting = piece.metronome_setting
    setting.is_log_usage = true
    setting.is_log_settings_if_log_usage = true
    setting.classic_ticks_per_minute = 15
    setting.classic_ticks_per_beat = 3
    setting.is_background_on_all_ticks = true
    setting.is_background_tick = true
    setting.is_mute_right_and_left_for_classic = true
    setting.is_classic_tick = true
    setting.is_right_hand_tick = true
    setting.is_left_hand_tick = true
    setting.is_stereo_for_right_left = false
    setting.is_loop = false
    setting.is_use_entire = false
    setting.begin_measure_index = 2-1
    setting.begin_beat_index = 2-1
    setting.end_measure_index = 3-1
    setting.end_beat_index = 3-1

    piece.save
    piece
  end

  def self.logeeG
    Mongoid.purge!

    u1 = User.create(email:'u1@user.com', password:'qewr5675jkljgrty')
    piece = u1.pieces.new(name: 'logeeG', composer: 'c11', catalog_reference: 'r11')
    piece.measures.push(Measure.new)
    piece.measures.last.beats.push(Beat.new(rh:2, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:4, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:8, lh:3))
    piece.measures.push(Measure.new)
    piece.measures.last.beats.push(Beat.new(rh:2, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:4, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:8, lh:3))
    piece.measures.push(Measure.new)
    piece.measures.last.beats.push(Beat.new(rh:2, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:4, lh:3))
    piece.measures.last.beats.push(Beat.new(rh:8, lh:3))

    setting = piece.metronome_setting
    setting.is_log_usage = true
    setting.is_log_settings_if_log_usage = true
    setting.classic_ticks_per_minute = 15
    setting.classic_ticks_per_beat = 3
    setting.is_background_on_all_ticks = true
    setting.is_background_tick = true
    setting.is_mute_right_and_left_for_classic = true
    setting.is_classic_tick = true
    setting.is_right_hand_tick = true
    setting.is_left_hand_tick = true
    setting.is_stereo_for_right_left = false
    setting.is_loop = false
    setting.is_use_entire = false
    setting.begin_measure_index = 2-1
    setting.begin_beat_index = 2-1
    setting.end_measure_index = 3-1
    setting.end_beat_index = 3-1

    piece.save
    piece
  end
end
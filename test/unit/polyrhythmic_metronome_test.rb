require 'test_helper'

class TestPolyrhythmicMetronome < ActiveSupport::TestCase
  include MetronomicExceptions

  def test_tick_amount
    Mongoid.purge!

    u1 = User.create(email:'u1@user.com', password:'qewr5675jkljgrty')
    p1 = u1.pieces.create(name: 'a', composer: 'c1')
    u1.pieces.push(p1)
    (1..240).each{|each|
      p1.measures.push(Measure.new)
      p1.measures.last.beats.push(Beat.new(rh:1, lh:1))}
    u1 = User.first
    p1 = u1.pieces.find_by(name: 'a', composer: 'c1')
    metronome = PolyrhythmicMetronome.new(p1)
    metronome.setting.classic_ticks_per_beat = 1
    metronome.setting.is_use_entire = true

    self.assert_equal(240, metronome.validated_ticks_of_interest.size)
  end

  def test_tick_amount_per_beat_1
    Mongoid.purge!

    u1 = User.create(email:'u1@user.com', password:'qewr5675jkljgrty')
    p1 = u1.pieces.create(name: 'a', composer: 'c1')
    p1.measures.push(Measure.new)
    p1.measures.last.beats.push(Beat.new(rh:8, lh:3))
    p1.measures.last.beats.push(Beat.new(rh:11, lh:3))
    u1 = User.first
    p1 = u1.pieces.find_by(name: 'a', composer: 'c1')

    beat = p1.measures[0].beats[0]
    self.assert_equal(24, beat.tick_amount)

    beat = p1.measures[0].beats[1]
    self.assert_equal(33, beat.tick_amount)
  end

  def test_tick_amount_per_beat_2
    Mongoid.purge!

    u1 = User.create(email:'u1@user.com', password:'qewr5675jkljgrty')
    p1 = u1.pieces.create(name: 'a', composer: 'c1')
    p1.measures.push(Measure.new)
    p1.measures.last.beats.push(Beat.new(rh:1, lh:3))
    p1.measures.last.beats.push(Beat.new(rh:8, lh:3))
    u1 = User.first
    p1 = u1.pieces.find_by(name: 'a', composer: 'c1')
    metronome = PolyrhythmicMetronome.new(p1)
    metronome.setting.classic_ticks_per_minute = 60
    metronome.setting.classic_ticks_per_beat = 3

    ticks0 = metronome.beats[0].ticks
    ticks1 = metronome.beats[1].ticks

    self.assert_equal(3, ticks0.size)
    self.assert_equal(24, ticks1.size)
    ticks0.each{|t| self.assert_equal(1, t.sleep_interval)}
    ticks1.each{|t| self.assert_equal(3.quo(24), t.sleep_interval)}

    ticks0_time = ticks0.collect{|t|t.sleep_interval}.reduce(:+)
    ticks1_time = ticks1.collect{|t|t.sleep_interval}.reduce(:+)

    self.assert_equal(ticks0_time, ticks1_time)
  end

  def test_ticks_for_measure_one_beat_1
    Mongoid.purge!

    u1 = User.create(email:'u1@user.com', password:'qewr5675jkljgrty')
    p1 = u1.pieces.create(name: 'a', composer: 'c1')
    p1.measures.push(Measure.new)
    p1.measures.last.beats.push(Beat.new(rh:8, lh:3))
    u1 = User.first
    p1 = u1.pieces.find_by(name: 'a', composer: 'c1')
    metronome = PolyrhythmicMetronome.new(p1)
    metronome.setting.classic_ticks_per_minute = 60
    metronome.setting.classic_ticks_per_beat = 1
    metronome.setting.is_use_entire = true

    ticks = metronome.validated_ticks_of_interest
    self.assert_equal(24, ticks.size)
    self.assert_equal(1.0, ticks.collect{|t|t.sleep_interval}.reduce(:+))
  end

  def test_ticks_for_measure_one_beat_2
    Mongoid.purge!

    u1 = User.create(email:'u1@user.com', password:'qewr5675jkljgrty')
    p1 = u1.pieces.create(name: 'a', composer: 'c1')
    p1.measures.push(Measure.new)
    p1.measures.last.beats.push(Beat.new(rh:11, lh:3))
    u1 = User.first
    p1 = u1.pieces.find_by(name: 'a', composer: 'c1')
    metronome = PolyrhythmicMetronome.new(p1)
    metronome.setting.classic_ticks_per_minute = 60
    metronome.setting.classic_ticks_per_beat = 1
    metronome.setting.is_use_entire = true

    ticks = metronome.validated_ticks_of_interest
    self.assert_equal(33, ticks.size)
    self.assert_equal(1.0, ticks.collect{|t|t.sleep_interval}.reduce(:+))
  end

  def test_ticks_for_measure_one_beat_3
    Mongoid.purge!

    u1 = User.create(email:'u1@user.com', password:'qewr5675jkljgrty')
    p1 = u1.pieces.create(name: 'a', composer: 'c1')
    p1.measures.push(Measure.new)
    p1.measures.last.beats.push(Beat.new(rh:11, lh:3))
    u1 = User.first
    p1 = u1.pieces.find_by(name: 'a', composer: 'c1')
    metronome = PolyrhythmicMetronome.new(p1)
    metronome.setting.classic_ticks_per_minute = 10
    metronome.setting.classic_ticks_per_beat = 1
    metronome.setting.is_use_entire = true

    ticks = metronome.validated_ticks_of_interest
    self.assert_equal(33, ticks.size)
    self.assert_equal(6.0, ticks.collect{|t|t.sleep_interval}.reduce(:+))
  end

  def test_ticks_for_measure_one_beat_4
    Mongoid.purge!

    u1 = User.create(email:'u1@user.com', password:'qewr5675jkljgrty')
    p1 = u1.pieces.create(name: 'a', composer: 'c1')
    p1.measures.push(Measure.new)
    p1.measures.last.beats.push(Beat.new(rh:4, lh:3))
    u1 = User.first
    p1 = u1.pieces.find_by(name: 'a', composer: 'c1')
    metronome = PolyrhythmicMetronome.new(p1)
    metronome.setting.classic_ticks_per_minute = 120
    metronome.setting.classic_ticks_per_beat = 1
    metronome.setting.is_use_entire = true

    ticks = metronome.validated_ticks_of_interest
    self.assert_equal(12, ticks.size)
    self.assert_equal(0.5, ticks.collect{|t|t.sleep_interval}.reduce(:+))
  end

  def test_ticks_for_measure_one_beat_5
    Mongoid.purge!

    u1 = User.create(email:'u1@user.com', password:'qewr5675jkljgrty')
    p1 = u1.pieces.create(name: 'a', composer: 'c1')
    p1.measures.push(Measure.new)
    p1.measures.last.beats.push(Beat.new(rh:5, lh:3))
    u1 = User.first
    p1 = u1.pieces.find_by(name: 'a', composer: 'c1')
    metronome = PolyrhythmicMetronome.new(p1)
    metronome.setting.classic_ticks_per_minute = 120
    metronome.setting.classic_ticks_per_beat = 1
    metronome.setting.is_use_entire = true

    ticks = metronome.validated_ticks_of_interest
    self.assert_equal(15, ticks.size)
    self.assert_equal(0.5, ticks.collect{|t|t.sleep_interval}.reduce(:+))
  end

  def test_ticks_for_measure_multi_beat_1
    Mongoid.purge!

    u1 = User.create(email:'u1@user.com', password:'qewr5675jkljgrty')
    p1 = u1.pieces.create(name: 'a', composer: 'c1')
    p1.measures.push(Measure.new)
    p1.measures[0].beats.push(Beat.new(rh:11, lh:3))
    p1.measures[0].beats.push(Beat.new(rh:4, lh:3))
    u1 = User.first
    p1 = u1.pieces.find_by(name: 'a', composer: 'c1')
    metronome = PolyrhythmicMetronome.new(p1)
    metronome.setting.classic_ticks_per_minute = 10
    metronome.setting.classic_ticks_per_beat = 1
    metronome.setting.is_use_entire = true

    ticks = metronome.validated_ticks_of_interest
    self.assert_equal(45, ticks.size)
    self.assert_equal(12.0, ticks.collect{|t|t.sleep_interval}.reduce(:+))
  end

  def test_ticks_for_measure_multi_beat_2
    Mongoid.purge!

    u1 = User.create(email:'u1@user.com', password:'qewr5675jkljgrty')
    p1 = u1.pieces.create(name: 'a', composer: 'c1')
    p1.measures.push(Measure.new)
    p1.measures[0].beats.push(Beat.new(rh:11, lh:3))
    p1.measures[0].beats.push(Beat.new(rh:4, lh:3))
    p1.measures[0].beats.push(Beat.new(rh:4, lh:3))
    p1.measures[0].beats.push(Beat.new(rh:8, lh:3))
    u1 = User.first
    p1 = u1.pieces.find_by(name: 'a', composer: 'c1')
    metronome = PolyrhythmicMetronome.new(p1)
    metronome.setting.classic_ticks_per_minute = 20
    metronome.setting.classic_ticks_per_beat = 1
    metronome.setting.is_use_entire = true

    ticks = metronome.validated_ticks_of_interest
    self.assert_equal(81, ticks.size)
    self.assert_equal(12.0, ticks.collect{|t|t.sleep_interval}.reduce(:+))
  end

  def test_ticks_for_multi_measure_multi_beat
    Mongoid.purge!

    u1 = User.create(email:'u1@user.com', password:'qewr5675jkljgrty')
    p1 = u1.pieces.create(name: 'a', composer: 'c1')
    p1.measures.push(Measure.new)
    p1.measures.last.beats.push(Beat.new(rh:11, lh:3))
    p1.measures.last.beats.push(Beat.new(rh:4, lh:3))
    p1.measures.push(Measure.new)
    p1.measures.last.beats.push(Beat.new(rh:8, lh:3))
    p1.measures.last.beats.push(Beat.new(rh:10, lh:3))
    u1 = User.first
    p1 = u1.pieces.find_by(name: 'a', composer: 'c1')
    metronome = PolyrhythmicMetronome.new(p1)
    metronome.setting.classic_ticks_per_minute = 20
    metronome.setting.classic_ticks_per_beat = 1
    metronome.setting.is_use_entire = true

    ticks = metronome.validated_ticks_of_interest
    self.assert_equal(99, ticks.size)
    self.assert_equal(12.0, ticks.collect{|t|t.sleep_interval}.reduce(:+))
  end

  def test_start_at_any_beat_1
    Mongoid.purge!

    u1 = User.create(email:'u1@user.com', password:'qewr5675jkljgrty')
    p1 = u1.pieces.create(name: 'a', composer: 'c1')
    p1.measures.push(Measure.new)
    p1.measures.last.beats.push(Beat.new(rh:1, lh:3))
    u1 = User.first
    p1 = u1.pieces.find_by(name: 'a', composer: 'c1')
    metronome = PolyrhythmicMetronome.new(p1)
    metronome.setting.classic_ticks_per_minute = 60
    metronome.setting.classic_ticks_per_beat = 1
    metronome.setting.is_use_entire = true

    self.assert_equal(3, metronome.validated_ticks_of_interest.size)
    self.assert_equal(1.0, metronome.validated_ticks_of_interest.collect{|t|t.sleep_interval}.reduce(:+))
  end

  def test_start_at_any_beat_2
    Mongoid.purge!

    u1 = User.create(email:'u1@user.com', password:'qewr5675jkljgrty')
    p1 = u1.pieces.create(name: 'a', composer: 'c1')
    p1.measures.push(Measure.new)
    p1.measures.last.beats.push(Beat.new(rh:3, lh:4))
    u1 = User.first
    p1 = u1.pieces.find_by(name: 'a', composer: 'c1')
    metronome = PolyrhythmicMetronome.new(p1)
    metronome.setting.classic_ticks_per_minute = 20
    metronome.setting.classic_ticks_per_beat = 1
    metronome.setting.is_use_entire = true
    ticks = metronome.validated_ticks_of_interest

    self.assert_equal(12, ticks.size)
    self.assert_equal(3.0, ticks.collect{|t|t.sleep_interval}.reduce(:+))
  end

  def test_start_at_any_beat_3
    Mongoid.purge!

    u1 = User.create(email:'u1@user.com', password:'qewr5675jkljgrty')
    p1 = u1.pieces.create(name: 'a', composer: 'c1')
    p1.measures.push(Measure.new)
    p1.measures.last.beats.push(Beat.new(rh:3, lh:4))
    p1.measures.last.beats.push(Beat.new(rh:7, lh:4))
    u1 = User.first
    p1 = u1.pieces.find_by(name: 'a', composer: 'c1')
    metronome = PolyrhythmicMetronome.new(p1)
    metronome.setting.classic_ticks_per_minute = 20
    metronome.setting.classic_ticks_per_beat = 1
    metronome.setting.is_use_entire = true
    ticks = metronome.validated_ticks_of_interest

    self.assert_equal(40, ticks.size)
    self.assert_equal(6.0, ticks.collect{|t|t.sleep_interval}.reduce(:+))
  end

  def test_start_at_any_beat_4
    Mongoid.purge!

    u1 = User.create(email:'u1@user.com', password:'qewr5675jkljgrty')
    p1 = u1.pieces.create(name: 'a', composer: 'c1')
    p1.measures.push(Measure.new)
    p1.measures.last.beats.push(Beat.new(rh:3, lh:4))
    p1.measures.last.beats.push(Beat.new(rh:7, lh:4))
    u1 = User.first
    p1 = u1.pieces.find_by(name: 'a', composer: 'c1')
    metronome = PolyrhythmicMetronome.new(p1)
    metronome.setting.classic_ticks_per_minute = 20
    metronome.setting.classic_ticks_per_beat = 1

    metronome.setting.is_use_entire = false
    metronome.setting.begin_measure_index = 0
    metronome.setting.begin_beat_index = 0
    metronome.setting.end_measure_index = 0
    metronome.setting.end_beat_index = 1

    ticks = metronome.validated_ticks_of_interest

    self.assert_equal(40, ticks.size)
    self.assert_equal(6.0, ticks.collect{|t|t.sleep_interval}.reduce(:+))

    metronome.setting.is_use_entire = false
    metronome.setting.begin_measure_index = 0
    metronome.setting.begin_beat_index = 1
    metronome.setting.end_measure_index = 0
    metronome.setting.end_beat_index = 1

    metronome.reset
    ticks = metronome.validated_ticks_of_interest

    self.assert_equal(28, ticks.size)
    self.assert_equal(3.0, ticks.collect{|t|t.sleep_interval}.reduce(:+))
  end

  def test_start_at_any_beat_5
    Mongoid.purge!

    u1 = User.create(email:'u1@user.com', password:'qewr5675jkljgrty')
    p1 = u1.pieces.create(name: 'a', composer: 'c1')
    p1.measures.push(Measure.new)
    p1.measures.last.beats.push(Beat.new(rh:3, lh:4))
    p1.measures.last.beats.push(Beat.new(rh:7, lh:4))
    p1.measures.last.beats.push(Beat.new(rh:3, lh:4))
    p1.measures.last.beats.push(Beat.new(rh:7, lh:4))
    p1.measures.push(Measure.new)
    p1.measures.last.beats.push(Beat.new(rh:3, lh:4))
    p1.measures.last.beats.push(Beat.new(rh:7, lh:4))
    p1.measures.last.beats.push(Beat.new(rh:3, lh:4))
    p1.measures.last.beats.push(Beat.new(rh:7, lh:4))
    u1 = User.first
    p1 = u1.pieces.find_by(name: 'a', composer: 'c1')
    metronome = PolyrhythmicMetronome.new(p1)
    metronome.setting.classic_ticks_per_minute = 20
    metronome.setting.classic_ticks_per_beat = 1

    metronome.setting.is_use_entire = false
    metronome.setting.begin_measure_index = 0
    metronome.setting.begin_beat_index = 0
    metronome.setting.end_measure_index = 1
    metronome.setting.end_beat_index = 3

    self.assert_equal(160, metronome.validated_ticks_of_interest.size)

    metronome.setting.is_use_entire = false
    metronome.setting.begin_measure_index = 1
    metronome.setting.begin_beat_index = 1
    metronome.setting.end_measure_index = 1
    metronome.setting.end_beat_index = 3

    metronome.reset
    ticks = metronome.validated_ticks_of_interest

    self.assert_equal(68, ticks.size)
    self.assert_equal(9.0, ticks.collect{|t|t.sleep_interval}.reduce(:+))
  end

  def test_begin_end_1
    Mongoid.purge!

    u1 = User.create(email:'u1@user.com', password:'qewr5675jkljgrty')
    p1 = u1.pieces.create(name: 'a', composer: 'c1')
    p1.measures.push(Measure.new)
    p1.measures.last.beats.push(Beat.new(rh:1, lh:1))
    p1.measures.last.beats.push(Beat.new(rh:1, lh:1))
    p1.measures.push(Measure.new)
    p1.measures.last.beats.push(Beat.new(rh:1, lh:1))
    p1.measures.last.beats.push(Beat.new(rh:1, lh:1))
    u1 = User.first
    p1 = u1.pieces.find_by(name: 'a', composer: 'c1')
    metronome = PolyrhythmicMetronome.new(p1)
    metronome.setting.classic_ticks_per_minute = 60
    metronome.setting.classic_ticks_per_beat = 1

    metronome.setting.is_use_entire = false
    metronome.setting.begin_measure_index = 0
    metronome.setting.begin_beat_index = 0
    metronome.setting.end_measure_index = 0
    metronome.setting.end_beat_index = 0

    ticks = metronome.validated_ticks_of_interest
    self.assert_equal(1.0, ticks.collect{|t|t.sleep_interval}.reduce(:+))
    self.assert(ticks.first.beat.measure == p1.measures[0])
    self.assert(ticks.first.beat == p1.measures[0].beats[0])
    self.assert(ticks.last.beat.measure == p1.measures[0])
    self.assert(ticks.last.beat == p1.measures[0].beats[0])
  end

  def test_begin_end_2
    Mongoid.purge!

    u1 = User.create(email:'u1@user.com', password:'qewr5675jkljgrty')
    p1 = u1.pieces.create(name: 'a', composer: 'c1')
    p1.measures.push(Measure.new)
    p1.measures.last.beats.push(Beat.new(rh:1, lh:1))
    p1.measures.last.beats.push(Beat.new(rh:1, lh:1))
    p1.measures.push(Measure.new)
    p1.measures.last.beats.push(Beat.new(rh:1, lh:1))
    p1.measures.last.beats.push(Beat.new(rh:1, lh:1))
    u1 = User.first
    p1 = u1.pieces.find_by(name: 'a', composer: 'c1')
    metronome = PolyrhythmicMetronome.new(p1)
    metronome.setting.classic_ticks_per_minute = 60
    metronome.setting.classic_ticks_per_beat = 1

    metronome.setting.is_use_entire = false
    metronome.setting.begin_measure_index = 0
    metronome.setting.begin_beat_index = 1
    metronome.setting.end_measure_index = 1
    metronome.setting.end_beat_index = 0

    ticks = metronome.validated_ticks_of_interest
    self.assert_equal(2, ticks.size)
    self.assert_equal(2.0, ticks.collect{|t|t.sleep_interval}.reduce(:+))
    self.assert(ticks.first.beat.measure == p1.measures[0])
    self.assert(ticks.first.beat == p1.measures[0].beats[1])
    self.assert(ticks.last.beat.measure == p1.measures[1])
    self.assert(ticks.last.beat == p1.measures[1].beats[0])

    metronome.setting.is_use_entire = false
    metronome.setting.begin_measure_index = 0
    metronome.setting.begin_beat_index = 1
    metronome.setting.end_measure_index = 1
    metronome.setting.end_beat_index = 1
    metronome.reset

    ticks = metronome.validated_ticks_of_interest
    self.assert_equal(3.0, ticks.collect{|t|t.sleep_interval}.reduce(:+))
    self.assert(ticks.first.beat.measure == p1.measures[0])
    self.assert(ticks.first.beat == p1.measures[0].beats[1])
    self.assert(ticks.last.beat.measure == p1.measures[1])
    self.assert(ticks.last.beat == p1.measures[1].beats[1])
  end

  def test_invalid_classic_ticks_per_beat_1
    Mongoid.purge!

    u1 = User.create(email:'u1@user.com', password:'qewr5675jkljgrty')
    p1 = u1.pieces.create(name: 'a', composer: 'c1')
    p1.measures.push(Measure.new)
    p1.measures.last.beats.push(Beat.new(rh:1, lh:3))
    u1 = User.first
    p1 = u1.pieces.find_by(name: 'a', composer: 'c1')
    metronome = PolyrhythmicMetronome.new(p1)
    metronome.setting.classic_ticks_per_beat = 2
    metronome.setting.is_use_entire = true

    exception = self.assert_raise(MetronomeSettingError_ClassicTicksPerBeat){metronome.validated_ticks_of_interest}
    self.assert_equal("Invalid classic ticks per beat: Beat (measure 0, beat 0) has 3 ticks, which is not cleanly divisible by classic ticks per beat of 2", exception.message)
    self.assert_equal("Invalid classic ticks per beat: Beat (Beat 1, Measure 1) has 3 ticks, which is not cleanly divisible by classic ticks per beat of 2", exception.message_view)
  end

  def test_invalid_classic_ticks_per_beat_2
    Mongoid.purge!

    u1 = User.create(email:'u1@user.com', password:'qewr5675jkljgrty')
    p1 = u1.pieces.create(name: 'a', composer: 'c1')
    p1.measures.push(Measure.new)
    p1.measures.last.beats.push(Beat.new(rh:2, lh:3))
    p1.measures.last.beats.push(Beat.new(rh:2, lh:3))
    p1.measures.push(Measure.new)
    p1.measures.last.beats.push(Beat.new(rh:2, lh:3))
    p1.measures.last.beats.push(Beat.new(rh:5, lh:3))
    u1 = User.first
    p1 = u1.pieces.find_by(name: 'a', composer: 'c1')
    metronome = PolyrhythmicMetronome.new(p1)
    metronome.setting.classic_ticks_per_beat = 2
    metronome.setting.is_use_entire = true

    exception = self.assert_raise(MetronomeSettingError_ClassicTicksPerBeat){metronome.validated_ticks_of_interest}
    self.assert_equal("Invalid classic ticks per beat: Beat (measure 1, beat 1) has 15 ticks, which is not cleanly divisible by classic ticks per beat of 2", exception.message)
    self.assert_equal("Invalid classic ticks per beat: Beat (Beat 2, Measure 2) has 15 ticks, which is not cleanly divisible by classic ticks per beat of 2", exception.message_view)
  end

  def test_invalid_classic_ticks_per_beat_3
    Mongoid.purge!

    u1 = User.create(email:'u1@user.com', password:'qewr5675jkljgrty')
    p1 = u1.pieces.create(name: 'a', composer: 'c1')
    p1.measures.push(Measure.new)
    p1.measures.last.beats.push(Beat.new(rh:2, lh:2))
    p1.measures.last.beats.push(Beat.new(rh:1, lh:1))
    u1 = User.first
    p1 = u1.pieces.find_by(name: 'a', composer: 'c1')
    metronome = PolyrhythmicMetronome.new(p1)
    metronome.setting.classic_ticks_per_beat = 2
    metronome.setting.is_use_entire = true

    exception = self.assert_raise(MetronomeSettingError_ClassicTicksPerBeat){metronome.validated_ticks_of_interest}
    self.assert_equal("Invalid classic ticks per beat: Beat (measure 0, beat 1) has 1 ticks, which is not cleanly divisible by classic ticks per beat of 2", exception.message)
    self.assert_equal("Invalid classic ticks per beat: Beat (Beat 2, Measure 1) has 1 ticks, which is not cleanly divisible by classic ticks per beat of 2", exception.message_view)
  end
end
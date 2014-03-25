require 'test_helper'

class TestMetronomeSetting < ActiveSupport::TestCase
  include MetronomicExceptions

  def test_validation_1
    Mongoid.purge!

    u1 = User.create(email:'u1@user.com', password:'qewr5675jkljgrty')
    p1 = u1.pieces.create(name: 'a', composer: 'c1')

    self.assert(p1.valid?)

    u1 = User.first
    p1 = u1.pieces.find_by(name: 'a', composer: 'c1')
    metronome = PolyrhythmicMetronome.new(p1)

    self.assert_nothing_raised(Exception){metronome.validated_ticks_of_interest}
  end

  def test_validation_2
    Mongoid.purge!

    u1 = User.create(email:'u1@user.com', password:'qewr5675jkljgrty')
    p1 = u1.pieces.create(name: 'a', composer: 'c1')
    p1.measures.push(Measure.new)
    p1.measures.last.beats.push(Beat.new(rh:8, lh:3))
    p1.save!
    u1 = User.first
    p1 = u1.pieces.find_by(name: 'a', composer: 'c1')
    metronome = PolyrhythmicMetronome.new(p1)
    setting = metronome.setting
    setting.is_use_entire = false
    setting.begin_measure_index = 0
    setting.begin_beat_index = 0
    setting.end_measure_index = 0
    setting.end_beat_index = 0
    p1.save
    self.assert(p1.valid?)

    metronome = PolyrhythmicMetronome.new(p1)

    self.assert_nothing_raised(Exception){metronome.validated_ticks_of_interest}

    setting = metronome.setting

    setting.is_use_entire = false
    setting.begin_measure_index = 0
    setting.begin_beat_index = 1
    setting.end_measure_index = 0
    setting.end_beat_index = 0

    p1.save
    self.assert(p1.invalid?)

    exception = self.assert_raise(MetronomeSettingError){metronome.validated_ticks_of_interest}
    self.assert_equal("Metronome-Setting begin beat index must not exceed number of beats in begin measure", exception.message)

    setting.is_use_entire = false
    setting.begin_measure_index = 0
    setting.begin_beat_index = 1
    setting.end_measure_index = 0
    setting.end_beat_index = 1

    p1.save
    self.assert(p1.valid?)

    exception = self.assert_raise(MetronomeSettingError){metronome.validated_ticks_of_interest}
    self.assert_equal("Metronome-Setting begin beat index must not exceed number of beats in begin measure", exception.message)

    setting.is_use_entire = false
    setting.begin_measure_index = 1
    setting.begin_beat_index = 0
    setting.end_measure_index = 0
    setting.end_beat_index = 1

    p1.save
    self.assert(p1.invalid?)

    setting.is_use_entire = false
    setting.begin_measure_index = 1
    setting.begin_beat_index = 0
    setting.end_measure_index = 1
    setting.end_beat_index = 1

    p1.save
    self.assert(p1.valid?)

    exception = self.assert_raise(MetronomeSettingError){metronome.validated_ticks_of_interest}
    self.assert_equal("Metronome-Setting begin measure index must not exceed number of measures for piece", exception.message)

    setting.is_use_entire = false
    setting.begin_measure_index = 0
    setting.begin_beat_index = 0
    setting.end_measure_index = 0
    setting.end_beat_index = 1

    p1.save
    self.assert(p1.valid?)

    exception = self.assert_raise(MetronomeSettingError){metronome.validated_ticks_of_interest}
    self.assert_equal("Metronome-Setting end beat index must not exceed number of beats in end measure", exception.message)

    setting.is_use_entire = false
    setting.begin_measure_index = 0
    setting.begin_beat_index = 0
    setting.end_measure_index = 1
    setting.end_beat_index = 0

    p1.save
    self.assert(p1.valid?)

    exception = self.assert_raise(MetronomeSettingError){metronome.validated_ticks_of_interest}
    self.assert_equal("Metronome-Setting end measure index must not exceed number of measures for piece", exception.message)
  end

  def test_validation_3
    Mongoid.purge!

    u1 = User.create(email:'u1@user.com', password:'qewr5675jkljgrty')
    p1 = u1.pieces.create(name: 'a', composer: 'c1')
    p1.measures.push(Measure.new)
    p1.measures.last.beats.push(Beat.new(rh:8, lh:3))
    p1.measures.last.beats.push(Beat.new(rh:8, lh:3))
    p1.measures.push(Measure.new)
    p1.measures.last.beats.push(Beat.new(rh:11, lh:3))
    p1.measures.last.beats.push(Beat.new(rh:11, lh:3))
    metronome = PolyrhythmicMetronome.new(p1)
    setting = metronome.setting

    setting.is_use_entire = false
    setting.begin_measure_index = 1
    setting.begin_beat_index = 1
    setting.end_measure_index = 1
    setting.end_beat_index = 0

    p1.save
    self.assert(setting.invalid?)

    setting.is_use_entire = false
    setting.begin_measure_index = 1
    setting.begin_beat_index = 1
    setting.end_measure_index = 0
    setting.end_beat_index = 1

    self.assert(setting.invalid?)
  end

  def test_validation_4
    Mongoid.purge!

    u1 = User.create(email:'u1@user.com', password:'qewr5675jkljgrty')
    p1 = u1.pieces.create(name: 'a', composer: 'c1')
    p1.measures.push(Measure.new)
    p1.measures.last.beats.push(Beat.new(rh:8, lh:3))
    p1.measures.last.beats.push(Beat.new(rh:8, lh:3))
    p1.measures.push(Measure.new)
    p1.measures.last.beats.push(Beat.new(rh:11, lh:3))
    p1.measures.last.beats.push(Beat.new(rh:11, lh:3))
    metronome = PolyrhythmicMetronome.new(p1)
    setting = metronome.setting

    setting.is_use_entire = false
    setting.begin_measure_index = 0
    setting.begin_beat_index = -3
    setting.end_measure_index = 0
    setting.end_beat_index = 0

    self.assert(setting.invalid?)
    self.assert_equal(["must be greater than or equal to 0"], setting.errors[:begin_beat_index])
    self.assert_equal(1, setting.errors.size)

    setting.is_use_entire = false
    setting.begin_measure_index = 0
    setting.begin_beat_index = 0
    setting.end_measure_index = 0
    setting.end_beat_index = 0

    self.assert(setting.valid?)

    setting.is_use_entire = false
    setting.begin_measure_index = -3
    setting.begin_beat_index = 0
    setting.end_measure_index = 0
    setting.end_beat_index = 0

    self.assert(setting.invalid?)
    self.assert_equal(["must be greater than or equal to 0"], setting.errors[:begin_measure_index])
    self.assert_equal(1, setting.errors.size)

    setting.is_use_entire = false
    setting.begin_measure_index = 0
    setting.begin_beat_index = 0
    setting.end_measure_index = 0
    setting.end_beat_index = 0

    self.assert(setting.valid?)

    setting.is_use_entire = false
    setting.begin_measure_index = 0
    setting.begin_beat_index = 0
    setting.end_measure_index = 0
    setting.end_beat_index = -3

    self.assert(setting.invalid?)
    self.assert_equal(["must be greater than or equal to 0"], setting.errors[:end_beat_index])
    self.assert_equal(2, setting.errors.size)
    self.assert_equal(1, setting.errors[:base].size)
    self.assert_equal(["Begin beat index must be less than or equal to end beat index for the same measure"], setting.errors[:base])

    setting.is_use_entire = false
    setting.begin_measure_index = 0
    setting.begin_beat_index = 0
    setting.end_measure_index = 0
    setting.end_beat_index = 0

    self.assert(setting.valid?)

    setting.is_use_entire = false
    setting.begin_measure_index = 0
    setting.begin_beat_index = 0
    setting.end_measure_index = -3
    setting.end_beat_index = 0

    self.assert(setting.invalid?)
    self.assert_equal(["must be greater than or equal to 0"], setting.errors[:end_measure_index])
    self.assert_equal(2, setting.errors.size)
    self.assert_equal(1, setting.errors[:base].size)
    self.assert_equal(["Begin measure index must be less than or equal to end measure index"], setting.errors[:base])

    setting.is_use_entire = false
    setting.begin_measure_index = 0
    setting.begin_beat_index = 0
    setting.end_measure_index = 0
    setting.end_beat_index = 0

    self.assert(setting.valid?)
  end

  def test_use_entire
    Mongoid.purge!

    u1 = User.create(email:'u1@user.com', password:'qewr5675jkljgrty')
    p1 = u1.pieces.create(name: 'a', composer: 'c1')
    p1.measures.push(Measure.new)
    p1.measures.last.beats.push(Beat.new(rh:8, lh:3))
    p1.measures.last.beats.push(Beat.new(rh:8, lh:3))
    p1.measures.push(Measure.new)
    p1.measures.last.beats.push(Beat.new(rh:11, lh:3))
    p1.measures.last.beats.push(Beat.new(rh:11, lh:3))
    metronome = PolyrhythmicMetronome.new(p1)
    setting = metronome.setting

    setting.is_use_entire = false
    setting.begin_measure_index = 0
    setting.begin_beat_index = 0
    setting.end_measure_index = 1
    setting.end_beat_index = 1

    self.assert_equal(24+24+33+33, metronome.validated_ticks_of_interest.size)

    setting.is_use_entire = true
    metronome.reset

    self.assert_equal(24+24+33+33, metronome.validated_ticks_of_interest.size)

  end
end
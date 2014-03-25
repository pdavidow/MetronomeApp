require 'test_helper'

class TestTick < ActiveSupport::TestCase
  def test_state
    Mongoid.purge!

    u1 = User.create(email:'u1@user.com', password:'qewr5675jkljgrty')
    p1 = u1.pieces.create(name: 'a', composer: 'c1')
    p1.measures.push(Measure.new)
    p1.measures.last.beats.push(Beat.new(rh:3, lh:4))
    u1 = User.first
    p1 = u1.pieces.find_by(name: 'a', composer: 'c1')
    metronome = PolyrhythmicMetronome.new(p1)
    metronome.setting.classic_ticks_per_beat = 3
    ticks = metronome.validated_ticks_of_interest

    self.assert_equal(12, ticks.size)

    range = (0..11)
    self.assert_equal([0,4,8], range.select{|each| ticks[each].is_classic})
    self.assert_equal([0,4,8], range.select{|each| ticks[each].is_right_hand})
    self.assert_equal([0,3,6,9], range.select{|each| ticks[each].is_left_hand})
    self.assert_equal([1,2,5,7,10,11], range.select{|each| ticks[each].is_background})
  end

  def test_display_1
    Mongoid.purge!

    u1 = User.create(email:'u1@user.com', password:'qewr5675jkljgrty')
    p1 = u1.pieces.create(name: 'a', composer: 'c1')
    p1.measures.push(Measure.new)
    p1.measures.last.beats.push(Beat.new(rh:1, lh:1))
    u1 = User.first
    p1 = u1.pieces.find_by(name: 'a', composer: 'c1')
    metronome = PolyrhythmicMetronome.new(p1)
    metronome.setting.classic_ticks_per_minute = 60
    metronome.setting.classic_ticks_per_beat = 1
    ticks = metronome.validated_ticks_of_interest

    self.assert_equal("measure 0, beat 0, tick 0", ticks.first.location_description)
  end

  def test_display_2
    Mongoid.purge!

    u1 = User.create(email:'u1@user.com', password:'qewr5675jkljgrty')
    p1 = u1.pieces.create(name: 'a', composer: 'c1')
    p1.measures.push(Measure.new)
    p1.measures.last.beats.push(Beat.new(rh:1, lh:4))
    p1.measures.last.beats.push(Beat.new(rh:2, lh:4))
    p1.measures.push(Measure.new)
    p1.measures.last.beats.push(Beat.new(rh:3, lh:4))
    p1.measures.last.beats.push(Beat.new(rh:4, lh:4))
    u1 = User.first
    p1 = u1.pieces.find_by(name: 'a', composer: 'c1')
    metronome = PolyrhythmicMetronome.new(p1)
    metronome.setting.classic_ticks_per_minute = 10
    metronome.setting.classic_ticks_per_beat = 2
    metronome.setting.begin_measure_index = 0
    metronome.setting.begin_beat_index = 0
    metronome.setting.end_measure_index = 1
    metronome.setting.end_beat_index = 1
    classic_ticks = metronome.validated_ticks_of_interest.select{|each| each.is_classic}

    self.assert_equal(8, classic_ticks.size)
    self.assert_equal("measure 0, beat 0, tick 0", classic_ticks[0].location_description)
    self.assert_equal("measure 0, beat 0, tick 2", classic_ticks[1].location_description)
    self.assert_equal("measure 0, beat 1, tick 0", classic_ticks[2].location_description)
    self.assert_equal("measure 0, beat 1, tick 2", classic_ticks[3].location_description)
    self.assert_equal("measure 1, beat 0, tick 0", classic_ticks[4].location_description)
    self.assert_equal("measure 1, beat 0, tick 6", classic_ticks[5].location_description)
    self.assert_equal("measure 1, beat 1, tick 0", classic_ticks[6].location_description)
    self.assert_equal("measure 1, beat 1, tick 2", classic_ticks[7].location_description)
  end
end
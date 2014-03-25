require 'test_helper'

class TestTickSetting < ActiveSupport::TestCase

  def test_want_all_aspects_for_everything_tick
    Mongoid.purge!

    u1 = User.create(email:'u1@user.com', password:'qewr5675jkljgrty')
    p1 = u1.pieces.create(name: 'a', composer: 'c1')
    p1.measures.push(Measure.new)
    p1.measures.last.beats.push(Beat.new(rh:2, lh:3))
    p1.save
    u1 = User.first
    p1 = u1.pieces.find_by(name: 'a', composer: 'c1')
    setting = p1.metronome_setting
    setting.is_mute_right_and_left_for_classic = false
    setting.classic_ticks_per_beat = 1
    setting.is_background_on_all_ticks = true
    setting.is_background_tick = true
    setting.is_classic_tick = true
    setting.is_right_hand_tick = true
    setting.is_left_hand_tick = true
    p1.save
    p1 = u1.pieces.find_by(name: 'a', composer: 'c1')
    metronome = PolyrhythmicMetronome.new(p1)
    tick = metronome.validated_ticks_of_interest.first # by default, all aspects true
    setting = metronome.setting

    self.assert_equal(true, setting.is_tick_background(tick))
    self.assert_equal(true, setting.is_tick_classic(tick))
    self.assert_equal(true, setting.is_tick_right_hand(tick))
    self.assert_equal(true, setting.is_tick_left_hand(tick))
  end

  def test_want_no_aspects_for_everything_tick
    Mongoid.purge!

    u1 = User.create(email:'u1@user.com', password:'qewr5675jkljgrty')
    p1 = u1.pieces.create(name: 'a', composer: 'c1')
    p1.measures.push(Measure.new)
    p1.measures.last.beats.push(Beat.new(rh:2, lh:3))
    p1.save
    u1 = User.first
    p1 = u1.pieces.find_by(name: 'a', composer: 'c1')
    setting = p1.metronome_setting
    setting.is_mute_right_and_left_for_classic = false
    setting.classic_ticks_per_beat = 1
    setting.is_background_on_all_ticks = true
    setting.is_background_tick = false
    setting.is_classic_tick = false
    setting.is_right_hand_tick = false
    setting.is_left_hand_tick = false
    p1.save
    p1 = u1.pieces.find_by(name: 'a', composer: 'c1')
    metronome = PolyrhythmicMetronome.new(p1)
    tick = metronome.validated_ticks_of_interest.first # by default, all aspects true
    setting = metronome.setting

    self.assert_equal(false, setting.is_tick_background(tick))
    self.assert_equal(false, setting.is_tick_classic(tick))
    self.assert_equal(false, setting.is_tick_right_hand(tick))
    self.assert_equal(false, setting.is_tick_left_hand(tick))
  end

  def test_want_all_aspects_for_background_tick
    Mongoid.purge!

    u1 = User.create(email:'u1@user.com', password:'qewr5675jkljgrty')
    p1 = u1.pieces.create(name: 'a', composer: 'c1')
    p1.measures.push(Measure.new)
    p1.measures.last.beats.push(Beat.new(rh:2, lh:3))
    p1.save
    u1 = User.first
    p1 = u1.pieces.find_by(name: 'a', composer: 'c1')
    setting = p1.metronome_setting
    setting.is_mute_right_and_left_for_classic = false
    setting.classic_ticks_per_beat = 1
    setting.is_background_on_all_ticks = true
    setting.is_background_tick = true
    setting.is_classic_tick = true
    setting.is_right_hand_tick = true
    setting.is_left_hand_tick = true
    p1.save
    p1 = u1.pieces.find_by(name: 'a', composer: 'c1')
    metronome = PolyrhythmicMetronome.new(p1)
    tick = metronome.validated_ticks_of_interest.last # only background aspect
    setting = metronome.setting

    self.assert_equal(true, setting.is_tick_background(tick))
    self.assert_equal(false, setting.is_tick_classic(tick))
    self.assert_equal(false, setting.is_tick_right_hand(tick))
    self.assert_equal(false, setting.is_tick_left_hand(tick))
  end

  def test_want_no_aspects_for_background_tick
    Mongoid.purge!

    u1 = User.create(email:'u1@user.com', password:'qewr5675jkljgrty')
    p1 = u1.pieces.create(name: 'a', composer: 'c1')
    p1.measures.push(Measure.new)
    p1.measures.last.beats.push(Beat.new(rh:2, lh:3))
    p1.save
    u1 = User.first
    p1 = u1.pieces.find_by(name: 'a', composer: 'c1')
    setting = p1.metronome_setting
    setting.is_mute_right_and_left_for_classic = false
    setting.classic_ticks_per_beat = 1
    setting.is_background_on_all_ticks = true
    setting.is_background_tick = false
    setting.is_classic_tick = false
    setting.is_right_hand_tick = false
    setting.is_left_hand_tick = false
    p1.save
    p1 = u1.pieces.find_by(name: 'a', composer: 'c1')
    metronome = PolyrhythmicMetronome.new(p1)
    tick = metronome.validated_ticks_of_interest.last # only background aspect
    setting = metronome.setting

    self.assert_equal(false, setting.is_tick_background(tick))
    self.assert_equal(false, setting.is_tick_classic(tick))
    self.assert_equal(false, setting.is_tick_right_hand(tick))
    self.assert_equal(false, setting.is_tick_left_hand(tick))
  end

  def test_want_all_aspects_for_right_hand_tick
    Mongoid.purge!

    u1 = User.create(email:'u1@user.com', password:'qewr5675jkljgrty')
    p1 = u1.pieces.create(name: 'a', composer: 'c1')
    p1.measures.push(Measure.new)
    p1.measures.last.beats.push(Beat.new(rh:2, lh:3))
    p1.save
    u1 = User.first
    p1 = u1.pieces.find_by(name: 'a', composer: 'c1')
    setting = p1.metronome_setting
    setting.is_mute_right_and_left_for_classic = false
    setting.classic_ticks_per_beat = 1
    setting.is_background_on_all_ticks = true
    setting.is_background_tick = true
    setting.is_classic_tick = true
    setting.is_right_hand_tick = true
    setting.is_left_hand_tick = true
    p1.save
    p1 = u1.pieces.find_by(name: 'a', composer: 'c1')
    metronome = PolyrhythmicMetronome.new(p1)
    tick = metronome.validated_ticks_of_interest[3]
    setting = metronome.setting

    self.assert_equal(true, setting.is_tick_background(tick))
    self.assert_equal(false, setting.is_tick_classic(tick))
    self.assert_equal(true, setting.is_tick_right_hand(tick))
    self.assert_equal(false, setting.is_tick_left_hand(tick))
  end

  def test_want_no_aspects_for_right_hand_tick
    Mongoid.purge!

    u1 = User.create(email:'u1@user.com', password:'qewr5675jkljgrty')
    p1 = u1.pieces.create(name: 'a', composer: 'c1')
    p1.measures.push(Measure.new)
    p1.measures.last.beats.push(Beat.new(rh:2, lh:3))
    p1.save
    u1 = User.first
    p1 = u1.pieces.find_by(name: 'a', composer: 'c1')
    setting = p1.metronome_setting
    setting.is_mute_right_and_left_for_classic = false
    setting.classic_ticks_per_beat = 1
    setting.is_background_on_all_ticks = true
    setting.is_background_tick = false
    setting.is_classic_tick = false
    setting.is_right_hand_tick = false
    setting.is_left_hand_tick = false
    p1.save
    p1 = u1.pieces.find_by(name: 'a', composer: 'c1')
    metronome = PolyrhythmicMetronome.new(p1)
    tick = metronome.validated_ticks_of_interest[3]
    setting = metronome.setting

    self.assert_equal(false, setting.is_tick_background(tick))
    self.assert_equal(false, setting.is_tick_classic(tick))
    self.assert_equal(false, setting.is_tick_right_hand(tick))
    self.assert_equal(false, setting.is_tick_left_hand(tick))
  end

  def test_want_all_aspects_for_left_hand_tick
    Mongoid.purge!

    u1 = User.create(email:'u1@user.com', password:'qewr5675jkljgrty')
    p1 = u1.pieces.create(name: 'a', composer: 'c1')
    p1.measures.push(Measure.new)
    p1.measures.last.beats.push(Beat.new(rh:2, lh:3))
    p1.save
    u1 = User.first
    p1 = u1.pieces.find_by(name: 'a', composer: 'c1')
    setting = p1.metronome_setting
    setting.is_mute_right_and_left_for_classic = false
    setting.classic_ticks_per_beat = 1
    setting.is_background_on_all_ticks = true
    setting.is_background_tick = true
    setting.is_classic_tick = true
    setting.is_right_hand_tick = true
    setting.is_left_hand_tick = true
    p1.save
    p1 = u1.pieces.find_by(name: 'a', composer: 'c1')
    metronome = PolyrhythmicMetronome.new(p1)
    tick = metronome.validated_ticks_of_interest[4]
    setting = metronome.setting

    self.assert_equal(true, setting.is_tick_background(tick))
    self.assert_equal(false, setting.is_tick_classic(tick))
    self.assert_equal(false, setting.is_tick_right_hand(tick))
    self.assert_equal(true, setting.is_tick_left_hand(tick))
  end

  def test_want_no_aspects_for_left_hand_tick
    Mongoid.purge!

    u1 = User.create(email:'u1@user.com', password:'qewr5675jkljgrty')
    p1 = u1.pieces.create(name: 'a', composer: 'c1')
    p1.measures.push(Measure.new)
    p1.measures.last.beats.push(Beat.new(rh:2, lh:3))
    p1.save
    u1 = User.first
    p1 = u1.pieces.find_by(name: 'a', composer: 'c1')
    setting = p1.metronome_setting
    setting.is_mute_right_and_left_for_classic = false
    setting.classic_ticks_per_beat = 1
    setting.is_background_on_all_ticks = true
    setting.is_background_tick = false
    setting.is_classic_tick = false
    setting.is_right_hand_tick = false
    setting.is_left_hand_tick = false
    p1.save
    p1 = u1.pieces.find_by(name: 'a', composer: 'c1')
    metronome = PolyrhythmicMetronome.new(p1)
    tick = metronome.validated_ticks_of_interest[4]
    setting = metronome.setting

    self.assert_equal(false, setting.is_tick_background(tick))
    self.assert_equal(false, setting.is_tick_classic(tick))
    self.assert_equal(false, setting.is_tick_right_hand(tick))
    self.assert_equal(false, setting.is_tick_left_hand(tick))
  end

  def test_want_background_aspect_on_all_ticks_yes_want_background_tick
    Mongoid.purge!

    u1 = User.create(email:'u1@user.com', password:'qewr5675jkljgrty')
    p1 = u1.pieces.create(name: 'a', composer: 'c1')
    p1.measures.push(Measure.new)
    p1.measures.last.beats.push(Beat.new(rh:2, lh:3))
    p1.save
    u1 = User.first
    p1 = u1.pieces.find_by(name: 'a', composer: 'c1')
    setting = p1.metronome_setting
    setting.is_mute_right_and_left_for_classic = false
    setting.classic_ticks_per_beat = 1
    setting.is_background_on_all_ticks = true
    setting.is_background_tick = true
    p1.save
    p1 = u1.pieces.find_by(name: 'a', composer: 'c1')
    metronome = PolyrhythmicMetronome.new(p1)
    tick = metronome.validated_ticks_of_interest.first # by default, all aspects true
    setting = metronome.setting

    self.assert_equal(true, setting.is_tick_background(tick))

    setting.is_background_on_all_ticks = false
    setting.is_background_tick = true
    p1.save
    p1 = u1.pieces.find_by(name: 'a', composer: 'c1')
    metronome = PolyrhythmicMetronome.new(p1)
    setting = metronome.setting
    tick = metronome.validated_ticks_of_interest.first # by default, all aspects true

    self.assert_equal(false, setting.is_tick_background(tick))

    setting.is_background_on_all_ticks = true
    setting.is_background_tick = true
    p1.save
    p1 = u1.pieces.find_by(name: 'a', composer: 'c1')
    metronome = PolyrhythmicMetronome.new(p1)
    setting = metronome.setting
    tick = metronome.validated_ticks_of_interest.last # by default, only background

    self.assert_equal(true, setting.is_tick_background(tick))

    setting.is_background_on_all_ticks = false
    setting.is_background_tick = true
    p1.save
    p1 = u1.pieces.find_by(name: 'a', composer: 'c1')
    metronome = PolyrhythmicMetronome.new(p1)
    setting = metronome.setting
    tick = metronome.validated_ticks_of_interest.last # by default, only background

    self.assert_equal(true, setting.is_tick_background(tick))
  end

  def test_want_background_aspect_on_all_ticks_no_want_background_tick
    Mongoid.purge!

    u1 = User.create(email:'u1@user.com', password:'qewr5675jkljgrty')
    p1 = u1.pieces.create(name: 'a', composer: 'c1')
    p1.measures.push(Measure.new)
    p1.measures.last.beats.push(Beat.new(rh:2, lh:3))
    p1.save
    u1 = User.first
    p1 = u1.pieces.find_by(name: 'a', composer: 'c1')
    setting = p1.metronome_setting
    setting.is_mute_right_and_left_for_classic = false
    setting.classic_ticks_per_beat = 1
    setting.is_background_on_all_ticks = true
    setting.is_background_tick = false
    p1.save
    p1 = u1.pieces.find_by(name: 'a', composer: 'c1')
    metronome = PolyrhythmicMetronome.new(p1)
    tick = metronome.validated_ticks_of_interest.first # by default, all aspects true
    setting = metronome.setting

    self.assert_equal(false, setting.is_tick_background(tick))

    setting.is_background_on_all_ticks = false
    setting.is_background_tick = false
    p1.save
    p1 = u1.pieces.find_by(name: 'a', composer: 'c1')
    metronome = PolyrhythmicMetronome.new(p1)
    setting = metronome.setting
    tick = metronome.validated_ticks_of_interest.first # by default, all aspects true

    self.assert_equal(false, setting.is_tick_background(tick))

    setting.is_background_on_all_ticks = true
    setting.is_background_tick = false
    p1.save
    p1 = u1.pieces.find_by(name: 'a', composer: 'c1')
    metronome = PolyrhythmicMetronome.new(p1)
    setting = metronome.setting
    tick = metronome.validated_ticks_of_interest.last # by default, only background

    self.assert_equal(false, setting.is_tick_background(tick))

    setting.is_background_on_all_ticks = false
    setting.is_background_tick = false
    p1.save
    p1 = u1.pieces.find_by(name: 'a', composer: 'c1')
    metronome = PolyrhythmicMetronome.new(p1)
    setting = metronome.setting
    tick = metronome.validated_ticks_of_interest.last # by default, only background

    self.assert_equal(false, setting.is_tick_background(tick))
  end

  def test_is_tick_background_for_everything_tick
    Mongoid.purge!

    u1 = User.create(email:'u1@user.com', password:'qewr5675jkljgrty')
    p1 = u1.pieces.create(name: 'a', composer: 'c1')
    p1.measures.push(Measure.new)
    p1.measures.last.beats.push(Beat.new(rh:2, lh:3))
    p1.save
    u1 = User.first
    p1 = u1.pieces.find_by(name: 'a', composer: 'c1')
    setting = p1.metronome_setting
    setting.is_mute_right_and_left_for_classic = false
    setting.classic_ticks_per_beat = 1
    setting.is_background_on_all_ticks = false
    setting.is_background_tick = true
    p1.save
    p1 = u1.pieces.find_by(name: 'a', composer: 'c1')
    metronome = PolyrhythmicMetronome.new(p1)
    tick = metronome.validated_ticks_of_interest.first # by default, all aspects true
    setting = metronome.setting

    self.assert_equal(false, setting.is_tick_background(tick))

    setting.is_background_on_all_ticks = false
    setting.is_background_tick = true
    setting.is_classic_tick = false
    setting.is_right_hand_tick = false
    setting.is_left_hand_tick = false
    p1.save
    p1 = u1.pieces.find_by(name: 'a', composer: 'c1')
    metronome = PolyrhythmicMetronome.new(p1)
    tick = metronome.validated_ticks_of_interest.first # by default, all aspects true
    setting = metronome.setting

    self.assert_equal(true, setting.is_tick_background(tick))

    setting.is_background_on_all_ticks = false
    setting.is_background_tick = true
    setting.is_classic_tick = true
    setting.is_right_hand_tick = false
    setting.is_left_hand_tick = false
    p1.save
    p1 = u1.pieces.find_by(name: 'a', composer: 'c1')
    metronome = PolyrhythmicMetronome.new(p1)
    tick = metronome.validated_ticks_of_interest.first # by default, all aspects true
    setting = metronome.setting

    self.assert_equal(false, setting.is_tick_background(tick))

    setting.is_background_on_all_ticks = false
    setting.is_background_tick = true
    setting.is_classic_tick = false
    setting.is_right_hand_tick = true
    setting.is_left_hand_tick = false
    p1.save
    p1 = u1.pieces.find_by(name: 'a', composer: 'c1')
    metronome = PolyrhythmicMetronome.new(p1)
    tick = metronome.validated_ticks_of_interest.first # by default, all aspects true
    setting = metronome.setting

    self.assert_equal(false, setting.is_tick_background(tick))

    setting.is_background_on_all_ticks = false
    setting.is_background_tick = true
    setting.is_classic_tick = false
    setting.is_right_hand_tick = false
    setting.is_left_hand_tick = true
    p1.save
    p1 = u1.pieces.find_by(name: 'a', composer: 'c1')
    metronome = PolyrhythmicMetronome.new(p1)
    tick = metronome.validated_ticks_of_interest.first # by default, all aspects true
    setting = metronome.setting

    self.assert_equal(false, setting.is_tick_background(tick))

    setting.is_background_on_all_ticks = false
    setting.is_background_tick = true
    setting.is_classic_tick = true
    setting.is_right_hand_tick = true
    setting.is_left_hand_tick = true
    p1.save
    p1 = u1.pieces.find_by(name: 'a', composer: 'c1')
    metronome = PolyrhythmicMetronome.new(p1)
    tick = metronome.validated_ticks_of_interest.first # by default, all aspects true
    setting = metronome.setting

    self.assert_equal(false, setting.is_tick_background(tick))
  end

  def test_is_tick_background_for_background_tick
    Mongoid.purge!

    u1 = User.create(email:'u1@user.com', password:'qewr5675jkljgrty')
    p1 = u1.pieces.create(name: 'a', composer: 'c1')
    p1.measures.push(Measure.new)
    p1.measures.last.beats.push(Beat.new(rh:2, lh:3))
    p1.save
    u1 = User.first
    p1 = u1.pieces.find_by(name: 'a', composer: 'c1')
    setting = p1.metronome_setting
    setting.is_mute_right_and_left_for_classic = false
    setting.classic_ticks_per_beat = 1
    setting.is_background_on_all_ticks = false
    setting.is_background_tick = true
    p1.save
    p1 = u1.pieces.find_by(name: 'a', composer: 'c1')
    metronome = PolyrhythmicMetronome.new(p1)
    tick = metronome.validated_ticks_of_interest.last # only background aspect
    setting = metronome.setting

    self.assert_equal(true, setting.is_tick_background(tick))

    setting.is_background_on_all_ticks = false
    setting.is_background_tick = true
    setting.is_classic_tick = false
    setting.is_right_hand_tick = false
    setting.is_left_hand_tick = false
    p1.save
    p1 = u1.pieces.find_by(name: 'a', composer: 'c1')
    metronome = PolyrhythmicMetronome.new(p1)
    tick = metronome.validated_ticks_of_interest.last # only background aspect
    setting = metronome.setting

    self.assert_equal(true, setting.is_tick_background(tick))

    setting.is_background_on_all_ticks = false
    setting.is_background_tick = true
    setting.is_classic_tick = true
    setting.is_right_hand_tick = false
    setting.is_left_hand_tick = false
    p1.save
    p1 = u1.pieces.find_by(name: 'a', composer: 'c1')
    metronome = PolyrhythmicMetronome.new(p1)
    tick = metronome.validated_ticks_of_interest.last # only background aspect
    setting = metronome.setting

    self.assert_equal(true, setting.is_tick_background(tick))

    setting.is_background_on_all_ticks = false
    setting.is_background_tick = true
    setting.is_classic_tick = false
    setting.is_right_hand_tick = true
    setting.is_left_hand_tick = false
    p1.save
    p1 = u1.pieces.find_by(name: 'a', composer: 'c1')
    metronome = PolyrhythmicMetronome.new(p1)
    tick = metronome.validated_ticks_of_interest.last # only background aspect
    setting = metronome.setting

    self.assert_equal(true, setting.is_tick_background(tick))

    setting.is_background_on_all_ticks = false
    setting.is_background_tick = true
    setting.is_classic_tick = false
    setting.is_right_hand_tick = false
    setting.is_left_hand_tick = true
    p1.save
    p1 = u1.pieces.find_by(name: 'a', composer: 'c1')
    metronome = PolyrhythmicMetronome.new(p1)
    tick = metronome.validated_ticks_of_interest.last # only background aspect
    setting = metronome.setting

    self.assert_equal(true, setting.is_tick_background(tick))

    setting.is_background_on_all_ticks = false
    setting.is_background_tick = true
    setting.is_classic_tick = true
    setting.is_right_hand_tick = true
    setting.is_left_hand_tick = true
    p1.save
    p1 = u1.pieces.find_by(name: 'a', composer: 'c1')
    metronome = PolyrhythmicMetronome.new(p1)
    tick = metronome.validated_ticks_of_interest.last # only background aspect
    setting = metronome.setting

    self.assert_equal(true, setting.is_tick_background(tick))
  end

  def test_is_tick_background_for_classic_tick
    Mongoid.purge!

    u1 = User.create(email:'u1@user.com', password:'qewr5675jkljgrty')
    p1 = u1.pieces.create(name: 'a', composer: 'c1')
    p1.measures.push(Measure.new)
    p1.measures.last.beats.push(Beat.new(rh:2, lh:3))
    p1.save
    u1 = User.first
    p1 = u1.pieces.find_by(name: 'a', composer: 'c1')
    setting = p1.metronome_setting
    setting.is_mute_right_and_left_for_classic = false
    setting.classic_ticks_per_beat = 6
    setting.is_background_on_all_ticks = false
    setting.is_background_tick = true
    setting.is_classic_tick = true
    p1.save
    p1 = u1.pieces.find_by(name: 'a', composer: 'c1')
    metronome = PolyrhythmicMetronome.new(p1)
    tick = metronome.validated_ticks_of_interest[1] # classic only
    setting = metronome.setting

    self.assert_equal(false, setting.is_tick_background(tick))

    setting.is_background_on_all_ticks = false
    setting.is_background_tick = true
    setting.is_classic_tick = false
    setting.is_right_hand_tick = false
    setting.is_left_hand_tick = false
    p1.save
    p1 = u1.pieces.find_by(name: 'a', composer: 'c1')
    metronome = PolyrhythmicMetronome.new(p1)
    tick = metronome.validated_ticks_of_interest[1] # classic only
    setting = metronome.setting

    self.assert_equal(true, setting.is_tick_background(tick))

    setting.is_background_on_all_ticks = false
    setting.is_background_tick = true
    setting.is_classic_tick = true
    setting.is_right_hand_tick = false
    setting.is_left_hand_tick = false
    p1.save
    p1 = u1.pieces.find_by(name: 'a', composer: 'c1')
    metronome = PolyrhythmicMetronome.new(p1)
    tick = metronome.validated_ticks_of_interest[1] # classic only
    setting = metronome.setting

    self.assert_equal(false, setting.is_tick_background(tick))

    setting.is_background_on_all_ticks = false
    setting.is_background_tick = true
    setting.is_classic_tick = false
    setting.is_right_hand_tick = true
    setting.is_left_hand_tick = false
    p1.save
    p1 = u1.pieces.find_by(name: 'a', composer: 'c1')
    metronome = PolyrhythmicMetronome.new(p1)
    tick = metronome.validated_ticks_of_interest[1] # classic only
    setting = metronome.setting

    self.assert_equal(true, setting.is_tick_background(tick))

    setting.is_background_on_all_ticks = false
    setting.is_background_tick = true
    setting.is_classic_tick = false
    setting.is_right_hand_tick = false
    setting.is_left_hand_tick = true
    p1.save
    p1 = u1.pieces.find_by(name: 'a', composer: 'c1')
    metronome = PolyrhythmicMetronome.new(p1)
    tick = metronome.validated_ticks_of_interest[1] # classic only
    setting = metronome.setting

    self.assert_equal(true, setting.is_tick_background(tick))

    setting.is_background_on_all_ticks = false
    setting.is_background_tick = true
    setting.is_classic_tick = true
    setting.is_right_hand_tick = true
    setting.is_left_hand_tick = true
    p1.save
    p1 = u1.pieces.find_by(name: 'a', composer: 'c1')
    metronome = PolyrhythmicMetronome.new(p1)
    tick = metronome.validated_ticks_of_interest[1] # classic only
    setting = metronome.setting

    self.assert_equal(false, setting.is_tick_background(tick))
  end

  def test_is_tick_background_for_right_hand_tick
    Mongoid.purge!

    u1 = User.create(email:'u1@user.com', password:'qewr5675jkljgrty')
    p1 = u1.pieces.create(name: 'a', composer: 'c1')
    p1.measures.push(Measure.new)
    p1.measures.last.beats.push(Beat.new(rh:2, lh:3))
    p1.save
    u1 = User.first
    p1 = u1.pieces.find_by(name: 'a', composer: 'c1')
    setting = p1.metronome_setting
    setting.is_mute_right_and_left_for_classic = false
    setting.classic_ticks_per_beat = 1
    setting.is_background_on_all_ticks = false
    setting.is_background_tick = true
    setting.is_right_hand_tick = true
    p1.save
    p1 = u1.pieces.find_by(name: 'a', composer: 'c1')
    metronome = PolyrhythmicMetronome.new(p1)
    tick = metronome.validated_ticks_of_interest[3] # right_hand only
    setting = metronome.setting

    self.assert_equal(false, setting.is_tick_background(tick))

    setting.is_background_on_all_ticks = false
    setting.is_background_tick = true
    setting.is_classic_tick = false
    setting.is_right_hand_tick = false
    setting.is_left_hand_tick = false
    p1.save
    p1 = u1.pieces.find_by(name: 'a', composer: 'c1')
    metronome = PolyrhythmicMetronome.new(p1)
    tick = metronome.validated_ticks_of_interest[3] # right_hand only
    setting = metronome.setting

    self.assert_equal(true, setting.is_tick_background(tick))

    setting.is_background_on_all_ticks = false
    setting.is_background_tick = true
    setting.is_classic_tick = true
    setting.is_right_hand_tick = false
    setting.is_left_hand_tick = false
    p1.save
    p1 = u1.pieces.find_by(name: 'a', composer: 'c1')
    metronome = PolyrhythmicMetronome.new(p1)
    tick = metronome.validated_ticks_of_interest[3] # right_hand only
    setting = metronome.setting

    self.assert_equal(true, setting.is_tick_background(tick))

    setting.is_background_on_all_ticks = false
    setting.is_background_tick = true
    setting.is_classic_tick = false
    setting.is_right_hand_tick = true
    setting.is_left_hand_tick = false
    p1.save
    p1 = u1.pieces.find_by(name: 'a', composer: 'c1')
    metronome = PolyrhythmicMetronome.new(p1)
    tick = metronome.validated_ticks_of_interest[3] # right_hand only
    setting = metronome.setting

    self.assert_equal(false, setting.is_tick_background(tick))

    setting.is_background_on_all_ticks = false
    setting.is_background_tick = true
    setting.is_classic_tick = false
    setting.is_right_hand_tick = false
    setting.is_left_hand_tick = true
    p1.save
    p1 = u1.pieces.find_by(name: 'a', composer: 'c1')
    metronome = PolyrhythmicMetronome.new(p1)
    tick = metronome.validated_ticks_of_interest[3] # right_hand only
    setting = metronome.setting

    self.assert_equal(true, setting.is_tick_background(tick))

    setting.is_background_on_all_ticks = false
    setting.is_background_tick = true
    setting.is_classic_tick = true
    setting.is_right_hand_tick = true
    setting.is_left_hand_tick = true
    p1.save
    p1 = u1.pieces.find_by(name: 'a', composer: 'c1')
    metronome = PolyrhythmicMetronome.new(p1)
    tick = metronome.validated_ticks_of_interest[3] # right_hand only
    setting = metronome.setting

    self.assert_equal(false, setting.is_tick_background(tick))
  end

  def test_is_tick_background_for_left_hand_tick
    Mongoid.purge!

    u1 = User.create(email:'u1@user.com', password:'qewr5675jkljgrty')
    p1 = u1.pieces.create(name: 'a', composer: 'c1')
    p1.measures.push(Measure.new)
    p1.measures.last.beats.push(Beat.new(rh:2, lh:3))
    p1.save
    u1 = User.first
    p1 = u1.pieces.find_by(name: 'a', composer: 'c1')
    setting = p1.metronome_setting
    setting.is_mute_right_and_left_for_classic = false
    setting.classic_ticks_per_beat = 1
    setting.is_background_on_all_ticks = false
    setting.is_background_tick = true
    setting.is_left_hand_tick = true
    p1.save
    p1 = u1.pieces.find_by(name: 'a', composer: 'c1')
    metronome = PolyrhythmicMetronome.new(p1)
    tick = metronome.validated_ticks_of_interest[4] # left_hand only
    setting = metronome.setting

    self.assert_equal(false, setting.is_tick_background(tick))

    setting.is_background_on_all_ticks = false
    setting.is_background_tick = true
    setting.is_classic_tick = false
    setting.is_right_hand_tick = false
    setting.is_left_hand_tick = false
    p1.save
    p1 = u1.pieces.find_by(name: 'a', composer: 'c1')
    metronome = PolyrhythmicMetronome.new(p1)
    tick = metronome.validated_ticks_of_interest[4] # left_hand only
    setting = metronome.setting

    self.assert_equal(true, setting.is_tick_background(tick))

    setting.is_background_on_all_ticks = false
    setting.is_background_tick = true
    setting.is_classic_tick = true
    setting.is_right_hand_tick = false
    setting.is_left_hand_tick = false
    p1.save
    p1 = u1.pieces.find_by(name: 'a', composer: 'c1')
    metronome = PolyrhythmicMetronome.new(p1)
    tick = metronome.validated_ticks_of_interest[4] # left_hand only
    setting = metronome.setting

    self.assert_equal(true, setting.is_tick_background(tick))

    setting.is_background_on_all_ticks = false
    setting.is_background_tick = true
    setting.is_classic_tick = false
    setting.is_right_hand_tick = true
    setting.is_left_hand_tick = false
    p1.save
    p1 = u1.pieces.find_by(name: 'a', composer: 'c1')
    metronome = PolyrhythmicMetronome.new(p1)
    tick = metronome.validated_ticks_of_interest[4] # left_hand only
    setting = metronome.setting

    self.assert_equal(true, setting.is_tick_background(tick))

    setting.is_background_on_all_ticks = false
    setting.is_background_tick = true
    setting.is_classic_tick = false
    setting.is_right_hand_tick = false
    setting.is_left_hand_tick = true
    p1.save
    p1 = u1.pieces.find_by(name: 'a', composer: 'c1')
    metronome = PolyrhythmicMetronome.new(p1)
    tick = metronome.validated_ticks_of_interest[4] # left_hand only
    setting = metronome.setting

    self.assert_equal(false, setting.is_tick_background(tick))

    setting.is_background_on_all_ticks = false
    setting.is_background_tick = true
    setting.is_classic_tick = true
    setting.is_right_hand_tick = true
    setting.is_left_hand_tick = true
    p1.save
    p1 = u1.pieces.find_by(name: 'a', composer: 'c1')
    metronome = PolyrhythmicMetronome.new(p1)
    tick = metronome.validated_ticks_of_interest[4] # left_hand only
    setting = metronome.setting

    self.assert_equal(false, setting.is_tick_background(tick))
  end

  def test_tick_to_audio
    Mongoid.purge!

    u1 = User.create(email:'u1@user.com', password:'qewr5675jkljgrty')
    p1 = u1.pieces.create(name: 'a', composer: 'c1')
    p1.measures.push(Measure.new)
    p1.measures.last.beats.push(Beat.new(rh:2, lh:3))
    p1.save
    u1 = User.first
    p1 = u1.pieces.find_by(name: 'a', composer: 'c1')
    setting = p1.metronome_setting
    setting.is_mute_right_and_left_for_classic = false
    setting.classic_ticks_per_beat = 1
    setting.is_background_on_all_ticks = true
    setting.is_background_tick = true
    setting.is_classic_tick = true
    setting.is_right_hand_tick = true
    setting.is_left_hand_tick = true
    p1.save
    p1 = u1.pieces.find_by(name: 'a', composer: 'c1')
    metronome = PolyrhythmicMetronome.new(p1)
    tick = metronome.validated_ticks_of_interest.first # by default, all aspects true
    setting = metronome.setting
    hash = tick.to_audio

    self.assert_equal(true, hash[:is_background])
    self.assert_equal(true, hash[:is_classic])
    self.assert_equal(true, hash[:is_right_hand])
    self.assert_equal(true, hash[:is_left_hand])
  end

  def test_is_mute_right_and_left_for_classic
    Mongoid.purge!

    u1 = User.create(email:'u1@user.com', password:'qewr5675jkljgrty')
    p1 = u1.pieces.create(name: 'a', composer: 'c1')
    p1.measures.push(Measure.new)
    p1.measures.last.beats.push(Beat.new(rh:2, lh:3))
    p1.save
    u1 = User.first
    p1 = u1.pieces.find_by(name: 'a', composer: 'c1')
    setting = p1.metronome_setting
    setting.is_mute_right_and_left_for_classic = false
    setting.classic_ticks_per_beat = 1
    setting.is_classic_tick = true
    setting.is_mute_right_and_left_for_classic = true
    setting.is_right_hand_tick = true
    setting.is_left_hand_tick = true
    p1.save
    p1 = u1.pieces.find_by(name: 'a', composer: 'c1')
    metronome = PolyrhythmicMetronome.new(p1)
    tick = metronome.validated_ticks_of_interest.first
    setting = metronome.setting

    self.assert_equal(true, setting.is_tick_classic(tick))
    self.assert_equal(false, setting.is_tick_right_hand(tick))
    self.assert_equal(false, setting.is_tick_left_hand(tick))

    setting.is_mute_right_and_left_for_classic = false
    p1.save
    p1 = u1.pieces.find_by(name: 'a', composer: 'c1')
    metronome = PolyrhythmicMetronome.new(p1)
    tick = metronome.validated_ticks_of_interest.first
    setting = metronome.setting

    self.assert_equal(true, setting.is_tick_classic(tick))
    self.assert_equal(true, setting.is_tick_right_hand(tick))
    self.assert_equal(true, setting.is_tick_left_hand(tick))

    setting.is_mute_right_and_left_for_classic = false
    setting.is_classic_tick = false
    p1.save
    p1 = u1.pieces.find_by(name: 'a', composer: 'c1')
    metronome = PolyrhythmicMetronome.new(p1)
    tick = metronome.validated_ticks_of_interest.first
    setting = metronome.setting

    self.assert_equal(false, setting.is_tick_classic(tick))
    self.assert_equal(true, setting.is_tick_right_hand(tick))
    self.assert_equal(true, setting.is_tick_left_hand(tick))

    setting.is_mute_right_and_left_for_classic = true
    setting.is_classic_tick = false
    p1.save
    p1 = u1.pieces.find_by(name: 'a', composer: 'c1')
    metronome = PolyrhythmicMetronome.new(p1)
    tick = metronome.validated_ticks_of_interest.first
    setting = metronome.setting

    self.assert_equal(false, setting.is_tick_classic(tick))
    self.assert_equal(true, setting.is_tick_right_hand(tick))
    self.assert_equal(true, setting.is_tick_left_hand(tick))
  end
end
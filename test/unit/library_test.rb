require 'test_helper'
#require 'active_support/core_ext/object/deep_dup'

class TestLibrary < ActiveSupport::TestCase
  def test_piece_clone
    Mongoid.purge!

    u1 = User.create(email:'u1@user.com', password:'qewr5675jkljgrty')
    p1 = u1.pieces.create(name: 'a', composer: 'c1')
    p1.measures.push(Measure.new)
    p1.measures.last.beats.push(Beat.new(rh:1, lh:1))
    p1.save!
    p2 = p1.clone
    p1.measures.last.beats.last.rh = 99
    p1.metronome_setting.begin_measure_index = 33
    p1.log.entries.new(contents: 'q123')
    self.assert_equal(1, p2.measures.last.beats.last.rh)
    self.assert_equal(99, p1.measures.last.beats.last.rh)
    self.assert_equal(0, p2.metronome_setting.begin_measure_index)
    self.assert_equal(33, p1.metronome_setting.begin_measure_index)
    self.assert_equal(0, p2.log.entries.size)
    self.assert_equal(1, p1.log.entries.size)
  end
end


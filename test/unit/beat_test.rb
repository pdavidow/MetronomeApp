require 'test_helper'

class TestBeat < ActiveSupport::TestCase
  def test_display_beat_index
    Mongoid.purge!

    m1 = Measure.new

    m1.beats.push(b1 = Beat.new)
    self.assert_equal(1, b1.display_beat_index)

    m1.beats.push(b2 = Beat.new)
    self.assert_equal(2, b2.display_beat_index)
  end

  def test_display_location_description
    Mongoid.purge!

    p1 = Piece.new
    p1.measures.push(m1 = Measure.new)

    m1.beats.push(b11 = Beat.new)
    self.assert_equal('Beat 1, Measure 1', b11.display_location_description)

    m1.beats.push(b21 = Beat.new)
    self.assert_equal('Beat 2, Measure 1', b21.display_location_description)

    p1.measures.push(m2 = Measure.new)

    m2.beats.push(b12 = Beat.new)
    self.assert_equal('Beat 1, Measure 2', b12.display_location_description)

    m2.beats.push(b22 = Beat.new)
    self.assert_equal('Beat 2, Measure 2', b22.display_location_description)
  end

  def test_display_location_description_1_1
    Mongoid.purge!

    u1 = User.create(email:'u1@user.com', password:'qewr5675jkljgrty')
    p1 = u1.pieces.create(name: 'a', composer: 'c1')
    p1.measures.push(Measure.new)
    p1.measures.last.beats.push(Beat.new(rh:1, lh:1))
    p1.save
    u1 = User.first
    p1 = u1.pieces.find_by(name: 'a')

    self.assert_equal('Beat 1, Measure 1', p1.measures.last.beats.last.display_location_description)
  end
end
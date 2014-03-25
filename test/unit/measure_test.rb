require 'test_helper'

class TestMeausre < ActiveSupport::TestCase
  def test_display
    Mongoid.purge!

    measure = Measure.new
    self.assert_equal('[]', measure.to_s)

    measure.beats.push(Beat.new(rh:1, lh:2))
    self.assert_equal('[[1/2]]', measure.to_s)

    measure.beats.push(Beat.new(rh:3, lh:4))
    self.assert_equal('[[1/2][3/4]]', measure.to_s)
  end

  def test_user_index
    Mongoid.purge!

    p1 = Piece.new

    p1.measures.push(m1 = Measure.new)
    self.assert_equal(1, m1.display_measure_index)

    p1.measures.push(m2 = Measure.new)
    self.assert_equal(2, m2.display_measure_index)
  end
end
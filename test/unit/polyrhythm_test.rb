require 'test_helper'

class TestPolyrhythm < ActiveSupport::TestCase
  def test_lowest_common_multiple
    self.assert_equal(6, Polyrhythm.new(3,2).lowest_common_multiple)
    self.assert_equal(24, Polyrhythm.new(8,3).lowest_common_multiple)
    self.assert_equal(24, Polyrhythm.new(8,6).lowest_common_multiple)

    exception = self.assert_raise(RuntimeError){Polyrhythm.new(3.1,2).lowest_common_multiple}
    self.assert_equal("must be positive integer", exception.message)
    exception = self.assert_raise(RuntimeError){Polyrhythm.new(3,2.1).lowest_common_multiple}
    self.assert_equal("must be positive integer", exception.message)
    exception = self.assert_raise(RuntimeError){Polyrhythm.new(-3,2).lowest_common_multiple}
    self.assert_equal("must be positive integer", exception.message)
    exception = self.assert_raise(RuntimeError){Polyrhythm.new(3,-2).lowest_common_multiple}
    self.assert_equal("must be positive integer", exception.message)
    exception = self.assert_raise(RuntimeError){Polyrhythm.new(3,0).lowest_common_multiple}
    self.assert_equal("must be positive integer", exception.message)
    exception = self.assert_raise(RuntimeError){Polyrhythm.new(0,2).lowest_common_multiple}
    self.assert_equal("must be positive integer", exception.message)
  end
end
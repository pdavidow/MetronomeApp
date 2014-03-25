require 'test_helper'

class TestLogEntry < ActiveSupport::TestCase

  def test_display_index
    Mongoid.purge!

    u1 = User.create(email:'u1@user.com', password:'qewr5675jkljgrty')
    p1 = u1.pieces.create(name: 'a', composer: 'c1')
    entries = p1.log.entries
    entries.push(LogEntry.new)
    entries.push(LogEntry.new)
    p1.save!

    u1 = User.first
    p1 = u1.pieces.find_by(name: 'a', composer: 'c1')
    entries = p1.log.entries

    self.assert_equal(1, entries.first.display_index)
    self.assert_equal(2, entries.last.display_index)
  end
end
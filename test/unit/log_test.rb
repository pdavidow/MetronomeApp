require 'test_helper'

class TestLog < ActiveSupport::TestCase
  def test_log_with_entries
    Mongoid.purge!

    u1 = User.create(email:'u1@user.com', password:'qewr5675jkljgrty')
    p1 = u1.pieces.create(name: 'a', composer: 'c1')
    string = 'practise @ 10 tpm'
    p1.log.entries.new(contents: string)
    p1.save!
    u1 = User.first
    p1 = u1.pieces.find_by(name: 'a', composer: 'c1')

    self.assert_equal(string, p1.log.entries.last.contents)
  end

  def test_log_with_entries_timestamp
    Mongoid.purge!

    u1 = User.create(email:'u1@user.com', password:'qewr5675jkljgrty')
    p1 = u1.pieces.create(name: 'a', composer: 'c1')
    string = 'practise @ 10 tpm'
    time = Time.now
    p1.log.entries.new(contents: string, time: time)
    p1.save!
    u1 = User.first
    p1 = u1.pieces.find_by(name: 'a', composer: 'c1')
    entry = p1.log.entries.last

    self.assert_equal(string, entry.contents)
    self.assert_equal(time.getgm.asctime, entry.time.getgm.asctime) # careful, Mongo truncates the nanoseconds
  end

  def test_log_many_entries
    Mongoid.purge!

    u1 = User.create(email:'u1@user.com', password:'qewr5675jkljgrty')
    p1 = u1.pieces.create(name: 'a', composer: 'c1')

    string_u1_p1_e1 = 'u1_p1_e1'
    string_u1_p1_e2 = 'u1_p1_e2'
    string_u1_p1_e3 = 'u1_p1_e3'

    p1.log.entries.new(contents: string_u1_p1_e1)
    Kernel.sleep(0.01)
    p1.log.entries.new(contents: string_u1_p1_e2)
    Kernel.sleep(0.01)
    p1.log.entries.new(contents: string_u1_p1_e3)
    p1.save!

    u1 = User.first
    p1 = u1.pieces.find_by(name: 'a', composer: 'c1')

    self.assert_equal(string_u1_p1_e1, p1.log.entries[0].contents)
    self.assert_equal(string_u1_p1_e2, p1.log.entries[1].contents)
    self.assert_equal(string_u1_p1_e3, p1.log.entries[2].contents)

    self.assert_equal(3, p1.log.entries.size)

    self.assert(p1.log.entries[0].time < p1.log.entries[1].time)
    self.assert(p1.log.entries[1].time < p1.log.entries[2].time)
  end
end

require 'test_helper'

class TestPiece < ActiveSupport::TestCase
  def test__to_s_1
    Mongoid.purge!

    p1 = Piece.new
    p1.name = 'Nocturne in E Minor'
    p1.composer = 'Chopin'
    p1.catalog_reference = 'Op.72 No.1'
    p1.save
    p1 = Piece.first

    self.assert_equal('Chopin, Nocturne in E Minor, Op.72 No.1', p1.to_s)
  end

  def test__to_s_2
    Mongoid.purge!

    p1 = Piece.new
    p1.name = 'Nocturne in Q Minor'
    p1.composer = 'C'
    p1.catalog_reference = 'Op.72 No.1001'

    self.assert_equal('C, Nocturne in Q Minor, Op.72 No.1001', p1.to_s)
  end

  def test__to_s_3
    Mongoid.purge!

    p1 = Piece.new
    p1.name = 'Nocturne in Q Minor'
    p1.composer = 'C'

    self.assert_equal('C, Nocturne in Q Minor', p1.to_s)
  end

  def test_find_piece_by_id  # (((Documenting the way Mongoid works)))
    Mongoid.purge!

    u1 = User.create(email:'u1@user.com', password:'qewr5675jkljgrty')
    p1 = u1.pieces.create(name: 'p1', composer: 'c1')
    id = p1._id

    self.assert_nothing_raised(Mongoid::Errors::DocumentNotFound){Piece.find(id)}  # Piece is referenced, not embedded
    self.assert_equal(p1, Piece.find(id))
  end

  def test_uniqueness_for_combination_of_composer_and_name
    Mongoid.purge!

    u1 = User.create(email:'u1@user.com', password:'qewr5675jkljgrty')
    p1 = u1.pieces.create(name: 'p1', composer: 'c1')
    p2 = u1.pieces.new(name: 'p1', composer: 'c2')
    p3 = u1.pieces.new(name: 'p2', composer: 'c1')
    p4 = u1.pieces.new(name: 'p1', composer: 'c1')

    self.assert_equal(true, p2.save)
    self.assert_equal(true, p2.save)
    self.assert_equal(true, p3.save)
    self.assert_equal(true, p3.save)
    self.assert_equal(false, p4.save)
    self.assert_equal(3, Piece.count)
    self.assert(p4.invalid?)
    self.assert_equal(["Combination of composer and name must be unique for piece (within user)"], p4.errors[:base])
    self.assert_equal(1, p4.errors.size)
    self.assert_equal(1, p4.errors[:base].size)

    u2 = User.create(email:'u2@user.com', password:'qewr5675jkljgrty')
    p5 = u2.pieces.new(name: 'p1', composer: 'c1')
    self.assert_equal(true, p5.save)
    p6 = u2.pieces.new(name: 'p1', composer: 'c1')
    self.assert_equal(false, p6.save)
  end
end


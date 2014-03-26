class Measure < Object
  include Mongoid::Document

  embedded_in :piece
  embeds_many :beats

  def initialize_copy
    self.beats = self.beats.clone
  end

  def measure_index
    self.piece.measures.index(self)
  end

  def display_measure_index
    self.measure_index + User::DISPLAY_INDEX_OFFSET
  end

  def metronome
    self.piece.metronome
  end

  def to_s
    string = '['
    self.beats.each{|each| string.concat(each.to_s)}
    return string + ']'
  end
end
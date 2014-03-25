class Beat < Object
  include Mongoid::Document

  field :rh, as: :right_hand, type: Integer, default: 1   # right hand note amount
  field :lh, as: :left_hand, type: Integer, default: 1   # left hand note amount

  embedded_in :measure

  validates :right_hand, presence: true, numericality: {greater_than: 0, less_than: 99999}
  validates :left_hand, presence: true, numericality: {greater_than: 0, less_than: 99999}

  attr_reader :ticks, :tick_amount, :right_hand_indicies, :left_hand_indicies

  def ticks
    @ticks ||= self.metronome.ticks_for_beat(self)
  end

  def ticks_for_sleep_interval(sleep_interval)
    ticks = (1..self.tick_amount).collect{|each| Tick.new(self, sleep_interval)}
    self.embellish_ticks(ticks)
    ticks
  end

  def embellish_ticks(ticks)
    self.right_hand_indicies.each{|each| ticks[each].is_right_hand = true}
    self.left_hand_indicies.each{|each| ticks[each].is_left_hand = true}
    self.classic_indicies.each{|each| ticks[each].is_classic = true}
  end

  def metronome
    self.measure.metronome
  end

  def classic_ticks_per_beat
    self.metronome.classic_ticks_per_beat
  end

  def tick_amount
    @tick_amount ||= (Polyrhythm.new(self.rh, self.lh).lowest_common_multiple)
  end

  def location_description
    "measure #{self.measure_index}, beat #{self.beat_index}"
  end

  def display_location_description
    "Beat #{self.display_beat_index}, Measure #{self.display_measure_index}"
  end

  def measure_index
    self.measure.measure_index
  end

  def display_measure_index
    self.measure.display_measure_index
  end

  def beat_index
    self.measure.beats.index(self)
  end

  def display_beat_index
    self.beat_index + 1
  end

  def right_hand_indicies
    @right_hand_indicies ||= self.spaced_indicies_for_amount(self.rh)
  end

  def left_hand_indicies
    @left_hand_indicies ||= self.spaced_indicies_for_amount(self.lh)
  end

  def right_and_left_hand_indicies
    self.right_hand_indicies & self.left_hand_indicies
  end

  def classic_indicies
    self.spaced_indicies_for_amount(self.classic_ticks_per_beat)
  end

  def spaced_indicies_for_amount(amount)
    interval = self.tick_amount / amount
    index = 0
    indicies = []
    while index < self.tick_amount
      indicies.push(index)
      index +=  interval
    end
    indicies
  end

  def to_s
    "[#{self.rh.to_s}/#{self.lh.to_s}]"
  end

  def to_audio
    {ticks: self.ticks.collect{|each| each.to_audio},
     display_location_description: self.display_location_description}
  end

  def piece
    self.measure.piece
  end
end
class Tick
  attr_accessor :sleep_interval, :beat, :is_classic, :is_right_hand, :is_left_hand

  def initialize(beat, sleep_interval=1)
    @beat = beat
    @sleep_interval = sleep_interval
    @is_classic = false
    @is_right_hand = false
    @is_left_hand = false
  end

  def is_background
    return false if is_classic
    return false if is_right_hand
    return false if is_left_hand
    true
  end

  def location_description
    "#{self.beat.location_description}, tick #{self.tick_index}"
  end

  def tick_index
    self.beat.ticks.index(self)
  end

  def piece
    self.beat.piece
  end

  def metronome_setting
    self.piece.metronome_setting
  end

  def to_audio
    setting = self.metronome_setting
    {wait_seconds: self.sleep_interval,
     is_background: setting.is_tick_background(self),
     is_classic: setting.is_tick_classic(self),
     is_right_hand: setting.is_tick_right_hand(self),
     is_left_hand: setting.is_tick_left_hand(self)}
  end
end
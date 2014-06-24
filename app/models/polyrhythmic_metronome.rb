class PolyrhythmicMetronome < Object
  include MetronomicExceptions

  attr_accessor :piece, :beats

  def initialize(piece)
    @piece = piece
  end

  def setting
    self.piece.metronome_setting
  end

  def classic_ticks_per_minute
    self.setting.classic_ticks_per_minute
  end

  def classic_ticks_per_beat
    self.setting.classic_ticks_per_beat
  end

  def ticks_per_second
    self.classic_ticks_per_minute.quo(60)
  end

  def reset
    self.reset_beats
  end

  def reset_beats
    self.beats = nil
  end

  def validate
    return if self.beats.empty?
    self.setting.validate_for_piece
  end

  def ticks_for_beat(beat)
    self.setting.validate_classic_ticks_per_beat(beat)
    sleep_interval = self.classic_ticks_per_beat.quo(beat.tick_amount * self.ticks_per_second)
    beat.ticks_for_sleep_interval(sleep_interval)
  end

  def beats_of_interest
    self.beats.select{|each| self.setting.interested_in_beat?(each)}
  end

  def beats
    @beats ||= self.piece.beats
  end

  def validated_beats_of_interest
    self.validate
    self.beats_of_interest
  end

  def validated_ticks_of_interest
    self.validated_beats_of_interest.collect{|each| each.ticks}.flatten
  end

  def to_audio
    hash = {
      beats: self.validated_beats_of_interest.collect{|each| each.to_audio},
      metronome_setting: self.setting.to_audio}
    hash[:user_id] = self.piece.user._id unless self.piece.user.nil?
    hash[:piece_id] = self.piece._id unless self.piece.nil?
    hash
  end
end
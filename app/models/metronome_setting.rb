class MetronomeSetting < Object
  include Mongoid::Document
  include MetronomicExceptions

  field :classic_ticks_per_minute, type: Integer, default: 30
  field :classic_ticks_per_beat, type: Integer, default: 1
  field :is_use_entire, type: Boolean, default: true
  field :is_loop, type: Boolean, default: false
  field :begin_measure_index, type: Integer, default: 0
  field :begin_beat_index, type: Integer, default: 0
  field :end_measure_index, type: Integer, default: 0
  field :end_beat_index, type: Integer, default: 0

  field :is_background_on_all_ticks, type: Boolean, default: true
  field :is_background_tick, type: Boolean, default: true
  field :is_classic_tick, type: Boolean, default: true
  field :is_mute_right_and_left_for_classic, type: Boolean, default: true
  field :is_right_hand_tick, type: Boolean, default: true
  field :is_left_hand_tick, type: Boolean, default: true
  field :is_stereo_for_right_left, type: Boolean, default: false
  field :is_log_usage, type: Boolean, default: false
  field :is_log_settings_if_log_usage, type: Boolean, default: false

  embedded_in :piece

  validates :classic_ticks_per_minute, presence: true, numericality: {greater_than: 0}
  validates :classic_ticks_per_beat, presence: true, numericality: {greater_than: 0}
  validate :validate_index_integrity, :validate_cross_index_integrity, unless: :is_use_entire

  attr_reader :piece

  def view_morphing_attributes
    {begin_beat_index: :display_begin_beat_index,
     begin_measure_index: :display_begin_measure_index,
     end_beat_index: :display_end_beat_index,
     end_measure_index: :display_end_measure_index}
  end

  def self.is_display_adapt
    @is_display_adapt ||= {}
  end

  def display_index_offset
    1
  end

  def index_base
    self.is_display_adapt ? self.display_index_offset : 0
  end

  def is_display_adapt
    self.class.is_display_adapt[self._id] = false if self.class.is_display_adapt[self._id].nil?
    self.class.is_display_adapt[self._id]
  end

  def display_adapt
    ### if stored on the instance side, #update_attributes will set to nil
    self.class.is_display_adapt[self._id] = true
  end

  def display_unadapt
    self.class.is_display_adapt.delete(self._id)
  end

  def update_attributes_from_display(params)
    self.display_adapt # only for the sake of generating appropriate validation errors
    self.classic_ticks_per_minute = params['classic_ticks_per_minute'].to_i
    self.classic_ticks_per_beat = params['classic_ticks_per_beat'].to_i
    self.is_background_on_all_ticks = ((params['is_background_on_all_ticks'].to_i) == 0) ?  false : true
    self.is_background_tick = ((params['is_background_tick'].to_i) == 0) ?  false : true
    self.is_classic_tick = ((params['is_classic_tick'].to_i) == 0) ?  false : true
    self.is_mute_right_and_left_for_classic = ((params['is_mute_right_and_left_for_classic'].to_i) == 0) ?  false : true
    self.is_right_hand_tick = ((params['is_right_hand_tick'].to_i) == 0) ?  false : true
    self.is_left_hand_tick = ((params['is_left_hand_tick'].to_i) == 0) ?  false : true
    self.is_use_entire = ((params['is_use_entire'].to_i) == 0) ?  false : true
    self.is_stereo_for_right_left = ((params['is_stereo_for_right_left'].to_i) == 0) ?  false : true
    self.is_loop = ((params['is_loop'].to_i) == 0) ?  false : true
    self.is_log_usage = ((params['is_log_usage'].to_i) == 0) ?  false : true
    self.is_log_settings_if_log_usage = ((params['is_log_settings_if_log_usage'].to_i) == 0) ?  false : true
    self.set_view_morphing_attributes_from_display(params) unless self.is_use_entire
    result = self.save
    self.display_unadapt
    result
  end

  def set_view_morphing_attributes_from_display(params)
    self.view_morphing_attributes.each_pair do |key,value|
      setter = (key.to_s + '=').to_sym
      display_datum = params[value.to_s].to_i
      self.send(setter, (display_datum - self.display_index_offset))
    end
  end

  def display_begin_measure_index
    self.begin_measure_index + self.display_index_offset
  end

  def display_begin_beat_index
    self.begin_beat_index + self.display_index_offset
  end

  def display_end_measure_index
    self.end_measure_index + self.display_index_offset
  end

  def display_end_beat_index
    self.end_beat_index + self.display_index_offset
  end

  def interested_in_beat?(beat)
    return true if self.is_use_entire

    measure_index = beat.measure_index
    return false unless self.begin_measure_index <= measure_index
    return false unless measure_index <= self.end_measure_index
    return true unless ((measure_index == self.begin_measure_index) or (measure_index == self.end_measure_index))

    beat_index = beat.beat_index
    if measure_index == self.begin_measure_index
      return false unless self.begin_beat_index <= beat_index
    end
    if measure_index == self.end_measure_index
      return false unless beat_index <= self.end_beat_index
    end

    true
  end

  def is_tick_background(tick)
    return self.is_background_tick if self.is_background_on_all_ticks
    return self.is_background_tick if tick.is_background
    return self.is_background_tick if (not self.is_tick_classic(tick) and not self.is_tick_right_hand(tick) and not self.is_tick_left_hand(tick))
    false
  end

  def is_tick_classic(tick)
    tick.is_classic and self.is_classic_tick
  end

  def is_tick_right_hand(tick)
    return false if self.is_mute_right_and_left_for_classic and self.is_tick_classic(tick)
    tick.is_right_hand and self.is_right_hand_tick
  end

  def is_tick_left_hand(tick)
    return false if self.is_mute_right_and_left_for_classic and self.is_tick_classic(tick)
    tick.is_left_hand and self.is_left_hand_tick
  end

  def validate_classic_ticks_per_beat(beat)
    unless beat.tick_amount.modulo(self.classic_ticks_per_beat).zero? then
      raise MetronomeSettingError_ClassicTicksPerBeat.new_for__classic_ticks_per_beat__for_beat(self.classic_ticks_per_beat, beat)
    end
  end

  def validate_for_piece
    return if self.is_use_entire
    raise MetronomeSettingError, "Metronome-Setting begin measure index must not exceed number of measures for piece" if self.begin_measure_index >= self.piece.measures.size
    raise MetronomeSettingError, "Metronome-Setting begin beat index must not exceed number of beats in begin measure" if self.begin_beat_index >= self.piece.measures[self.begin_measure_index].beats.size
    raise MetronomeSettingError, "Metronome-Setting end measure index must not exceed number of measures for piece" if self.end_measure_index >= self.piece.measures.size
    raise MetronomeSettingError, "Metronome-Setting end beat index must not exceed number of beats in end measure" if self.end_beat_index >= self.piece.measures[self.end_measure_index].beats.size
  end

  def validate_index_integrity
    return if self.is_use_entire
    self.view_morphing_attributes.keys.each do |key|
      errors.add(key, "must be greater than or equal to #{self.index_base.to_s}") unless self.send(key) >= 0
    end
  end

  def validate_cross_index_integrity
    return if self.is_use_entire
    if self.begin_measure_index > self.end_measure_index
      errors[:base] << "Begin measure index must be less than or equal to end measure index"
    end
    if (self.begin_measure_index == self.end_measure_index) and (self.begin_beat_index > self.end_beat_index)
      errors[:base] << "Begin beat index must be less than or equal to end beat index for the same measure"
    end
  end

  def to_audio
    {classic_ticks_per_minute: self.classic_ticks_per_minute,
     classic_ticks_per_beat: self.classic_ticks_per_beat,
     is_loop: self.is_loop,
     is_background_tick: self.is_background_tick,
     is_classic_tick: self.is_classic_tick,
     is_right_hand_tick: self.is_right_hand_tick,
     is_left_hand_tick: self.is_left_hand_tick,
     is_stereo_for_right_left: self.is_stereo_for_right_left,
     is_log_usage: self.is_log_usage,
     is_log_settings: self.is_log_settings_if_log_usage}
  end

  def log_output
    result =
    "Classic ticks per minute: " + self.classic_ticks_per_minute.to_s + "\n" +
    "Classic ticks per beat: " + self.classic_ticks_per_beat.to_s + "\n" +
    "\n" +
    "Background tone?: " + self.is_background_tick.to_s + "\n" +
    "Background tone on all ticks?: " + self.is_background_on_all_ticks.to_s + "\n" +
    "Classic tone?: " + self.is_classic_tick.to_s + "\n" +
    "Mute right & left for classic?: " + self.is_mute_right_and_left_for_classic.to_s + "\n" +
    "Right hand tone?: " + self.is_right_hand_tick.to_s + "\n" +
    "Left hand tone?: " + self.is_left_hand_tick.to_s + "\n" +
    "Right/Left in stereo?: " + self.is_stereo_for_right_left.to_s + "\n" +
    "Loop?: " + self.is_loop.to_s + "\n" +
    "Use Entire Piece?: " + self.is_use_entire.to_s + "\n"

    if not self.is_use_entire then
      result += "\n" +
      "Begin beat index: " + self.display_begin_beat_index.to_s + "\n" +
      "Begin measure index: " + self.display_begin_measure_index.to_s + "\n" +
      "End beat index: " + self.display_end_beat_index.to_s + "\n" +
      "End measure index: " + self.display_end_measure_index.to_s + "\n"
    end
    result
  end
end
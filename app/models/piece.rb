class Piece < Object
  include Mongoid::Document

  field :composer, type: String, default: ''
  field :name, type: String, default: ''
  field :catalog_reference, type: String, default: ''

  embeds_many :measures
  embeds_one :metronome_setting, autobuild: true
  embeds_one :log, autobuild: true
  belongs_to :user

  validates :name,:composer, presence:true, allow_blank:false
  validate :validate_unique_combination_for_composer_and_name

  attr_accessor :metronome

  def initialize_copy
    self.measures = self.measures.clone
    self.metronome_setting = self.metronome_setting.clone
    self.log = self.log.clone
  end

  def beats
    self.measures.collect{|each| each.beats}.flatten
  end

  def metronome
    @metronome ||= PolyrhythmicMetronome.new(self)
  end

  def to_s
    string = self.composer.to_s + ', ' + self.name.to_s
    string = string + ', ' + self.catalog_reference.to_s unless (self.catalog_reference.nil? or self.catalog_reference.empty?)
    string
  end

  def to_audio
    self.metronome.to_audio
  end

  def validate_unique_combination_for_composer_and_name
    return if self.user.nil?
    if self.user.pieces.where(composer: self.composer, name: self.name).ne(id: self.id).exists?
      errors[:base] << "Combination of composer and name must be unique for piece (within user)"
    end
  end
end

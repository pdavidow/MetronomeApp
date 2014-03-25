require "#{Rails.root}/lib/base_class_extensions/object"

class AbstractLibraryPiece < Object
  def self.archive
    @archive ||= self.create_piece
  end

  def self.reset
    @archive.destroy unless @archive.nil?
    @archive = nil
  end

  def self.create_piece
    piece = Piece.create(
        name: self.my_name,
        composer: self.composer,
        catalog_reference: self.catalog_reference)
    self.push_measures(piece)
    self.set_metronome_setting(piece.metronome_setting)
    self.add_log_entry(piece.log)
    piece.save!
    piece
  end

  def self.my_name #plain 'name' causes trouble w/ raising error in subclass_implementation
    self.subclass_implementation
  end

  def self.composer
    self.subclass_implementation
  end

  def self.catalog_reference
  end

  def self.push_measures(piece)
    self.subclass_implementation
  end

  def self.set_metronome_setting(setting)
  end

  def self.add_log_entry(log)
  end
end


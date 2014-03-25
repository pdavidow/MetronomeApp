class Library < Object

  def self.archives
    AbstractLibraryPiece.subclasses.collect{|each| each.archive}
  end

  def self.reset
    AbstractLibraryPiece.subclasses.each{|each| each.reset}
  end

  def self.import_piece_for_user(piece, user)
    clone =  piece.clone
    clone.log.entries.new(contents: "Import from library.")
    user.pieces.push(clone)
    clone
  end
end
module GonAudioHelper
  def gon_audio_for_piece(piece)
    gon.audio_data = piece.to_audio
  end
end